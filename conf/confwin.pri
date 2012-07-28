INCLUDEPATH += $$PWD/../src/win

SOURCES += $$PWD/../src/win/apputils.cpp
SOURCES += $$PWD/../src/win/merguez.cpp
SOURCES += $$PWD/../src/win/mediakeys.cpp
HEADERS += $$PWD/../src/win/powermanagementwindows.h
SOURCES += $$PWD/../src/win/powermanagementwindows.cpp
SOURCES += $$PWD/../src/win/lesserwindow.cpp

win32-g++ {
    include(confwin-mingw.pri)
}

win32-msvc{
    include(confwin-msvc.pri)
}



