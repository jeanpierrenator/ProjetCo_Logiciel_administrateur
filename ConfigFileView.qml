import QtQuick 2.0
import QtQuick.Layouts 1.12
Item {
    Layout.fillHeight:true
    Layout.preferredWidth: 800
    Layout.preferredHeight: 60
    Row {
        id: row
        width: parent.width
        height: parent.height

        ConfigFileToolBarView{

        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
