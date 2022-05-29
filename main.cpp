#include "guimanager.h"
#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QtQuick>
#include <QtCore/QDir>
#include <QtQml/QQmlEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{

    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    std::unique_ptr<GuiManager> guimanager = std::make_unique<GuiManager>();

    return app.exec();
}
