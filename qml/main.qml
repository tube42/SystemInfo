import QtQuick 1.1
import QtMobility.systeminfo  1.1
import com.nokia.meego 1.0

import SystemInfo 1.0

PageStackWindow {
    id: pagestack

    UserTheme { id: theme }
    PlatformHelper { id: platform }

    initialPage: MainListPage { }
    // initialPage: Splash{ }

}

