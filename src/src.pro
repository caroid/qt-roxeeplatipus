TEMPLATE = lib
QT = core widgets network

include($$PWD/../config/common.pri)

DEFINES += LIBROXEEPLATIPUS_LIBRARY

contains(ROXEE_LINK_TYPE, static){
    DEFINES += LIBROXEEPLATIPUS_USE_STATIC
}

INCLUDEPATH += $$PWD
INCLUDEPATH += $$PWD/include
target.path = $$DESTDIR
INSTALLS += target

copyToDestdir($$PWD/include/libroxeeplatipus/*.h, $$DESTDIR/../include/libroxeeplatipus)
copyToDestdir($$PWD/include/libroxeeplatipus/zerohello/*, $$DESTDIR/../include/libroxeeplatipus/zerohello)
copyToDestdir($$PWD/../res/redist/*, $$DESTDIR/../share/libroxeeplatipus)


SOURCES +=  $$PWD/root.cpp\
            $$PWD/powermanager.cpp \
            $$PWD/zerohello/browser.cpp \
            $$PWD/zerohello/registrar.cpp \
            $$PWD/zerohello/resolver.cpp \
    $$PWD/zerohello/genericzero.cpp
#            httpserver.cpp

HEADERS +=  $$PWD/include/libroxeeplatipus/libroxeeplatipus_global.h \
            $$PWD/include/libroxeeplatipus/root.h \
            $$PWD/include/libroxeeplatipus/lesserwindow.h \
            $$PWD/include/libroxeeplatipus/apputils.h \
            $$PWD/include/libroxeeplatipus/merguez.h \
            $$PWD/include/libroxeeplatipus/mediakeys.h \
            $$PWD/include/libroxeeplatipus/basepowermanagement.h \
            $$PWD/include/libroxeeplatipus/powermanager.h \
            $$PWD/include/libroxeeplatipus/QT425.h \
            $$PWD/include/libroxeeplatipus/zerohello/browser.h \
            $$PWD/include/libroxeeplatipus/zerohello/record.h \
            $$PWD/include/libroxeeplatipus/zerohello/registrar.h \
            $$PWD/include/libroxeeplatipus/zerohello/resolver.h \
            $$PWD/include/libroxeeplatipus/zerohello/genericzero.h
#            httpserver.h

win32{
    INCLUDEPATH += $$PWD/../src/win

    SOURCES += $$PWD/../src/win/apputils.cpp
    SOURCES += $$PWD/../src/win/merguez.cpp
    SOURCES += $$PWD/../src/win/mediakeys.cpp
    HEADERS += $$PWD/../src/win/powermanagementwindows.h
    SOURCES += $$PWD/../src/win/powermanagementwindows.cpp
    SOURCES += $$PWD/../src/win/lesserwindow.cpp
}

unix:!mac{
    INCLUDEPATH += $$PWD/../src/nux

    QT += dbus
    # The linux/dbus code is largely copied from  qBitTorrent Bittorrent Client,
    # Copyright (C) 2011  Vladimir Golovnev <glassez@yandex.ru>
    # Released under the GPL with an exception clause for OpenSSL
    HEADERS += $$PWD/../src/nux/powermanagementnux.h
    SOURCES += $$PWD/../src/nux/powermanagementnux.cpp

    SOURCES += $$PWD/../src/nux/apputils.cpp
    SOURCES += $$PWD/../src/nux/merguez.cpp
    SOURCES += $$PWD/../src/nux/mediakeys.cpp
    SOURCES += $$PWD/../src/nux/lesserwindow.cpp
}
mac{
    # Use Lion Fullscreen if available
    DEFINES += PLATIPUS_FULLSCREEN

    ###################
    # Dependencies
    ###################

    LIBS += -framework AppKit -framework IOKit
    INCLUDEPATH += $${PWD}/../third-party/SPMediaKeyTap
    INCLUDEPATH += $${PWD}/../third-party/apple_remote_control

    OBJECTIVE_SOURCES +=    $${PWD}/../third-party/apple_remote_control/AppleRemote.m\
                            $${PWD}/../third-party/apple_remote_control/RemoteControl.m\
                            $${PWD}/../third-party/apple_remote_control/MultiClickRemoteBehavior.m\
                            $${PWD}/../third-party/apple_remote_control/HIDRemoteControlDevice.m

    OBJECTIVE_HEADERS +=    $${PWD}/../third-party/apple_remote_control/AppleRemote.h\
                            $${PWD}/../third-party/apple_remote_control/RemoteControl.h\
                            $${PWD}/../third-party/apple_remote_control/MultiClickRemoteBehavior.h\
                            $${PWD}/../third-party/apple_remote_control/HIDRemoteControlDevice.h

    LIBS += -framework Carbon
    OBJECTIVE_HEADERS +=    $${PWD}/../third-party/SPMediaKeyTap/SPMediaKeyTap.h
    OBJECTIVE_SOURCES +=    $${PWD}/../third-party/SPMediaKeyTap/SPMediaKeyTap.m

    ####################
    ## Main lib
    ####################

    INCLUDEPATH += $$PWD/../src/mac

    # Cocoa helper
    HEADERS +=              $$PWD/../src/mac/cocoainit.h
    OBJECTIVE_SOURCES +=    $$PWD/../src/mac/cocoainit.mm

    # Implementation
    OBJECTIVE_SOURCES +=    $$PWD/../src/mac/apputils.mm
    OBJECTIVE_SOURCES +=    $$PWD/../src/mac/merguez.mm
    OBJECTIVE_SOURCES +=    $$PWD/../src/mac/mediakeys.mm
    OBJECTIVE_SOURCES +=    $$PWD/../src/mac/lesserwindow.mm

    HEADERS += $$PWD/../src/mac/powermanagementmac.h
    SOURCES += $$PWD/../src/mac/powermanagementmac.cpp
}
