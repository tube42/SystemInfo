
import QtQuick 1.1
import com.nokia.meego 1.0

import "Logic.js" as Logic
import "Constants.js" as Constants

BasicPage {
    property ListModel model
    id: container


    ListView {
        id: listView
        // anchors.fill: parent
        anchors.fill: parent.canvas
        model: container.model
        pressDelay: 140

        delegate:  Item {
            id: listItem
            height: theme.listItemHeight
            width: parent.width

            BorderImage {
                id: background
                anchors.fill: parent
                // Fill page porders
                anchors.leftMargin: -container.anchors.leftMargin
                anchors.rightMargin: -container.anchors.rightMargin
                visible: mouseArea.pressed
                source: theme.listBorderImage
            }

            Row {
                anchors.fill: parent

                Column {
                    anchors.verticalCenter: parent.verticalCenter

                    Label {
                        id: mainText
                        text: model.title
                        font.family: Constants.TITLE_FONT;
                        font.pixelSize: Constants.TITLE_FONT_SIZE;
                        font.bold: true;
                        color: Constants.TITLE_COLOR;
                        visible: model.page != ""
                    }

                    Label {
                        id: subText
                        text: model.subtitle
                        font.family: Constants.SUBTITLE_FONT
                        font.pixelSize: Constants.SUBTITLE_FONT_SIZE
                        color: Constants.SUBTITLE_COLOR
                        visible: text != ""
                    }
                }
            }

            Image {
                id: theArrow
                source: theme.listArrowImage
                anchors.right: parent.right;
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                id: mouseArea
                anchors.fill: background
                visible: page != null
                onClicked: {
                    if(page)
                    Logic.pushPageFromFile(page)
                }
            }
        }
    }
    ScrollDecorator {
        flickableItem: listView
    }


}

