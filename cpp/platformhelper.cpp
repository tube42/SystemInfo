#include "platformhelper.h"

#include <QFile>
#include <QTextStream>
#include <QStringList>
#include <QDebug>
#include <QList>
#include <QProcess>

#include <QSensor>
#include <QSystemInfo>


#include <MDataUri>
#include <maemo-meegotouch-interfaces/shareuiinterface.h>
// #include <ShareUI/shareuiinterface.h>


#include "benchmarkworker.h"

using namespace QtMobility;

class HelperWorker
{
private:
    static HelperWorker *instance_;
public:
    static HelperWorker *getInstance()
    {
        if(instance_ == 0) instance_ = new HelperWorker();
        return instance_;
    }
    static void forceUpdate()
    {
        instance_ = 0;
    }

    bool error;
    QString cpu_name, cpu_features, cpu_bogomips;
    QString mem_total, mem_free, mem_swap_total, mem_swap_free;
    QList<QString> sensor_names, sensor_descs;

    QList<QString> list_versions;
    QList<bool> list_features;

private:
    HelperWorker()
    {
        error = false;

        handle_file(0, "/proc/cpuinfo");
        handle_file(1, "/proc/meminfo");

        get_sensor_list();
        get_version_and_feature_list();
    }
    void handle_tag(int id, const QString & tag, const QString &data)
    {
        if(id == 0) {
            if(tag == "processor") cpu_name = data;
            else if(tag == "features") cpu_features = data;
            else if(tag == "bogomips") cpu_bogomips = data;
        } else if(id == 1) {
            if(tag == "memtotal") mem_total = data;
            else if(tag == "memfree") mem_free = data;
            else if(tag == "swaptotal") mem_swap_total = data;
            else if(tag == "swapfree") mem_swap_free = data;
        }
    }

    void handle_file(int id, const char *filename)
    {
        QString line;
        QFile f1(filename);

        if(f1.open(QIODevice:: ReadOnly)) {
            QTextStream ts(&f1);
            for(;;) {
                QString line = ts.readLine();
                if(line == "") break;

                QStringList list = line.split(":", QString:: SkipEmptyParts );

                if(list.length() == 2)
                    handle_tag(id, list[0].trimmed().toLower(), list[1].trimmed());
            }
            f1.close();
        } else error = true;
    }

    void get_sensor_list()
    {

        sensor_names.clear();
        sensor_descs.clear();

        QList<QByteArray> bs = QtMobility :: QSensor ::sensorTypes ();
        QByteArray b;
        foreach(b, bs) {
            sensor_names.append( QString(b));
            QtMobility :: QSensor s(b);
            if(!s.connectToBackend ()) continue;

            QString desc = s.description();
            sensor_descs.append(desc != "" ? desc : "No description found");
        }
    }

    void get_version_and_feature_list()
    {
        QSystemInfo si;
        list_versions.clear();
        list_features.clear();

        for(int i = 0; i < 8; i++)
            list_versions.append( si.version ( (QSystemInfo::Version) i ));

        for(int i = 0; i < 32; i++)
            list_features.append( si.hasFeatureSupported( (QSystemInfo::Feature) i));
    }
};
/*
        0	Bluetooth feature available.
QSystemInfo::CameraFeature	1	Camera feature available.
QSystemInfo::FmradioFeature	2	FM Radio feature available.
QSystemInfo::IrFeature	3	Infrared feature available.
QSystemInfo::LedFeature	4	LED's feature available.
QSystemInfo::MemcardFeature	5	Memory card feature available.
QSystemInfo::UsbFeature	6	Universal System Bus (USB) feature available.
QSystemInfo::VibFeature	7	Vibration feature available.
QSystemInfo::WlanFeature	8	Wireless Local Area Network (WLAN) feature available.
QSystemInfo::SimFeature	9	Subscriber Identity Module (SIM) available.
QSystemInfo::LocationFeature	10	Global Positioning System (GPS) and/or other location feature available.
QSystemInfo::VideoOutFeature	11	Video out feature available.
QSystemInfo::HapticsFeature	12	Haptics feature available.
*/

HelperWorker * HelperWorker :: instance_ = 0;


