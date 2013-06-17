import QtQuick 1.0
import com.nokia.meego 1.0

import SystemInfo 1.0

BasicPage {
    id: page
    title:  fsModel.rootPath

    tools: ToolBarLayout {
        id: listpagetoolbar
        ToolIcon {
            visible: hasBack
            iconId: "toolbar-back";
            onClicked: pageStack.pop();
        }
        ToolIcon {
            iconId: "toolbar-home";
            onClicked: onHome();
        }
        ToolIcon {
            iconId: "toolbar-mediacontrol-backwards";
            onClicked: onUpp();
        }
    }

    ListView {
        id: fileView
        anchors.fill:  parent.canvas
        focus: true
        model: fileModel
    }

    VisualDataModel {
        id: fileModel
        model: fsModel
        delegate: Rectangle {
            width: parent.width
            height: theme_.listItemHeight

            BorderImage {
                id: background
                anchors.fill: parent
//                    anchors.leftMargin: -container.anchors.leftMargin
//                    anchors.rightMargin: -container.anchors.rightMargin
                visible: mouseArea.pressed
                source: theme_.listBorderImage
            }

            Image {
                id: theArrow
                source: theme_.listArrowImage
                anchors.right: parent.right;
                anchors.verticalCenter: parent.verticalCenter
                visible: model.hasModelChildren
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: onSelect(fileView.model, index, model.hasModelChildren)
            }


            Column {
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    text: fileName
                    font.family: theme_.titleFontFamily
                    font.pixelSize: theme_.titleFontSize
                    font.bold:  true
                    color: theme_.titleFontColor
                }
                /*
                Text {
                    text: fsModel.size + ", " + fsModel.type
                    font.family: theme_.itemFontFamily
                    font.pixelSize: theme_.itemFontSize
                    color: theme_.itemFontColor
                } */
            }
        }
    }

    // -------------------------------------------

    function onSelect(model, index, isDir)
    {
        console.log("onSelect", model, index, isDir); // DEBUG

        if(isDir) fileView.model.rootIndex = fileView.model.modelIndex(index)
        // if (model.hasModelChildren) fileView.model.rootIndex = fileView.model.modelIndex(index)
    }

    function onHome()
    {
        console.log(" DEBUG: HOME ");
    }
    function onUpp()
    {
        console.log(" DEBUG: UPP");
    }

    Component.onCompleted: onSelect(fileView.mode, 0, true)
}
