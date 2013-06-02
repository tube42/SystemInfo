import QtQuick 1.1
import com.nokia.meego 1.0

import "Constants.js" as Constants

BasicPage {
    id: aboutPage
    title: "About"
    property int logosize: Math.min(width, height) * 0.8


    Flickable {
        anchors.fill: parent.canvas
        contentWidth: width
        contentHeight: text1.height

        flickableDirection : Flickable.VerticalFlick

        Text {
            id: text1
            anchors.centerIn: parent
            wrapMode: Text.Wrap
            textFormat: Text.RichText
            width: parent.width

            font.pixelSize: theme.itemFontSize
            font.family: theme.itemFontFamily
            color: theme.itemFontColor

            text:Constants.APP_ABOUT_TEXT
            onLinkActivated: Qt.openUrlExternally(link)

        }
    }

}
