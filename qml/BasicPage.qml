
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
        anchors.margins: theme_.defaultMargin
    }
    
    Rectangle {
        id: titleTextBackground
        width: parent.width
        height: theme_.pageTitleAreaHeight

        x: 0
        y: 0
        z: 2 // above everything else
        color: theme_.pageTitleAreaColor
//        visible: titletext.visible

        Label {
            id: titletext
            text: container.title
            anchors.verticalCenter: parent.verticalCenter
            x: 2 * theme_.defaultMargin

            font.family: theme_.pageTitleFontFamily
            font.pixelSize: theme_.pageTitleFontSize
            color: theme_.pageTitleFontColor
            // font.bold: true;
            visible: text != ""
        }        
    }       
}

