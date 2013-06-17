import QtQuick 1.0

Item {

    // workaround for Meego standard theme name mismatch
    property bool inverted: false

    // misc.
    property int defaultMargin: 18

    // fonts
    property string font1: "Nokia Pure Text"
    property string font2: "Nokia Pure Text Light"

    property string splashFontFamily: font1
    property string splashFontColor: "blue"
    property int splashFontSize: 62

    property string pageTitleFontFamily : font1
    property int  pageTitleFontSize: 30
    property string pageTitleFontColor: "#D0D0D0"
    property string pageTitleAreaColor:  "darkBlue"
    property int pageTitleAreaHeight: 18 * 2 + 30

    property string titleFontFamily: font1
    property int titleFontSize: 26
    property string titleFontColor: "#000000";

    property string subtitleFontFamily: font2
    property int subtitleFontSize: 20
    property string subtitleFontColor: "#cc6633";

    property string itemFontFamily: font1
    property int itemFontSize: 22
    property string itemFontColor: "black";


    property string sectionFontFamily : font1
    property int  sectionFontSize: 30
    property string sectionFontColor: "white"
    property string sectionAreaColor:  "darkGray"



    // lists
    property int listItemHeight: 98
    property string listBorderImage: "image://theme/meegotouch-list-background-pressed-center"
    property string listArrowImage:  "image://theme/icon-m-common-drilldown-arrow" + (theme_.inverted ? "-inverse" : "")

    property string listBorderImage_inverted: listBorderImage + "-inverse"
    property string listArrowImage_inverted:  listArrowImage + "-inverse"


}
