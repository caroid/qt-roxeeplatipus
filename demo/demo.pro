TEMPLATE = app
QT = core widgets

SOURCES +=  $$PWD/main.cpp

include($$PWD/../config/common.pri)

INCLUDEPATH += $$PWD
target.path = $$DESTDIR
INSTALLS += target

LIBS += -l$${ROXEE_LINK_NAME}

contains(ROXEE_LINK_TYPE, static){
    DEFINES += LIBROXEEMEGAUP_USE_STATIC
}
