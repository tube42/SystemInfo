
import QtQuick 1.1
import com.nokia.meego 1.0

BasicListPage {
    id: mainListPage
    model: pagemodel
    hasBack: false
    title: "System Info"

    ListModel {
        id: pagemodel

        ListElement {
            page: "DeviceInfo.qml"
            title: "Device"
            subtitle: "Basic information about this device"
        }

        ListElement {
            page: "ConfigurationInfo.qml"
            title: "Configuration"
            subtitle: "Configuration of various parameters"
        }

        ListElement {
            page: "MiscellaneousPage.qml"
            title: "Miscellaneous"
            subtitle: "Various functions"
        }


        // last
        ListElement {
            page: "About.qml"
            title: "About"
            subtitle: "About this app"
        }

    }



}

