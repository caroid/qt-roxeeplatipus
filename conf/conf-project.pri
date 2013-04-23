contains(TEMPLATE, app){
    INCLUDEPATH +=  $$DESTDIR/../include
    LIBS += -L$$DESTDIR/../lib
    LIBS += -l$${TARGET}
}

contains(TEMPLATE, lib){
}

