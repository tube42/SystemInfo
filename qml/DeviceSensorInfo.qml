import QtQuick 1.0
import com.nokia.meego 1.0

import SystemInfo 1.0

import "Helper.js" as Helper

BasicDataPage {
    id: phoneInfo
    title: "Sensor Info"

    Component.onCompleted: update();

    function update() {
        clear();

        for(var i = 0; i < platform.sensorCount; i++)
            append("Sensor " + platform.getSensorName(i), platform.getSensorDescription(i));
    }
}
