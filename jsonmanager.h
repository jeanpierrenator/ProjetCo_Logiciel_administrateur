#ifndef JSONMANAGER_H
#define JSONMANAGER_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QQuickItem>
#include <QtQml/QQmlEngine>
#include <QQmlContext>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include "sensormodel.h"

class JsonManager : public QObject
{
    Q_OBJECT
public:
    JsonManager(QObject *parent = nullptr);
    QString openFileSelector();
    void openFile(QString fileName);
    void closeFile();
    void parseJson();

public slots:
    void handleOpenFile();
    void handleSaveFile(std::map<QQuickItem*,SensorModel*> map);
private:
    QFile m_file;
    QJsonArray array_sensor;
    QJsonDocument m_json;
signals :
    void signalsNewSensor(QString name,int period);
};

#endif // JSONMANAGER_H
