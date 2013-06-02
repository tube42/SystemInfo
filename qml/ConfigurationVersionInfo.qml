import QtQuick 1.0
import QtMobility.systeminfo  1.2
import com.nokia.meego 1.0

// import "Helper.js" as Helper

BasicDataPage {
    id: phoneInfo
    title: "System software version"

    Component.onCompleted: update();

    function update() {
        clear();

        append("OS version", platform.getSystemVersion(1));

        append("Qt version", platform.getSystemVersion(2));
        append("Qt Mobility version", platform.getSystemVersion(4));

        append("Unit firmware version", platform.getSystemVersion(3));
    }
}
