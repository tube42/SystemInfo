import QtQuick 1.0
import com.nokia.meego 1.0

import "Constants.js" as Constants

BasicPage {
    id: page
    title: "Installed fonts"

    ListView {
        id: listView
        anchors.fill: parent.canvas
        anchors.topMargin: theme.defaultMargin
        model: Qt.fontFamilies()
        delegate: dataDelegate
    }
    ScrollDecorator {
        flickableItem: listView
    }

    // list item delegate
    Component {
        id: dataDelegate
        Item {
            id: wrapper
            width: parent.width
            height: 3 * theme.defaultMargin + theme.titleFontSize + theme.itemFontSize

            Text {
                anchors.top: wrapper.top
                anchors.left:  wrapper.left
                anchors.topMargin: theme.defaultMargin

                text: "The quick brown fox jumps over the lazy dog"
                font.family: modelData
                font.pixelSize: theme.titleFontSize
                color: theme.titleFontColor
                clip: true
            }
            Text {
                anchors.bottom: wrapper.bottom
                anchors.right:  wrapper.right
                anchors.bottomMargin: theme.defaultMargin
                anchors.rightMargin: theme.defaultMargin

                text: modelData
                font.family: theme.itemFontFamily
                font.pixelSize: theme.itemFontSize
                color: theme.itemFontColor
            }
        }
    }
}
