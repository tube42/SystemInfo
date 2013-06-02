
import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: container

    property bool hasBack: true
    property bool hasUpdate: false

    property string title: ""
    property Item canvas : usercanvas
    signal userUpdateRequest

    anchors.margins: 0
    orientationLock: PageOrientation.LockPortrait

    tools: ToolBarLayout {
        id: listpagetoolbar        
        ToolIcon {
            visible: hasBack
            iconId: "toolbar-back";
            onClicked: pageStack.pop();
        }

        ToolIcon {
            visible: hasUpdate
            iconId: "toolbar-refresh";
            onClicked: userUpdateRequest();
        }

    }


    // place holder for user lists
    Item {
        id: usercanvas

        anchors.left:  parent.left
        anchors.right:  parent.right
        anchors.top:  titleTextBackground.bottom
        anchors.bottom:  parent.bottom
        anchors.margins: theme.defaultMargin
    }

    Rectangle {
        id: titleTextBackground
        width: parent.width
        height: theme.pageTitleAreaHeight

        x: 0
        y: 0
        z: 1 // above everything else
        color: theme.pageTitleAreaColor
//        visible: titletext.visible

        Label {
            id: titletext
            text: container.title
            anchors.verticalCenter: parent.verticalCenter
            x: 2 * theme.defaultMargin

            font.family: theme.pageTitleFontFamily
            font.pixelSize: theme.pageTitleFontSize
            color: theme.pageTitleFontColor
            // font.bold: true;
            visible: text != ""
        }
    }
}

