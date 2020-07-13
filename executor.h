#ifndef EXECUTOR_H
#define EXECUTOR_H

#include <QObject>
#include "QProcess"
#include "QDebug"
#include <QJsonObject>
#include "QJsonDocument"
#include "QJsonArray"
class Executor :public QObject
{
    Q_OBJECT
public:
    Executor();
signals:
   void sg_GetEnvironmentPath(const QString &value);

public slots:
    void getEnvironmentPath(); //qml 用大写开头报错
    void reWritePath(const QString &value);
};

#endif // EXECUTOR_H
