import QtQuick 1.1

Rectangle {
    height: theme.sectionFontSize + theme.defaultMargin  * 2
    width: parent.width
    color: theme.sectionAreaColor

    Text {
        anchors.centerIn:  parent
        font.family: theme.sectionFontFamily
        font.pixelSize: theme.sectionFontSize
        font.bold: true
        color: theme.sectionFontColor
        text: section
        width: parent.width
        elide: Text.ElideLeft
    }
}
