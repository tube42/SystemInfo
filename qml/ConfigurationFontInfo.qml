import QtQuick 1.0
import com.nokia.meego 1.0

import "Constants.js" as Constants

BasicPage {
    id: page
    title: "Installed fonts"

    ListView {
        id: listView
        anchors.fill: parent.canvas
        anchors.topMargin: theme_.defaultMargin
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
            height: 3 * theme_.defaultMargin + theme_.titleFontSize + theme_.itemFontSize

            Text {
                anchors.top: wrapper.top
                anchors.left:  wrapper.left
                anchors.topMargin: theme_.defaultMargin

                text: "The quick brown fox jumps over the lazy dog"
                font.family: modelData
                font.pixelSize: theme_.titleFontSize
                color: theme_.titleFontColor
                clip: true
            }
            Text {
                anchors.bottom: wrapper.bottom
                anchors.right:  wrapper.right
                anchors.bottomMargin: theme_.defaultMargin
                anchors.rightMargin: theme_.defaultMargin

                text: modelData
                font.family: theme_.itemFontFamily
                font.pixelSize: theme_.itemFontSize
                color: theme_.itemFontColor
            }
        }
    }
}
