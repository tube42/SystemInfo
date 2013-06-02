#ifndef PLATFORMHELPER_H
#define PLATFORMHELPER_H

#include <QObject>


class BenchmarkWorker;

class PlatformHelper : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool error READ getError)
    Q_PROPERTY(QString cpu_name READ getCpuName)
    Q_PROPERTY(QString cpu_features READ getCpuFeatures)
    Q_PROPERTY(QString cpu_bogomips READ getCpuBogomips)

    Q_PROPERTY(QString mem_total READ getMemTotal)
    Q_PROPERTY(QString mem_free READ getMemFree)

    Q_PROPERTY(QString mem_swap_total READ getMemSwapTotal)
    Q_PROPERTY(QString mem_swap_free READ getMemSwapFree)

    Q_PROPERTY(int sensorCount READ getSensorCount)


public:
    PlatformHelper(QObject *parent = 0);
    Q_INVOKABLE void forceUpdate();
    Q_INVOKABLE QString getSensorName(int index) const;
    Q_INVOKABLE QString getSensorDescription(int index) const;

    Q_INVOKABLE QString getSystemVersion(int index) const;
    Q_INVOKABLE bool getSystemFeature(int index) const;    

    Q_INVOKABLE QString getFile(QString filename) const;
    Q_INVOKABLE QString getProcessOutput(QString cmd, QString pipeTo) const;
    Q_INVOKABLE QString shareUrl(QString url, QString title) const;


    bool getError() const;
    QString getCpuName() const;
    QString getCpuFeatures() const;
    QString getCpuBogomips() const;

    QString getMemTotal() const;
    QString getMemFree() const;

    QString getMemSwapTotal() const;
    QString getMemSwapFree() const;

    int getSensorCount() const;


    // ------------------------------------------
    // benchmark:
    Q_INVOKABLE void runBenchmark(int which);

signals:
    void benchmarkResult(int which, qreal score);

public slots:
    void benchmarkEnded(BenchmarkWorker *worker);

private:
};


#endif // PLATFORMHELPER_H
