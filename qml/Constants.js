
var APP_VERSION = "0.5.2"
var APP_ABOUT_LINK = ""
var APP_ABOUT_TEXT =  "System Info (beta release)" +
    "<p>Version " + APP_VERSION + "\n" +
    "<p>by TUBE42 - <a href=\"mailto:av@tube42.se\">av@tube42.se</a>, " +
    "<a href=\"https://twitter.com/tube42\">@tube42</a> " +
    "<p><br>" +
    "<p>SystemInfo is a tiny utility for examining various aspects of your MeeGo/Harmattan device. " +
    "It is primarily used by developers and modders, but can also be of use to normal users " +
    "who experience problems with their device or want to know more about MeeGo and Harmattan."+
    "<p><br>" +
    "<p>The QML source code is available at " +
    "<a href=\"https://github.com/tube42/SystemInfo\">GitHub</a>"+
    " under the GPLv3 license. " +
    "Please contact the author via <a href=\"https://twitter.com/tube42\">twitter</a> to suggest improvements, request features and report bugs."

// -----------------------------------------

var QML_PACKAGE_LIST = {
    "Qt" : [ "4.7", "4.8", "5.0"],
    "QtQuick" :["1.0", "1.1", "1.2", "2.0" ],
    "QtDesktop" : ["0.1", "0.2", "1.0"],
    "Qt3D" : [ "1.0"],
    "com.nokia.symbian" : ["1.0", "1.1", "1.2"],
    "com.meego" : [ "1.0", "1.1", "1.2", "2.0" ],
    "com.nokia.meego" : [ "1.0", "1.1", "1.2", "2.0" ],
    "Qt.labs.particles" : ["1.0"],
    "Qt.labs.components" : ["1.0", "1.1" , "1.2"],
    "Qt.labs.components.native" : ["1.0", "1.1" , "1.2"],
    "MeeGo.Labs.Components" : ["0.1", "0.2" , "1.0"],
    "MeeGo.Components" : ["0.1", "0.2" , "1.0"]
};

// -----------------------------------------

var FONT1 = "Nokia Pure Text"
var FONT2 = "Nokia Pure Text Light"


var DEFAULT_MARGIN = 18;

var SPLASH_FONT = FONT1;
var SPLASH_FONT_COLOR = "blue"
var SPLASH_FONT_SIZE = 62


var PAGE_TITLE_FONT = FONT1;
var PAGE_TITLE_FONT_SIZE = 30;
var PAGE_TITLE_COLOR = "#D0D0D0";
var PAGE_TITLE_AREA_COLOR = "darkBlue";


var TITLE_FONT = FONT1;
var TITLE_FONT_SIZE = 26;
var TITLE_COLOR = "#000000";

var SUBTITLE_FONT = FONT2;
var SUBTITLE_FONT_SIZE = 20;
var SUBTITLE_COLOR = "#cc6633";


