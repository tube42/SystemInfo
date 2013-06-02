
#include <QTime>
#include <QThread>
#include <QDebug>

#include "benchmarkworker.h"
#include "platformhelper.h"

// externals

extern void run_int_benchmark();
extern void run_float_benchmark();


// -------------------------------------------------

BenchmarkWorker::BenchmarkWorker(PlatformHelper *owner,int which)
    : QObject(0) // <-- note: must not have a parent
{
    qDebug() << Q_FUNC_INFO << QThread::currentThreadId();

    this->owner = owner;
    this->which = which;
    this->thread = new QThread();
    this->thread->setPriority( QThread::HighestPriority );

    this->moveToThread(this->thread);


    QObject::connect(
        this, SIGNAL(done(BenchmarkWorker *)),
        owner, SLOT(benchmarkEnded(BenchmarkWorker *)));
    QObject::connect(
        thread, SIGNAL(started()),
        this, SLOT(run()));

    this->thread->start();

}

BenchmarkWorker :: ~BenchmarkWorker()
{
    qDebug() << Q_FUNC_INFO << QThread::currentThreadId();
    // thread->stop();
    delete thread;
}

void BenchmarkWorker:: run()
{
    qDebug() << Q_FUNC_INFO << QThread::currentThreadId();


    QTime timer;
    timer.start();

    if(which == 0) run_int_benchmark();
    if(which == 1) run_float_benchmark();

    int elapsed = timer.elapsed();
    if(elapsed <= 0) elapsed = 1; // something went really wrong here

    qDebug() << "Bench " << which << ", elapsed " << elapsed; // DEBUG

    this->score = 100000.0 / elapsed;

    emit done(this);
}

