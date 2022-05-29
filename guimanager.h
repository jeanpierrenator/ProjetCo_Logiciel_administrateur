#ifndef GUIMANAGER_H
#define GUIMANAGER_H
#include "sensormodel.h"
#include "jsonmanager.h"

#include <QObject>
#include <QQmlApplicationEngine>
#include <QQuickItem>
#include <QtQml/QQmlEngine>
#include <QQmlContext>


class GuiManager: public QObject
{
    Q_OBJECT
public:

    GuiManager(QObject *parent = nullptr);


    QQmlContext *getRootContext();
    void getSerialPortFromUser(QString &serialPort1);

    void show();
    QQuickItem *createSensorView();
private:
   std::unique_ptr<QQmlApplicationEngine> m_view {};
   std::map<QQuickItem*,SensorModel*> m_sensorViewMap {};
   JsonManager* m_jsonManager;

public slots:
   void handleOpenCom();
   void handleUpdateValue(QString period, QQuickItem *sensorView);
   void open();
   void saveFile();
   void handleNewSensor(QString name,int period);

signals:
   void signalOpenFile();
   void signalSaveFile(std::map<QQuickItem*,SensorModel*> map);
};

#endif // GUIMANAGER_H
