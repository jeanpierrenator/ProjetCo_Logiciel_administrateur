#ifndef SENSORMODEL_H
#define SENSORMODEL_H

#include <QLatin1String>
#include <QString>



class SensorModel
{
public:
    SensorModel(QString type, int period);

    int getMeasurementPeriod() const;
    void setMeasurementPeriod(int value);

    QString getTypeSensor() const;
    void setTypeSensor(const QString &value);

private:
    QString typeSensor;
    int measurementPeriod;
};

#endif // SENSORMODEL_H
