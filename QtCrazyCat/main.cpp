/*
 * @email: 287496607
 */
#include <QProcess>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "restarthandler.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<RestartHandler>("RestartHandler", 1, 0, "RestartHandler");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    int ret = app.exec();
    if (ret == 80) {
        QProcess::startDetached(qApp->applicationFilePath(), QStringList());
        return 0;
    }
    return ret;
}
