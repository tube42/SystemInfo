#ifndef BENCHMARKWORKER_H
#define BENCHMARKWORKER_H

#include <QObject>

class QThread;
class PlatformHelper ;

// internal class for benchmark worker
class BenchmarkWorker : public QObject
{
    Q_OBJECT
private:
    int which;
    qreal score;
    PlatformHelper *owner;
    QThread *thread;

public:
    BenchmarkWorker(PlatformHelper *owner,int which);
    ~BenchmarkWorker();

    int getIndex() const { return which; }
    qreal getScore() const { return score; }

public slots:
    void run();

signals:
    void done(BenchmarkWorker *me);
};

#endif // BENCHMARKWORKER_H
