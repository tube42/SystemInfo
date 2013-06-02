
import QtQuick 1.1
import com.nokia.meego 1.0

import "Constants.js" as Constants

BasicPage {
    id: container

    ListModel { id: dataModel }

    ListView {
        id: listView
        anchors.fill: parent.canvas
        model: dataModel
        delegate: DataDelegate { }

        section.property: "type"
        section.criteria: ViewSection.FullString
        section.delegate: DataSectionDelegate { }
    }
    ScrollDecorator {
        flickableItem: listView
    }



    function clear()
    {
        dataModel.clear();
    }

    function append(text, desc)
    {
        if(text == null) text = "";
        if(desc == null) desc = "";

        dataModel.append({text : text, desc : desc, type: null } );
    }

    function appendWithType(text_, desc_, type_)
    {
        if(text_ == null) text_ = "";
        if(desc_ == null) desc_ = "";

        dataModel.append({text : text_, desc : desc_, type: type_ } );
    }
}

