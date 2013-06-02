import QtQuick 1.1
import QtMobility.serviceframework 1.1
import com.nokia.meego 1.0

BasicPage {
    id: phoneInfo
    title: "Services"

    ServiceList {
        id: serviceList
    }

    ListView {
        id: listView
        anchors.fill: parent.canvas
        model: serviceList.services
        delegate: serviceDelegate

        section.property: "interfaceName"
        section.criteria: ViewSection.FullString
        section.delegate: serviceSectionDelegate
    }
    ScrollDecorator {
        flickableItem: listView
    }

    Component {
        id: serviceSectionDelegate

        Rectangle {
            height: 2 * theme.sectionFontSize + theme.defaultMargin
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
                maximumLineCount: 2
                wrapMode: Text.Wrap
            }
        }
    }

    Component {
        id: serviceDelegate

        Column {
            width: parent.width
            height: childrenRect.height + theme.defaultMargin  * 2
            spacing: theme.defaultMargin / 2

            Item { width: 1; height:  theme.defaultMargin / 2 } // space fix

            Text {
                text: serviceName
                font.family: theme.titleFontFamily
                font.pixelSize: theme.titleFontSize
                color: theme.titleFontColor
                font.bold: true;
            }

            Text {
                id: subText
                text: "Version " + majorVersion + "." + minorVersion
                font.family: theme.subtitleFontFamily
                font.pixelSize: theme.subtitleFontSize
                color: theme.subtitleFontColor
            }
        }
    }
}
