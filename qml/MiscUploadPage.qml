
import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.1

import "Benchmark.js" as Benchmark
import "Pastebin.js" as Pastebin

BasicPage {
    id: page
    title: "System logs etc."
    hasBack: !working

    property bool working: false
    property string url: ""

    // -------------------------------------------------------

    function get_requested_logs()
    {
        var text = "";

        // always include version header

        text += "SYSTEM INFO:\n";
        text += " * OS version = " + platform.getSystemVersion(1) + "\n";
        text += " * Qt version = " + platform.getSystemVersion(2) + "\n";
        text += " * Qt.Mobility version = " + platform.getSystemVersion(4) + "\n";
        text += " * Firmware version = " + platform.getSystemVersion(3) + "\n";


        var pipe = "";
        if(muchLast.checked) pipe = "tail -n 50"
        else if(muchFirst.checked) pipe = "head -n 50"

        if(includeSyslog.checked)
            text += "\n\nSYSLOG:\n" + platform.getProcessOutput("/bin/cat /var/log/syslog", pipe);

        if(includeDmesg.checked)
            text += "\n\nDMESG:\n" + platform.getProcessOutput("dmesg", pipe);

        if(includeTop.checked)
            text += "\n\nPROCESSES (TOP):\n" + platform.getProcessOutput("top -b -n1", ""); // NO LIMIT

        if(includePs.checked)
            text += "\n\nPROCESSES (PS):\n" + platform.getProcessOutput("ps afux", ""); // NO LIMIT


        return text;
    }

    function show_banner(text_)
    {
        banner.text = text_;
        banner.show();
    }

    function do_upload_pastebin()
    {
        try {
            var title_ = title.text;
            var text = get_requested_logs();

            page.url= "";
            page.working = true;
            Pastebin.post(text, title_,
                          function on_success(url) {
                              page.working = false;
                              show_banner("UPLOAD TO PASTEBIN -  " + url);
                              page.url = url;
                              console.log("SUCCESS", url);

                          },
                          function on_failure(why) {
                              page.working = false;
                              show_banner("FAILED TO UPLOAD TO PASTEBIN: " + why);
                                console.log("FAILURE", why);
                          }
                          );

        } catch(err) {
            page.working = false;
            page.url = url;
            show_banner("Failed (internal error: " + err + ")");
            console.log("ERROR", err);
        }
    }

    function browse_paste()
    {
        Qt.openUrlExternally( page.url);
    }

    function share_paste()
    {
        var ret = platform.shareUrl(url, title.text);
        if(ret != "") show_banner(ret); // ERROR ?
    }
    
    function do_email()
    {
        try {
            var title_ = title.text;
            var text_ = get_requested_logs();
            var cmd = "mailto:" + "?subject=" + encodeURI(title_) + "&body=" + text_;            
            Qt.openUrlExternally(cmd);
        } catch(err) {
            show_banner("Failed (internal error: " + err + ")");
            console.log("ERROR", err);            
        }
    }
    
    // -------------------------------------------------------

    Flickable {
        id: flick
        anchors.fill: parent.canvas
        contentWidth: width
        contentHeight: cols.height

        flickableDirection:Flickable.VerticalFlick
        clip: true

        Column {
            id: cols
            width: parent.width
            spacing: theme_.defaultMargin
            visible: ! page.working

            Label {
                text: "Title"
                color: theme_.itemFontColor
            }
            TextField {
                id: title
                width: parent.width
                text: "Uploaded from SystemInfo"
            }

            Label {
                color: theme_.itemFontColor
                text: "Items to include"
            }

            ButtonColumn {
                exclusive: false
                anchors.horizontalCenter: parent.horizontalCenter

                Button {
                    id: includeSyslog
                    text: "System log *"
                    checkable: true
                    checked: true
                }
                Button {
                    id: includeDmesg
                    text: "Kernel messages *"
                    checkable: true
                    checked: false
                }
                Button {
                    id: includeTop
                    text: "Process list (TOP)"
                    checkable: true
                    checked: false
                }
                Button {
                    id: includePs
                    text: "Process list (PS)"
                    checkable: true
                    checked: false
                }

            }

            Label {
                color: theme_.itemFontColor
                text: "*: Included lines"
            }

            ButtonRow {
                exclusive: true
                anchors.horizontalCenter: parent.horizontalCenter

                Button {
                    id: muchAll
                    text: "All"
                    checkable: true
                }
                Button {
                    id: muchFirst
                    text: "First 50"
                    checkable: true
                    checked: false
                }
                Button {
                    id: muchLast
                    text: "Last 50"
                    checkable: true
                    checked: true
                }
            }
            
            Label {
                color: theme_.itemFontColor
                text: "Email your logs"
            }
            
            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Send by email"
                onClicked: do_email();
            }            
            
            Label {
                color: theme_.itemFontColor
                text: "Upload to pastebin"
            }

            Text {
                id: info
                text: "Please note that your logs can contain sensetive information. Once on pastebin, your logs can be seen by others!"
                font.family: theme_.subtitleFontFamily
                font.pixelSize: theme_.subtitleFontSize
                color: theme_.subtitleFontColor
                width: parent.width
                maximumLineCount: 3
                wrapMode: Text.Wrap
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Upload to pastebin"
                onClicked: do_upload_pastebin();
            }            
            
            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                enabled: page.url != "";
                text: "Open paste in browser"
                onClicked: page.browse_paste();
            }
            
            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                enabled: page.url != "";
                text: "Share paste url"
                iconSource: "image://theme/icon-m-toolbar-share"
                onClicked: page.share_paste();
            }            
        }
    }

    // -------------------------------------------------------

    ScrollDecorator {
        flickableItem: flick
    }

    BusyIndicator {
        anchors.centerIn: parent.canvas
        platformStyle: BusyIndicatorStyle { size: "large" }
        running: page.working
        visible: page.working

    }

    InfoBanner {
        id: banner
        text: ""
        width: parent.canvas.width
        anchors.top: parent.canvas.top
        timerShowTime: 1000 * 30
    }

}

