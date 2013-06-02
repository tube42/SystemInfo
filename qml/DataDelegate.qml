import QtQuick 1.1

Item {
    id: listItem
    height: theme.listItemHeight
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
                font.family: theme.titleFontFamily
                font.pixelSize: theme.titleFontSize
                color: theme.titleFontColor
                font.bold: true;
            }

            Text {
                id: subText
                text: desc
                font.family: theme.subtitleFontFamily
                font.pixelSize: theme.subtitleFontSize
                color: theme.subtitleFontColor
                visible: text != ""

                width: parent.width
                elide: Text.ElideLeft
                maximumLineCount: 4
                wrapMode: Text.Wrap
            }
        }
    }
}
