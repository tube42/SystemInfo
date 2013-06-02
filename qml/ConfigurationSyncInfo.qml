import QtQuick 1.0
import QtMobility.systeminfo  1.2
import com.nokia.meego 1.0

import "Helper.js" as Helper

BasicDataPage {
    id: phoneInfo
    title: "Synchronization timer"

     AlignedTimer  {
        id: timer
    }

    Component.onCompleted: update();

    function update() {
        clear();

        append("Maximum interval", "" + timer.maximumInterval + " s");
        append("Minimum interval", "" + timer.minimumInterval + " s");
        append("Activated", timer.running ? "Yes" : "No");
    }


}
