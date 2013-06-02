import QtQuick 1.0
import QtMobility.systeminfo  1.2
import com.nokia.meego 1.0

import "Helper.js" as Helper

BasicDataPage {
    id: phoneInfo
    title: "Network"
    hasUpdate: true

    NetworkInfo  {
        id: network
        monitorCurrentMobileNetworkCodeChanges: true
        monitorModeChanges: true
        monitorNameChanges: true
        monitorSignalStrengthChanges: true
        monitorStatusChanges: true

        onCurrentMobileCountryCodeChanged: update();
        onCurrentMobileNetworkCodeChanged: update();
        onModeChanged: update();
        onNameChanged: update();
        onSignalStrengthChanged: update();
        onStatusChanged: update();
    }


    Component.onCompleted: update();
    onUserUpdateRequest: update();

    function update() {
        clear();

        for(var i = 0; i < Helper.NETWORK_MODE_NAMES.length; i++) {
            var name = Helper.NETWORK_MODE_NAMES[i];
            network.mode = i;

            if ((network.networkName != null && network.networkName != "") || (network.macAddress != null && network.macAddress != "")) {
                if(name == null || name == "") name = "unknown interface";

                appendWithType("Network name", network.networkName, name );

                if(network.networkSignalStrength >= 0)
                    appendWithType("Signal strength", network.networkSignalStrength, name );

                appendWithType("Status", "" + network.networkStatus, name );

                if(network.macAddress != null && network.macAddress != "")
                    appendWithType("MAC", network.macAddress, name );

            }
        }


    }


}
