import QtQuick 2.0

Rectangle {
    id: circle
    height: 40
    width:  height
    radius: height / 2

    property int circleIndex
    property bool disabled: false

    signal clicked();

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(color != "#ff4500" && !circle.disabled) {
                color = "orangered";
                circle.clicked();
            }
        }
    }
}
