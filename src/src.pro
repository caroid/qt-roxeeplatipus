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
INCLUDEPATH += $$PWD/include/libroxeeplatipus
target.path = $$DESTDIR
INSTALLS += target

SOURCES +=  root.cpp

HEADERS +=  include/libroxeeplatipus/libroxeeplatipus_global.h \
            include/libroxeeplatipus/root.h \
            include/libroxeeplatipus/lesserwindow.h \
            include/libroxeeplatipus/apputils.h \
            include/libroxeeplatipus/merguez.h \
            include/libroxeeplatipus/mediakeys.h

win32 {
    SOURCES += win/apputils.cpp
    SOURCES += win/merguez.cpp
}

!mac:!win32{
    SOURCES += nux/apputils.cpp
    SOURCES += nux/merguez.cpp
}

