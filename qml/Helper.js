

var BATTERY_STATUS_NAMES = [ "Undetermined", "Critical", "Very low", "Low", "Normal"];
var POWER_STATE_NAMES = [ "Error", "On battery", "On wall power", "On wall power & charging"];

var SIM_STATUS_NAMES = [ "0", "1", "2", "lock enabled" ];


var DISPLAY_ORIENTATION_NAMES = [ "Unknown", "Landscape", "Portrait", "Landscape (inverted)", "Portrait (inverted)"];
var DISPLAY_BACKLIGHT_NAMES = [ "Error or unknown", "Turned off", "Dimmed", "Turned on"];


var NETWORK_STATUS_NAMES = [ "Undefined", "No network", "Emergency only", "Searching",
                            "Connected", "Home network", "Denied", "Roaming" ];

var NETWORK_MODE_NAMES = [ "Unknown", "GSM", "CDMA", "W-CDMA", "Wlan", "Ethernet", "Bluetooth", "Wimax", "LTE" ]

// -----------------------------

function select(array, index)
{
    return (index < 0 || index >= array.length) ? "INVALID" : array[index];
}
