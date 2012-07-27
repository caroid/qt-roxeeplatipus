TEMPLATE = lib
QT = core gui

include($$PWD/../vars.pri)
include($$PWD/../conf/confbase.pri)

DEFINES += LIBROXEEPLATIPUS_LIBRARY

contains(ROXEE_LINK_TYPE, static){
    DEFINES += LIBROXEEPLATIPUS_USE_STATIC
}

# Windows specific configuration
win32{
    message( -> Targetting windows)
    include($$PWD/../conf/confwin.pri)
}

## Mac specific configuration
mac{
    message( -> Targetting osx)
    include($$PWD/../conf/confmacx.pri)
}

## Unix specific configuration
unix:!mac {
    message( -> Targetting *nux)
    include($$PWD/../conf/confunix.pri)
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

