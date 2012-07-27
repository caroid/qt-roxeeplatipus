SOURCES += $$PWD/../src/nux/apputils.cpp
SOURCES += $$PWD/../src/nux/merguez.cpp
QT += dbus
# The linux/dbus code is largely copied from  qBitTorrent Bittorrent Client,
# Copyright (C) 2011  Vladimir Golovnev <glassez@yandex.ru>
# Released under the GPL with an exception clause for OpenSSL
HEADERS += $$PWD/../src/nux/powermanagementnux.h
SOURCES += $$PWD/../src/nux/powermanagementnux.cpp
