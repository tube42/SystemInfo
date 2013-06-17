import QtQuick 1.1

Item {
    id: listItem
    height: theme_.listItemHeight
    width: parent.width

    Row {
        anchors.fill: parent

        Column {
            // anchors.fill: parent
            width: parent.width
            // anchors.verticalCenter: parent.verticalCenter

            Text {
                id: mainText
                text: model.text
                font.family: theme_.titleFontFamily
                font.pixelSize: theme_.titleFontSize
                color: theme_.titleFontColor
                font.bold: true;
            }

            Text {
                id: subText
                text: desc
                font.family: theme_.subtitleFontFamily
                font.pixelSize: theme_.subtitleFontSize
                color: theme_.subtitleFontColor
                visible: text != ""

                width: parent.width
                elide: Text.ElideLeft
                maximumLineCount: 4
                wrapMode: Text.Wrap
            }
        }
    }
}
