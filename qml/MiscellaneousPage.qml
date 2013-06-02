
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
            title: "Upload logs"
            subtitle: "Upload phone logs to pastebin"
        }


        ListElement {
            page: "BenchmarkPage.qml"
            title: "Benchmark"
            subtitle: "Benchmark your device"
        }
/*
        ListElement {
            page: "FileBrowserPage.qml"
            title: "Files"
            subtitle: "A MINIMAL file browser"
        }
*/
    }

}

