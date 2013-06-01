TEMPLATE = app
QT = core widgets network

SOURCES +=  $$PWD/main.cpp \
    zero.cpp

include($$PWD/../config/common.pri)

INCLUDEPATH += $$PWD
target.path = $$DESTDIR
INSTALLS += target

LIBS += -l$${ROXEE_LINK_NAME}

# Shitty right now
#win32{
#    INCLUDEPATH += C:\roxeelove\trees\bonjour\include
#    LIBS += -LC:\roxeelove\trees\bonjour\lib
#}

contains(ROXEE_LINK_TYPE, static){
    DEFINES += LIBROXEEPLATIPUS_USE_STATIC
}

HEADERS += \
    zero.h
