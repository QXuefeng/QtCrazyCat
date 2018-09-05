import QtQuick 2.2
import QtQuick.Window 2.1

Window {
    id: window
    visible: true
    width: 480
    height: 640

    Loader {
        id: startPageLoader
        anchors.fill: parent
        source: "qrc:/StartPage.qml"
    }

    Loader { id: playingPageLoader; anchors.fill: parent }

    Connections {
        target: startPageLoader.item
        onStart: {
            playingPageLoader.source = "qrc:/PlayingPage.qml";
            startPageLoader.source = ""
        }
    }
}
