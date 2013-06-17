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
            height: 2 * theme_.sectionFontSize + theme_.defaultMargin
            width: parent.width
            color: theme_.sectionAreaColor
            Text {
                // anchors.centerIn:  parent
                anchors { verticalCenter: parent.verticalCenter; left: parent.left; right: parent.right; margins: 12 }

                font.family: theme_.sectionFontFamily
                font.pixelSize: theme_.sectionFontSize
                font.bold: true
                color: theme_.sectionFontColor
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
            height: childrenRect.height + theme_.defaultMargin  * 2
            spacing: theme_.defaultMargin / 2

            Item { width: 1; height:  theme_.defaultMargin / 2 } // space fix

            Text {
                text: serviceName
                font.family: theme_.titleFontFamily
                font.pixelSize: theme_.titleFontSize
                color: theme_.titleFontColor
                font.bold: true;
            }

            Text {
                id: subText
                text: "Version " + majorVersion + "." + minorVersion
                font.family: theme_.subtitleFontFamily
                font.pixelSize: theme_.subtitleFontSize
                color: theme_.subtitleFontColor
            }
        }
    }
}
