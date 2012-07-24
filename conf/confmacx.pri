!isEmpty(ADDITIONAL_DEPENDENCIES_DIR){
#    QMAKE_LFLAGS += -F$${ADDITIONAL_DEPENDENCIES_DIR}
#    INCLUDEPATH += $${ADDITIONAL_DEPENDENCIES_DIR}/Sparkle.framework/Headers
}

# Pointing to third-party include and lib dirs, in case the external dep doesn't provide them
#QMAKE_LFLAGS += -F$${PWD}/../third-party/Sparkle
#INCLUDEPATH += $${PWD}/../third-party/Sparkle/Sparkle.framework/Headers

LIBS += -framework AppKit -framework IOKit

###################
# Dependencies
###################
INCLUDEPATH += $${PWD}/../third-party/SPMediaKeyTap
INCLUDEPATH += $${PWD}/../third-party/apple_remote_control

OBJECTIVE_SOURCES +=    $${PWD}/../third-party/apple_remote_control/AppleRemote.m\
                        $${PWD}/../third-party/apple_remote_control/RemoteControl.m\
                        $${PWD}/../third-party/apple_remote_control/MultiClickRemoteBehavior.m\
                        $${PWD}/../third-party/apple_remote_control/HIDRemoteControlDevice.m\

OBJECTIVE_HEADERS +=    $${PWD}/../third-party/apple_remote_control/AppleRemote.h\
                        $${PWD}/../third-party/apple_remote_control/RemoteControl.h\
                        $${PWD}/../third-party/apple_remote_control/MultiClickRemoteBehavior.h\
                        $${PWD}/../third-party/apple_remote_control/HIDRemoteControlDevice.h\

LIBS += -framework Carbon

OBJECTIVE_HEADERS +=    $${PWD}/../third-party/SPMediaKeyTap/SPMediaKeyTap.h
OBJECTIVE_SOURCES +=    $${PWD}/../third-party/SPMediaKeyTap/SPMediaKeyTap.m


###################
# Main lib
###################
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

# Use Lion Fullscreen if available
DEFINES += PLATIPUS_FULLSCREEN
