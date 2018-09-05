import QtQuick 2.0

Image {
    id: container
    source: "qrc:/img/play_bg.jpg"
    width: 480
    height: 640

    property bool finish: false
    property int catIndex: 40
    property var circleArray: []

    MessagePanel {
        id: msgs
        width: container.width - 120
        height: container.height / 2
        z: 99
    }

    Column {
        id: column
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 20
        anchors.bottomMargin: 20
        anchors.rightMargin: 40

        spacing: 8

        Repeater {
            id: columnRepeater
            model: 9
            Row {
                id: row
                spacing: 8
                property int columnIndex: index

                Item {
                    id: stretch
                    width: (columnIndex % 2) * 16;    // 16 + 8 = 24 = ( 40 + 8 ) / 2
                    height: width
                }

                Repeater {
                    id: rowRepeater
                    model: 9
                    Circle {
                        circleIndex: columnIndex * 9 + index
                        disabled: container.finish
                        onClicked: {
                            circleArray.push(circleIndex);
                            runAway();
                        }

                        Component.onCompleted: {
                            color = (Math.random() * 100 < 10) ? "orangered" : "lightgrey";
                            if(color == "#ff4500") circleArray.push(circleIndex);
                        }
                    }
                }
            }
        }
    }

    SpriteSequence {
        id: cat
        x: container.width / 2 - 40
        y: container.height / 2
        Behavior on x {
            NumberAnimation { duration: 200 }
        }
        Behavior on y {
            NumberAnimation { duration: 200 }
        }

        width: sprite.frameWidth
        height: sprite.frameHeight
        interpolate: false

        sprites: [
            Sprite {
                id: sprite
                name: "stay"
                source: "qrc:/img/stay.png"
                frameWidth: 61
                frameHeight: 93
                frameCount: 16
                frameDuration: 120
            },
            Sprite {
                name: "trap"
                source: "qrc:/img/trap.png"
                frameWidth: 64
                frameHeight: 91
                frameCount: 15
                frameDuration: 80
            }

        ]
    }

    function runAway() {
        var oddCompensate;                // 奇数行补偿值
        if (Math.floor(catIndex / 9) % 2 == 0) oddCompensate = 0;
        else oddCompensate = 1;

        if(circleArray.indexOf(catIndex - 1) == -1) left();
        else if(circleArray.indexOf(catIndex - 10 + oddCompensate) == -1) leftUp();
        else if(circleArray.indexOf(catIndex - 9 + oddCompensate) == -1) rightUp();
        else if(circleArray.indexOf(catIndex + 1) == -1) right();
        else if(circleArray.indexOf(catIndex + 9 + oddCompensate) == -1)
            rightDown();
        else if(circleArray.indexOf(catIndex + 8 + oddCompensate) == -1)
            leftDown();
        // 神经猫被围住
        else {
            cat.jumpTo("trap");
            msgs.victory = true
            container.finish = true
            msgs.show()
        }

        // 神经猫逃脱
        if (catIndex < 9 || catIndex > 72 || catIndex % 9 == 0 || (catIndex + 1 ) % 9 == 0) {
            msgs.victory = false
            container.finish = true
            msgs.show()
        }

        msgs.steps += 1;
    }

    function left() {
        cat.x -= 48;
        catIndex -= 1;
    }
    function leftUp() {
        cat.x -= 24;
        cat.y -= 48;
        // 偶数行向左上运动减10,奇数行减9
        if (Math.floor(catIndex / 9) % 2 == 0) catIndex -= 10;
        else catIndex -= 9;
    }
    function rightUp() {
        cat.x += 24;
        cat.y -= 48;
        // 偶数行向右上运动减9,奇数行减8
        if (Math.floor(catIndex / 9) % 2 == 0) catIndex -= 9;
        else catIndex -= 8;
    }
    function right() {
        cat.x += 48;
        catIndex += 1;
    }
    function rightDown() {
        cat.x += 24;
        cat.y += 48;
         // 偶数行向右下运动加9,奇数行加10
        if (Math.floor(catIndex / 9) % 2 == 0) catIndex += 9;
        else catIndex += 10;
    }
    function leftDown() {
        cat.x -= 24;
        cat.y += 48;
        // 偶数行向左下运动加8,奇数行加9
        if (Math.floor(catIndex / 9) % 2 == 0) catIndex += 8;
        else catIndex += 9;
    }
}
