#include "sensormodel.h"

SensorModel::SensorModel(QString type, int period)
{
 typeSensor = type;
 measurementPeriod = period;
}

int SensorModel::getMeasurementPeriod() const
{
    return measurementPeriod;
}

void SensorModel::setMeasurementPeriod(int value)
{
    measurementPeriod = value;
}

QString SensorModel::getTypeSensor() const
{
    return typeSensor;
}

void SensorModel::setTypeSensor(const QString &value)
{
    typeSensor = value;
}
