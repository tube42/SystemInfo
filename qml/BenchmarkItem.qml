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
//        height: Math.max(theme_.itemFontSize * 2, indicator.height) * 1.1

    spacing: theme_.defaultMargin

    Text {
        id: text
        text : ""
        font.family: theme_.titleFontFamily
        font.pixelSize: theme_.titleFontSize
        color : theme_.titleFontColor
    }

    Text {
        id: value
        text : ""
        font.family: theme_.titleFontFamily
        font.pixelSize: theme_.titleFontSize
        color : theme_.itemFontColor
    }
}


