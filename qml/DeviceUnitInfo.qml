import QtQuick 1.0
import QtMobility.systeminfo  1.1
import com.nokia.meego 1.0

import "Helper.js" as Helper

BasicDataPage {
    id: phoneInfo
    title: "Unit Info"

    DeviceInfo {
        id: devinfo
    }

    Component.onCompleted: update();

    function update() {
        clear();

        append("Model", devinfo.model);
        append("Name", devinfo.productName);
        append("Manufacturer", devinfo.manufacturer);

        append("IMEI ", devinfo.imei );
        append("IMSI", devinfo.imsi);
        append("ID", devinfo.uniqueDeviceID);

        append("SIM modules", Helper.select( Helper.SIM_STATUS_NAMES, devinfo.simStatus) );

        var caps = "";
        if(platform.getSystemFeature(0)) caps += "Bluetooth "
        if(platform.getSystemFeature(1)) caps += "Camera "
        if(platform.getSystemFeature(2)) caps += "FM radio "
        if(platform.getSystemFeature(3)) caps += "Infrared "
        if(platform.getSystemFeature(4)) caps += "LED "
        if(platform.getSystemFeature(5)) caps += "Memory card "
        if(platform.getSystemFeature(6)) caps += "USB "
        if(platform.getSystemFeature(7)) caps += "Vibration "
        if(platform.getSystemFeature(8)) caps += "WLAN "
//        if(platform.getSystemFeature(9)) caps += "SIM "
        if(platform.getSystemFeature(10)) caps += "GPS "
        if(platform.getSystemFeature(11)) caps += "Video output "
        if(platform.getSystemFeature(12)) caps += "Haptics "

        append("Hardware capabilities", caps);

    }
}
