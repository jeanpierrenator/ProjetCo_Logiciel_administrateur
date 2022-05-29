import QtQuick 2.15
import QtQml 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4

Item {
    Layout.fillHeight:true
    Layout.preferredWidth: 400
    Layout.preferredHeight: 150
    Layout.topMargin: 10
    id: rltest
    property string _type
    property int _measurementPeriod

        function send(){
            guiManager.handleUpdateValue(textFieldPeriod.text,rltest);
        }
    RowLayout {


        Rectangle {
            id: rectangle
            width: 400
            height: 100
            color: "#ffffff"
            border.width: 2

            Rectangle {
                id: rectangle1
                width: 400
                height: 30
                color: "#000000"
                border.width: 2

                Text{
                    id: textType
                    text: _type
                    color: "#FFFFFF";
                }
            }

            GridLayout {
                id: gridLayout
                x: 0
                y: 36
                height: 50
                transformOrigin: Item.TopLeft
                columnSpacing: 8
                rowSpacing: 5
                rows: 3
                columns: 2

                Text {
                    id: textPeriod
                    text: qsTr("period(s)")
                }
                TextField {
                    id: textFieldPeriod
                    text: _measurementPeriod
                }

            }

            Button {
                id: button_send
                x: 292
                y: 50
                text: qsTr("send")
                onClicked: rltest.send()
            }
        }


    }


}







/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
