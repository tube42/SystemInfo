
import QtQuick 1.1
import com.nokia.meego 1.0

BasicListPage {
    id: page
    model: pagemodel
    title: "Miscellaneous"

    ListModel {
        id: pagemodel

        ListElement {
            page: "MiscUploadPage.qml"
            title: "Logs"
            subtitle: "Email or upload phone logs"
        }


        ListElement {
            page: "BenchmarkPage.qml"
            title: "Benchmark"
            subtitle: "Benchmark your device"
        }
    }
}

