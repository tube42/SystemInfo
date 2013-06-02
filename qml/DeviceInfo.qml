
import QtQuick 1.1
import com.nokia.meego 1.0

BasicListPage {
    id: mainListPage
    model: pagemodel
    title: "Device Info"

    ListModel {
        id: pagemodel
        ListElement {
            page: "DeviceUnitInfo.qml"
            title: "Unit information"
            subtitle: "Information about this unit"
        }
        ListElement {
            page: "DeviceCpuInfo.qml"
            title: "CPU information"
            subtitle: "Information about the CPU"
        }


        ListElement {
            page: "DeviceSensorInfo.qml"
            title: "Sensor information"
            subtitle: "Information about the available sensors"
        }

        ListElement {
            page: "DeviceScreenInfo.qml"
            title: "Screen information"
            subtitle: "Information about the display"
        }

        ListElement {
            page: "DeviceBatteryInfo.qml"
            title: "Battery information"
            subtitle: "Battery status information"
        }
    }



}

