import QtQuick 1.0
import com.nokia.meego 1.0

import "Constants.js" as Constants

BasicPage {
    id: page
    title: "QML packages"

    // page is busy until worker script is done
    Column {
        visible:  page.state != "ready"
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        spacing: theme_.defaultMargin

        BusyIndicator {
            anchors.horizontalCenter: parent.horizontalCenter
            platformStyle: BusyIndicatorStyle { size: "large" }
            running:  page.state != "ready"
        }
        Text {
            text: "Please wait..."
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: theme_.titleFontFamily
            font.pixelSize: theme_.titleFontSize
            color: theme_.titleFontColor
        }
    }


    // list stuff
    ListModel { id: dataModel }

    ListView {
        id: listView
        anchors.fill: parent.canvas
        anchors.topMargin: theme_.defaultMargin
        model: dataModel
        delegate: dataDelegate
        visible:  page.state == "ready"
    }
    ScrollDecorator {
        flickableItem: listView
    }


    // list item delegate
    Component {
        id: dataDelegate

        Column {
            anchors{ right: parent.right; rightMargin: 5; left: parent.left; leftMargin: 5 }
            height: 42 + theme_.titleFontSize + 2 * theme_.subtitleFontSize

            Label {
                text: lib
                font.family: theme_.titleFontFamily
                font.pixelSize: theme_.titleFontSize
                color: theme_.titleFontColor
                font.bold: true;
            }

            Label {
                text: "Present: " + present
                font.family: theme_.subtitleFontFamily
                font.pixelSize: theme_.subtitleFontSize
                color: "green"
            }
            Label {
                text: "Absent: " + absent
                font.family: theme_.subtitleFontFamily
                font.pixelSize: theme_.subtitleFontSize
                color: "red"
            }
        }
    }

    // call worker function some time _after_ the page has been initialised this
    // is really not needed but if we cal worker function directly then the page
    // will be shown with some delay which users (and Ovi QA) might not like.
    //
    // ideally, we would use WorkerScript instead, but WokerScript is currently
    // not allowed to call Qt.createQmlObject() so we use this ugly hack instead :(
    Timer {
        id: workDelayed
        interval:  1200
        running: true
        repeat: false
        onTriggered: populateList();
    }

    Component.onCompleted: page.state = "working";

    function populateList() {
        var index = 0;
        var libs = Constants.QML_PACKAGE_LIST;

        dataModel.clear();

        for(var key in libs) {
            var vs = libs[key];
            var present = "", absent = "";
            for(var i= 0; i < vs.length; i++) {
                var failed = false;
                try {
                    var code = "import " + key + " " + vs[i]+ "\nIAmNotHere{ }";
                    var newObject = Qt.createQmlObject(code, parent, "dynamicObject" + index++);
                } catch(err) {
                    // If the error is due to missing IAmNotHere, then the import was fine
                    if(("" + err).search("IAmNotHere") < 0 ) failed = true;
                    // console.log(err);
                }
                if(failed) absent += vs[i] + " ";
                else present += vs[i] + " ";
            }
            dataModel.append({ lib : key, present : present, absent: absent} );
        }
        page.state = "ready";
    }
}
