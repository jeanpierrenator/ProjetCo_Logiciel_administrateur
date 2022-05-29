import QtQuick 2.15
import QtQml 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4
import QtQml.Models 2.15

//This Kind of icon is designed to represent an icon in my GUI with two sources and the possibility to enable or disable it.

Rectangle
{
    id:rectImg;

    property string src_enabled:    "";
    property string src_disabled:   "";
    property alias fillMode:        img.fillMode;
    property alias widthImg:        img.width;
    property alias heightImg:       img.height;
    property alias imgOpacity:      img.opacity;
    property alias paintedWidth:    img.paintedWidth;
    property alias paintedHeight:   img.paintedHeight;
    property alias rotation:        img.rotation;
    property alias showCadre:       frameHelp.visible;
    property alias mirror:          img.mirror;

    width:  img.width;
    height: img.height;
    color:  "transparent";

    Rectangle
    {
        id: frameHelp;
        z: -1;
        visible: false;
        anchors.fill: parent;
        color: "#55b7d6";
        opacity: 0.32;
        radius: 1;
    }

    Image
    {
        id: img;
        source: enabled ? src_enabled : src_disabled;
        opacity: parent.opacity;
        antialiasing: true;
        fillMode: Image.PreserveAspectFit;
    }
}
