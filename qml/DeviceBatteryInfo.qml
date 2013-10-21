import QtQuick 1.0
import QtMobility.systeminfo  1.2
import com.nokia.meego 1.0

import "Helper.js" as Helper

BasicDataPage {
    id: phoneInfo
    title: "Battery Info"

    property bool active: false

    BatteryInfo {
        id: batInfo

        monitorCurrentFlowChanges: phoneInfo.active
        monitorRemainingCapacityChanges: phoneInfo.active
        monitorRemainingCapacityPercentChanges: phoneInfo.active
        monitorRemainingChargingTimeChanges: phoneInfo.active

        monitorChargerTypeChanges: phoneInfo.active
        monitorChargingStateChanges : phoneInfo.active
        monitorNominalCapacityChanges : phoneInfo.active
        // monitorRemainingCapacityBarsChanges : phoneInfo.active


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

    // ------------------------------------------
    function update() {
        clear();

        append("Device battery", "Battery level is " + devinfo.batteryLevel);
        append("Battery status", Helper.select(Helper.BATTERY_STATUS_NAMES, devinfo.batteryStatus));
        append("Power state", Helper.select(Helper.POWER_STATE_NAMES, devinfo.currentPowerState));

        append("Battery capacity (current/max)",
               batInfo.remainingCapacity > 0.5 && batInfo.nominalCapacity > 0.5 ? 
               "" + batInfo.remainingCapacity + "/" + batInfo.nominalCapacity  +" mAh" :
               "Not available on this device");

//        append("Battery nominal capacity", "" + batInfo.nominalCapacity  +" mAh");
//        append("Battery remaining capacity", "" + batInfo.remainingCapacity  +" mAh");


        var rct = batInfo.remainingChargingTime;
        if(rct === 0) {
            append("Remaining charge time", "already fully charged!");
//        else if(rct === -1)
//            append("Remaining charge time", "no battery found :(");
        } else if(rct > 0) {
            append("Remaining charge time", "" + batInfo.remainingChargingTime  +" s");
        }
        
        append("Current flow", "" + batInfo.currentFlow +" mA");            
        append("Voltage", batInfo.voltage > 0.5 ? 
               ("" + batInfo.voltage +" mV") : 
               "Not available on this device");
    }


    onStatusChanged: {
        // console.log("STATUS=", status);
        active = (status === PageStatus.Active);
        update();
    }


    Component.onCompleted: update();
}
