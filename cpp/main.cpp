#include <QtGui/QApplication>
#include <QtDeclarative>
#include <QFileSystemModel>

#include "platformhelper.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QDeclarativeView view;

    // add file system model
    QFileSystemModel model;
    model.setRootPath("/");
    view.rootContext()->setContextProperty("fsModel", &model);
//    qmlRegisterType<QFileSystemModel>("SystemInfo", 1, 0, "ImportedFileSystemModel");

    // add our own C++ component
    qmlRegisterType<PlatformHelper>("SystemInfo", 1, 0, "PlatformHelper");

    // and start the QML app
    view.setSource(QUrl("qrc:/qml/main.qml"));

    view.showFullScreen();
    return app.exec();
}
