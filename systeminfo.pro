# Add more folders to ship with the application, here

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

QT+= declarative
symbian:TARGET.UID3 = 0xE877772E

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
CONFIG += mobility
MOBILITY += sensors systeminfo


# for the share function

CONFIG += shareuiinterface-maemo-meegotouch share-ui-common
#share-ui-plugin share-ui-common libtuiclient
#CONFIG += shareuiinterface-maemo-meegotouch share-ui-common share-ui-plugin


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += cpp/main.cpp \
    cpp/platformhelper.cpp \
    cpp/bench_int.cpp \
    cpp/bench_float.cpp \
    cpp/benchmarkworker.cpp


OTHER_FILES += \
    qml/*.qml \
    qml/*.png \
    qml/*.js \
    systeminfo.desktop \
    systeminfo.svg \
    systeminfo.png \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog

RESOURCES += \
    res.qrc \
    harmattan.qrc

# Please do not modify the following two lines. Required for deployment.
include(deployment.pri)
qtcAddDeployment()

# enable booster
CONFIG += qdeclarative-boostable
QMAKE_CXXFLAGS += -fPIC -fvisibility=hidden -fvisibility-inlines-hidden
QMAKE_LFLAGS += -pie -rdynamic

HEADERS += \
    cpp/platformhelper.h \
    cpp/benchmarkworker.h






splash.path = /opt/systeminfo
splash.files = splash.png
INSTALLS += splash
