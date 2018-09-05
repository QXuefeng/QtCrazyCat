#ifndef RESTARTHANDLER_H
#define RESTARTHANDLER_H

#include <QObject>
#include <QCoreApplication>

class RestartHandler : public QObject
{
    Q_OBJECT

public:
    explicit RestartHandler(QObject *parent = 0) : QObject(parent) {}

    Q_INVOKABLE void restart()
    {
        QCoreApplication::instance()->exit(80);
    }


};

#endif // RESTARTHANDLER_H
