
import QtQuick 1.1
import com.nokia.meego 1.0

BasicListPage {
    id: mainListPage
    model: pagemodel
    title: "Configuration"

    ListModel {
        id: pagemodel


        ListElement {
            page: "ConfigurationVersionInfo.qml"
            title: "Software version"
            subtitle: "Current system software version"
        }

        ListElement {
            page: "ConfigurationQmlInfo.qml"
            title: "QML"
            subtitle: "Installed QML packages"
        }
        ListElement {
            page: "ConfigurationFontInfo.qml"
            title: "Fonts"
            subtitle: "Installed fonts"
        }
        ListElement {
            page: "ConfigurationServiceInfo.qml"
            title: "Services"
            subtitle: "Registered system services"
        }

        ListElement {
            page: "ConfigurationNetworkInfo.qml"
            title: "Network"
            subtitle: "Current networks & interfaces"
        }

        ListElement {
            page: "ConfigurationSyncInfo.qml"
            title: "Synchronization timers"
            subtitle: "Device synchronization state"
        }

    }



}

