import QtQuick 1.0
import QtMobility.systeminfo  1.2
import com.nokia.meego 1.0

import "Helper.js" as Helper

BasicDataPage {
    id: phoneInfo
    title: "Screen Info"

    DisplayInfo  {
        id: devinfo
        onOrientationChanged: update();
    }

    Component.onCompleted: update();

    function update() {
        clear();

        append("Colors", "" + devinfo.colorDepth + " bits");
        append("Size", "" + devinfo.physicalWidth + " x " + devinfo.physicalHeight + " mm");
        append("Dots Per Inch (DPI)", "" + devinfo.dpiWidth + " x " + devinfo.dpiHeight);

        append("Current brightness", "" + devinfo.displayBrightness );
        append("Current contrast", devinfo.contrast == -1 ? "Unknown" :  "" + Math.round(devinfo.contrast * 100) + "%");
        append("Current orientation", Helper.select( Helper.DISPLAY_ORIENTATION_NAMES, devinfo.orientation));
        append("Current backlight", Helper.select( Helper.DISPLAY_BACKLIGHT_NAMES, devinfo.backlightStatus));

    }
}