// ---------------------------------
PlatformHelper::PlatformHelper(QObject *parent)
    : QObject(parent)
{
    // get that work done right away...
    HelperWorker :: getInstance();

}

void PlatformHelper :: forceUpdate()
{
    HelperWorker :: forceUpdate();
}

bool PlatformHelper:: getError() const { return HelperWorker :: getInstance()->error; }

QString PlatformHelper :: getCpuName() const { return HelperWorker :: getInstance()->cpu_name; }
QString PlatformHelper :: getCpuFeatures() const { return HelperWorker :: getInstance()->cpu_features; }
QString PlatformHelper :: getCpuBogomips() const { return HelperWorker :: getInstance()->cpu_bogomips; }

QString PlatformHelper :: getMemTotal() const { return HelperWorker :: getInstance()->mem_total; }
QString PlatformHelper :: getMemFree() const { return HelperWorker :: getInstance()->mem_free; }
QString PlatformHelper :: getMemSwapTotal() const { return HelperWorker :: getInstance()->mem_swap_total; }
QString PlatformHelper :: getMemSwapFree() const { return HelperWorker :: getInstance()->mem_swap_free; }



int PlatformHelper :: getSensorCount() const
{
    return HelperWorker :: getInstance()->sensor_names.length();
}

QString PlatformHelper ::getSensorName(int index) const
{
    if(index < 0 || index >= getSensorCount()) return "??";
    return HelperWorker :: getInstance()->sensor_names[index];
}

QString PlatformHelper ::getSensorDescription(int index) const
{
    if(index < 0 || index >= getSensorCount()) return "??";
    return HelperWorker :: getInstance()->sensor_descs[index];
}

QString PlatformHelper ::getSystemVersion(int index) const
{
    return (index < 0 || index >= HelperWorker :: getInstance()->list_versions.length()) ?
                "Unknown" : HelperWorker :: getInstance()->list_versions[index];
}
bool PlatformHelper ::getSystemFeature(int index) const
{
    return (index < 0 || index >= HelperWorker :: getInstance()->list_features.length()) ?
                false : HelperWorker :: getInstance()->list_features[index];
}


// -------------------------------------------------------

void PlatformHelper ::runBenchmark(int which)
{
    new BenchmarkWorker(this, which);
}


void PlatformHelper ::benchmarkEnded(BenchmarkWorker *worker)
{
    int which = worker->getIndex();
    qreal score= worker->getScore();

    emit benchmarkResult(which, score);
    delete worker;
}


// ------------------------------------------------------
QString PlatformHelper ::getFile(QString filename) const
{
    QString ret;
    QFile f1(filename);

    if(f1.open(QIODevice:: ReadOnly)) {
        QTextStream ts(&f1);
        ret = ts.readAll();
        f1.close();
    } else ret = "<ERROR: could not open file " + filename + ">";

    return ret;
}

QString PlatformHelper ::getProcessOutput(QString command, QString pipeTo) const
{
    QString ret;

    if(pipeTo.length() == 0) {
        QProcess cmd;

        cmd.start(command);
        if (cmd.waitForFinished())  {
            ret = QString(cmd.readAll() );
        } else ret = "<ERROR: could not open file " + command + ">";
    } else {

        QProcess cmd1;
        QProcess cmd2;

        cmd1.setStandardOutputProcess(&cmd2);

        cmd1.start(command);
        cmd2.start(pipeTo);
        if (cmd2.waitForFinished())  {
            ret = QString(cmd2.readAll() );
        } else ret = "<ERROR: could not open file " + command + " | " + pipeTo +">";
    }
    return ret;
}



QString PlatformHelper :: shareUrl(QString url, QString title) const
    {
    MDataUri duri;
    duri.setMimeType ("text/x-url");
    duri.setTextData (url);
    duri.setAttribute ("title", title);
    if (!duri.isValid())  return "Unable to create sharing data";


    ShareUiInterface if_("com.nokia.ShareUi");
    QStringList data;
    data << duri.toString();

    if(if_.isValid() ) {
        if_.share(data);
        return "";
    } else {
        return "Could not open sharing interface";
    }
}
