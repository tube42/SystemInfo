import QtQuick 1.0
import com.nokia.meego 1.0

import "Helper.js" as Helper

BasicDataPage {
    id: phoneInfo
    title: "CPU Info"
    hasUpdate: true

    Component.onCompleted: update();
    onUserUpdateRequest:  {
        platform.forceUpdate();
        update();
    }

    function update() {
        clear();

        if(platform.error) {
            append("Native CPU information", "Not available");
        } else {

            if(platform.cpu_name != "") append("CPU", platform.cpu_name );
            if(platform.cpu_features != "") append("CPU features", platform.cpu_features );
            if(platform.cpu_bogomips != "") append("CPU speed", platform.cpu_bogomips + " BogoMIPS");

            if(platform.mem_total != "") append("Total memory", platform.mem_total );
            if(platform.mem_free != "") append("Free memory", platform.mem_free );
            if(platform.mem_swap_total != "") append("Total swap", platform.mem_swap_total );
            if(platform.mem_swap_free != "") append("Free swap", platform.mem_swap_free );
        }        
    }    
}
