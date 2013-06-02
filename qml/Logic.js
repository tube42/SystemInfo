

function pushPageFromFile(file) {
    setPageFile(file, false);
}

function setPageFromFile(file) {
    setPageFile(file, true);
}

function setPageFile(file, isRoot)
{
    var component = Qt.createComponent(file)

    if (component.status == Component.Ready) {
        if(isRoot) pageStack.clear();
        pageStack.push(component);
    } else {
        console.log("Error loading component:", component.errorString());
    }
}
