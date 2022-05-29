import QtQuick 2.15
import QtQml 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4
import QtQml.Models 2.15



ToolBar {
  property int isOpen: 0 ;
    property string textCom:{
        if(!isOpen){
            "open file"
        }else{
            "close file"
        }
    }

    function openCom()
    {
        if(!isOpen){
            guiManager.open();
            isOpen = 1;
        }else{
            guiManager.open();
            isOpen = 0;
        }



    }
    function saveFile(){
        if(isOpen){
            guiManager.saveFile();
        }
    }

    id: toolBar;
    width: parent.width;
    height: 60;




    background: Rectangle {
        anchors.fill: parent
        color : "#f4f4f4";
        border.width: 2;
    }

    Row {
        id: row;
        width: parent.width - 100;
        height: 60;
        spacing: 2;

        IconView
        {
            id:             ico_file;
            src_enabled:    "qrc:/Image/Image/file.png";
            heightImg:      60;
            widthImg:       60;
            visible:        true;
            enabled:        true;

            MouseArea
            {
                z: 10;
                anchors.fill: parent;
                hoverEnabled: true;
                onMouseXChanged: toolTipFile.x = mouseX + 10;
                onMouseYChanged: toolTipFile.y = mouseY;

                onEntered:
                {
                    parent.showCadre    = true;
                    parent.z            = 15;
                    toolTipFile.startTimerAppearance();
                }

                onExited:
                {
                    parent.showCadre = false;
                    toolTipFile.close();
                }

                onClicked:
                {
                    toolBar.openCom();
                }
            }

            MyToolTip
            {
                id: toolTipFile;
                text: qsTr(textCom);
                opacity: 0;
            }
        }//ico_plus

        IconView
        {
            id:             ico_save;
            src_enabled:    "qrc:/Image/Image/diskette.png";
            heightImg:      60;
            widthImg:       60;
            visible:        true;
            enabled:        true;

            MouseArea
            {
                z: 10;
                anchors.fill: parent;
                hoverEnabled: true;
                onMouseXChanged: toolTipSave.x = mouseX + 10;
                onMouseYChanged: toolTipSave.y = mouseY;

                onEntered:
                {
                    parent.showCadre    = true;
                    parent.z            = 15;
                    toolTipSave.startTimerAppearance();
                }

                onExited:
                {
                    parent.showCadre = false;
                    toolTipSave.close();
                }

                onClicked:
                {
                    toolBar.saveFile();
                }
            }

            MyToolTip
            {
                id: toolTipSave;
                text: qsTr("save");
                opacity: 0;
            }
        }//ico_plus


    }
}
