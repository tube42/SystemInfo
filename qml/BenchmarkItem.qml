import QtQuick 1.1
import com.nokia.meego 1.0

// Column {
Grid {
    columns: 2

    property alias text: text.text
    property alias value: value.text
    property bool running: false

    anchors.left: parent.left
    anchors.right: parent.right
//        height: Math.max(theme.itemFontSize * 2, indicator.height) * 1.1

    spacing: theme.defaultMargin

    Text {
        id: text
        text : ""
        font.family: theme.titleFontFamily
        font.pixelSize: theme.titleFontSize
        color : theme.titleFontColor
    }

    Text {
        id: value
        text : ""
        font.family: theme.titleFontFamily
        font.pixelSize: theme.titleFontSize
        color : theme.itemFontColor
    }
}


