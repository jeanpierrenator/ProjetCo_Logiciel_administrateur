#include "guimanager.h"


#include <QSerialPortInfo>
#include <QInputDialog>
#include <QDebug>
#include <QInputDialog>
#include <QQmlComponent>
#include <QPair>
#include <QFileDialog>
#include <QObject>

GuiManager::GuiManager( QObject *parent): QObject(parent)
{
  m_view = std::make_unique<QQmlApplicationEngine>();
  m_jsonManager = new JsonManager(this);
  this->show();
  this->getRootContext()->setContextProperty("guiManager",this);
  QObject::connect(this, &GuiManager::signalOpenFile,
                      m_jsonManager, &JsonManager::handleOpenFile);
  QObject::connect(m_jsonManager, &JsonManager::signalsNewSensor,
                      this, &GuiManager::handleNewSensor);
  QObject::connect(this, &GuiManager::signalSaveFile,
                      m_jsonManager, &JsonManager::handleSaveFile);
}

void GuiManager::show()
{
    m_view->load(QStringLiteral("qrc:/main.qml"));

}

QQmlContext *GuiManager::getRootContext()
{
    return m_view->rootContext();
}


void GuiManager::getSerialPortFromUser(QString &serialPort1)
{
    QStringList portNames;

    //Populate the  list
    foreach (const QSerialPortInfo &info, QSerialPortInfo::availablePorts())
    {
        portNames.append(info.portName());
    }

    portNames.prepend("");

    do
    {
        bool ok = false;

        serialPort1 = QInputDialog::getItem(new QWidget(nullptr, Qt::SubWindow), tr("Serial Port"),
                                           tr("Please select Serial Port:"), portNames, 0, false, &ok);
        if(false == ok)
            break;



    } while (serialPort1.isEmpty());

}

void GuiManager::handleOpenCom()
{
    QString portName ="";
    QQuickItem * item = this->createSensorView();
    SensorModel * sensor = new SensorModel("co2",8);
    m_sensorViewMap.insert(std::pair<QQuickItem*,SensorModel*>(item,sensor));

    item->setProperty("_type", sensor->getTypeSensor());
    item->setProperty("_measurementPeriod", sensor->getMeasurementPeriod());

    this->getSerialPortFromUser(portName);
     qDebug() << portName;
}

void GuiManager::handleNewSensor(QString name, int period){
    QQuickItem * item = this->createSensorView();
    SensorModel * sensor = new SensorModel(name,period);
    m_sensorViewMap.insert(std::pair<QQuickItem*,SensorModel*>(item,sensor));
    item->setProperty("_type", sensor->getTypeSensor());
    item->setProperty("_measurementPeriod", sensor->getMeasurementPeriod());

}


QQuickItem* GuiManager::createSensorView(){
    QQuickItem *sensorView = nullptr;

    try
    {
        // Getting the gridLayout object
        QObject *rowProbeLayout = m_view.get()->rootObjects().at(0)->findChild<QObject*>("rowLayoutProbes");

        // If the future parent object exists, try to create probe view item
        if (rowProbeLayout)
        {
            //Creating the component
            QQmlComponent sensorComponent(m_view.get(), QUrl(QStringLiteral("qrc:/SensorView.qml")));

            sensorView = qobject_cast<QQuickItem*>(sensorComponent.create());

            if(sensorView)
            {
                sensorView->setParentItem(qobject_cast<QQuickItem*>(rowProbeLayout));
            }
            else
            {
                throw std::runtime_error("Error during component creation");
            }
        }
    }
    catch (std::exception const& e)
    {
        qDebug() << "ERROR : " << e.what();
    }

    return sensorView;


}

void GuiManager::open()
{

       emit signalOpenFile();

}

void GuiManager::saveFile()
{
    emit signalSaveFile(m_sensorViewMap);
}

void GuiManager::handleUpdateValue(QString period, QQuickItem* sensorView){
    m_sensorViewMap.at(sensorView)->setMeasurementPeriod(period.toInt());
    qDebug() <<  m_sensorViewMap.at(sensorView)->getMeasurementPeriod();
}
