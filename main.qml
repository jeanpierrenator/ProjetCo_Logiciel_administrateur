import QtQuick 2.15
import QtQml 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4
import QtQml.Models 2.15

//import "componentCreation.js" as MyScript

ApplicationWindow  {

    property variant _settingsView
    id: mainWindow;
    objectName: "mainWindow";
    visible: true;


    width: 800;
    height: 600;


    function showAboutView() {
        aboutView.show = true;
    }


    //Workaround to start maximized
    onObjectNameChanged:
    {
        //For high dpi screens, the interface will be messed up if it's not in fullscreen
        if (Screen.pixelDensity > 11) {
            mainWindow.showFullScreen();
        }
        else {
            mainWindow.showMaximized();
        }
    }



    Rectangle {
        anchors.fill: parent;
        color: "#f0f0f0";
        objectName: "rectangleLayout";
        ToolBarView {
            id: toolBar;
            objectName: "toolBar";
            z: parent.z + 1;
        }

        ColumnLayout {
            id: rlProbes;
            width: 400
            height: parent.height
            objectName: "rowLayoutProbes"

            anchors.top: toolBar.bottom;
            anchors.left: parent.left;
            anchors.right: parent.right;
            anchors.bottom: parent.bottom - diffView.height;
            anchors.rightMargin: 398
            anchors.topMargin: 10;

            ConfigFileView{

            }

        }


    }
}
