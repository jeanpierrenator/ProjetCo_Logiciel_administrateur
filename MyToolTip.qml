import QtQuick 2.15
import QtQml 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4
import QtQml.Models 2.15

Rectangle
{
    id: tooltip;
    height: tooltipText.height * 1.2;

    property real opacityHigh: 0.8;
    property real opacityLow: 0;
    property int showInterval : 0; //instantaneous
    property int closeInterval : 5000;
    property int pixelSize: 18;
    property int fadeInDelay;
    property int fadeOutDelay;
    property alias text: tooltipText.text;
    property alias font: tooltipText.font;

    color: "#f0f0f0";
    radius: 1;
    state: "";

    Timer
    {
        id: timerAppearance;
        interval: showInterval;
        onTriggered: show();
    }

    Timer
    {
        id: timerDisappearance;
        interval: closeInterval;
        onTriggered: close();
    }

    function startTimerAppearance()
    {
        if(true === timerAppearance.running)
        {
            timerAppearance.restart();
        }
        else
        {
            timerAppearance.start();
        }
        tooltipText.visible = true;
    }

    function show()
    {
        tooltip.width = tooltipText.width * 1.12;
        tooltip.fadeInDelay = fadeInDelay;
        tooltip.fadeOutDelay = fadeOutDelay;
        tooltip.state = "poppedUp";
        timerDisappearance.start();
    }

    function close()
    {
        if(timerAppearance.running)
        {
            timerAppearance.stop();
        }
        tooltip.state = "poppedDown";
    }

    function setText(str)
    {
        tooltipText.text = str;
        tooltip.width = tooltipText.width * 1.1;
    }


    // The object travels from an empty state(on creation) to 'poppedUp' state and then to 'poppedDown' state
    states: [
        State {
            name: "poppedUp"
            PropertyChanges { target: tooltip; opacity: opacityHigh }
        },

        State {
            name: "poppedDown"
            PropertyChanges { target: tooltip; opacity: opacityLow }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "poppedUp"
            PropertyAnimation { target: tooltip; property: "opacity"; duration: tooltip.fadeInDelay; }
        },

        Transition {
            from: "poppedUp"
            to: "poppedDown"
            PropertyAnimation { target: tooltip; property: "opacity"; duration: tooltip.fadeOutDelay; }
        },
        Transition {
            from: "poppedDown"
            to: "poppedUp"
            PropertyAnimation { target: tooltip; property: "opacity"; duration: tooltip.fadeInDelay; }
        }
    ]

    Text
    {
        id: tooltipText;
        font.bold: true;
        font.pixelSize: pixelSize;
        color: "#000000";
        anchors.centerIn: parent;
        visible: false;
    }
}
