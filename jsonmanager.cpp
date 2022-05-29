#include "jsonmanager.h"

#include <QFileDialog>

JsonManager::JsonManager( QObject *parent): QObject(parent)
{

}

QString JsonManager::openFileSelector()
{
    return QFileDialog::getOpenFileName(new QWidget(nullptr, Qt::SubWindow));
}

void JsonManager::openFile(QString fileName)
{
    m_file.setFileName(fileName);
    m_file.open(QIODevice::ReadWrite | QIODevice::Text);
}

void JsonManager::closeFile()
{
    m_file.close();
}

void JsonManager::parseJson()
{
    QJsonParseError jsonError;
    m_json =QJsonDocument::fromJson(m_file.readAll(),&jsonError);
    if (jsonError.error != QJsonParseError::NoError){
    qDebug() << jsonError.errorString();
    }

    QJsonObject json = m_json.object();
    array_sensor = json.value("sensor").toArray();

}

void JsonManager::handleOpenFile()
{
    QString fileName  = openFileSelector();
    openFile(fileName);
    parseJson();
    for(int i = 0; i < array_sensor.size(); i++){
       QJsonArray sensor = array_sensor[i].toArray();
        qDebug() <<  sensor[0].toInt();
        qDebug() <<  sensor[1].toString();
        qDebug() <<  sensor[2].toInt();
        emit signalsNewSensor(sensor[1].toString(),sensor[2].toInt());
    }
}

void JsonManager::handleSaveFile(std::map<QQuickItem *, SensorModel *> mapValue)
{
}

