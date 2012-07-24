# Basic consumer variables
include(../vars.pri)

# Requires only core
QT = core gui

# Build a lib
TEMPLATE = lib
DEFINES += LIBROXEEPLATIPUS_LIBRARY

# Basic stuff (version and build/path magic)
include(../conf/confbase.pri)

contains(ROXEE_LINK_TYPE, static){
    DEFINES += LIBROXEEPLATIPUS_USE_STATIC
}

# Third-party stuff
exists(../third-party/bootstrap.pri){
    include(../third-party/bootstrap.pri)
}

# Windows specific configuration
win32{
    message( -> Targetting windows)
    include(../conf/confwin.pri)
}

# Mac specific configuration
mac{
    message( -> Targetting osx)
    include(../conf/confmacx.pri)
}

# Unix specific configuration
unix:!mac {
    message( -> Targetting *nux)
    include(../conf/confunix.pri)
}

INCLUDEPATH += $$PWD
INCLUDEPATH += $$PWD/include
target.path = $$DESTDIR
INSTALLS += target

SOURCES +=  $$PWD/root.cpp\
    $$PWD/powermanager.cpp

HEADERS +=  $$PWD/include/libroxeeplatipus/libroxeeplatipus_global.h \
            $$PWD/include/libroxeeplatipus/root.h \
            $$PWD/include/libroxeeplatipus/lesserwindow.h \
            $$PWD/include/libroxeeplatipus/apputils.h \
            $$PWD/include/libroxeeplatipus/merguez.h \
            $$PWD/include/libroxeeplatipus/mediakeys.h \
            $$PWD/include/libroxeeplatipus/basepowermanagement.h \
            $$PWD/include/libroxeeplatipus/powermanager.h

win32 {
    SOURCES += win/apputils.cpp
    SOURCES += win/merguez.cpp
    HEADERS += win/powermanagementwindows.h
    SOURCES += win/powermanagementwindows.cpp
}

!mac:!win32{
    SOURCES += nux/apputils.cpp
    SOURCES += nux/merguez.cpp
    QT += dbus
    # The linux/dbus code is largely copied from  qBitTorrent Bittorrent Client,
    # Copyright (C) 2011  Vladimir Golovnev <glassez@yandex.ru>
    # Released under the GPL with an exception clause for OpenSSL
    HEADERS += nux/powermanagementnux.h
    SOURCES += nux/powermanagementnux.cpp
}

