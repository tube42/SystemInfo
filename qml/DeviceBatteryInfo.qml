import QtQuick 1.0
import QtMobility.systeminfo  1.2
import com.nokia.meego 1.0

import "Helper.js" as Helper

BasicDataPage {
    id: phoneInfo
    title: "Battery Info"

    BatteryInfo {
        id: batInfo

        monitorCurrentFlowChanges: true
        monitorRemainingCapacityChanges: true
        monitorRemainingCapacityPercentChanges: true
        monitorRemainingChargingTimeChanges: true


        onCurrentFlowChanged: update();
        onRemainingCapacityChanged: update();
        onRemainingCapacityPercentChanged: update();
        onRemainingChargingTimeChanged: update();

    }

    DeviceInfo {
        id: devinfo

        monitorBatteryLevelChanges : true
        monitorBatteryStatusChanges : true
        monitorPowerStateChanges: true

        onBatteryLevelChanged: update();
        onBatteryStatusChanged: update();
        onPowerStateChanged: update();
    }

    Component.onCompleted: update();

    function update() {
        clear();

        append("Device battery", "Battery level is " + devinfo.batteryLevel);
        append("Battery status", Helper.select(Helper.BATTERY_STATUS_NAMES, devinfo.batteryStatus));
        append("Power state", Helper.select(Helper.POWER_STATE_NAMES, devinfo.currentPowerState));




        append("Battery nominal capacity", "" + batInfo.nominalCapacity  +" mAh");
        append("Battery remaining capacity", "" + batInfo.remainingCapacity  +" mAh");

        if(batInfo.remainingChargingTime > 0)
            append("Remaining charge time", "" + batInfo.remainingChargingTime  +" s");

        append("Current flow", "" + batInfo.currentFlow +" mA");
        append("Voltage", "" + batInfo.voltage +" mV");


    }


}
