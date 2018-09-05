import QtQuick 2.0
import RestartHandler 1.0

Image {
    id: container
    scale: 0.0
    source: victory === true ? "qrc:/img/victory.png" : "qrc:/img/failed.png"

    property int steps: 0
    property bool victory: false

    RestartHandler {
        id: restartHandler
    }

    Behavior on scale {
        NumberAnimation { duration: 400 }
    }
    Behavior on x {
        NumberAnimation { duration: 400 }
    }
    Behavior on y {
        NumberAnimation { duration: 400 }
    }

    FontLoader { id: localFont; source: "qrc:/ttf/MFDingDing.otf" }

    Text {
        id: text
        x: 20
        y: 130
        font { family: localFont.name; pixelSize: 35 }
        color: "orangered"

        text: victory == true ? "你真棒! 一共用了 " + steps + " 步!" : "你没有抓住神经猫 ~(^(OO)^)~"
    }

    Image {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 40

        width: 150
        height: 80

        source: "qrc:/img/replay.png"

        MouseArea {
            anchors.fill: parent
            onClicked: restartHandler.restart()
        }
    }

    function show()
    {
        container.scale = 1.0;
        container.x = 60
        container.y = container.height / 3
    }
}
