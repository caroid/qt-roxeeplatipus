TEMPLATE = app
QT = core widgets network

SOURCES +=  $$PWD/main.cpp \
    zero.cpp

include($$PWD/../config/common.pri)

INCLUDEPATH += $$PWD
target.path = $$DESTDIR
INSTALLS += target

LIBS += -l$${ROXEE_LINK_NAME}

contains(ROXEE_LINK_TYPE, static){
    DEFINES += LIBROXEEPLATIPUS_USE_STATIC
}

HEADERS += \
    zero.h
