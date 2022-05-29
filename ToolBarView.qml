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
            "open com"
        }else{
            "close com"
        }
    }

    function openCom()
    {
       if(!isOpen){
       isOpen  =1;
         guiManager.handleOpenCom();
       }else{
           isOpen = 0;
       }
    }

    id: toolBar;
    width: parent.width;
    height: 60;




    background: Rectangle {
        anchors.fill: parent
        color : "#40434a";
    }

    Row {
        id: row;
        width: parent.width - 100;
        height: 60;
        spacing: 2;

        IconView
        {
            id:             ico_plus;
            src_enabled:    "qrc:/Image/Image/plus.png";
            heightImg:      60;
            widthImg:       60;
            visible:        true;
            enabled:        true;

            MouseArea
            {
                z: 10;
                anchors.fill: parent;
                hoverEnabled: true;
                onMouseXChanged: toolTipPlus.x = mouseX + 10;
                onMouseYChanged: toolTipPlus.y = mouseY;

                onEntered:
                {
                    parent.showCadre    = true;
                    parent.z            = 15;
                    toolTipPlus.startTimerAppearance();
                }

                onExited:
                {
                    parent.showCadre = false;
                    toolTipPlus.close();
                }

                onClicked:
                {
                    toolBar.openCom();
                }
            }

            MyToolTip
            {
                id: toolTipPlus;
                text: qsTr(textCom);
                opacity: 0;
            }
        }//ico_plus

        Button {
            id: file
            text: qsTr("config File")
        }

    }
}
