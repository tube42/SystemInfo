import QtQuick 1.1

Rectangle {
    height: theme_.sectionFontSize + theme_.defaultMargin  * 2
    width: parent.width
    color: theme_.sectionAreaColor

    Text {
        anchors { verticalCenter: parent.verticalCenter; left: parent.left; right: parent.right; margins: 12 }
        font.family: theme_.sectionFontFamily
        font.pixelSize: theme_.sectionFontSize
        font.bold: true
        color: theme_.sectionFontColor
        text: section
        width: parent.width
        elide: Text.ElideLeft
    }
}
