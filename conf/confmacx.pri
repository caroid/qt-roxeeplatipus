!isEmpty(ADDITIONAL_DEPENDENCIES_DIR){
#    QMAKE_LFLAGS += -F$${ADDITIONAL_DEPENDENCIES_DIR}
#    INCLUDEPATH += $${ADDITIONAL_DEPENDENCIES_DIR}/Sparkle.framework/Headers
}

# Pointing to third-party include and lib dirs, in case the external dep doesn't provide them
#QMAKE_LFLAGS += -F$${PWD}/../third-party/Sparkle
#INCLUDEPATH += $${PWD}/../third-party/Sparkle/Sparkle.framework/Headers

LIBS += -framework AppKit -framework IOKit

INCLUDEPATH += $${PWD}/../third-party//SPMediaKeyTap
INCLUDEPATH += $${PWD}/../third-party//apple_remote_control


INCLUDEPATH += $$PWD/mac
HEADERS +=              mac/cocoainit.h
OBJECTIVE_SOURCES +=    mac/cocoainit.mm


# Implementation
OBJECTIVE_SOURCES +=    mac/apputils.mm
OBJECTIVE_SOURCES +=    mac/merguez.mm
OBJECTIVE_SOURCES +=    mac/mediakeys.mm
OBJECTIVE_SOURCES +=    mac/lesserwindow.mm

DEFINES += PLATIPUS_FULLSCREEN


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

    #    mac/SPMediaKeyTap.m\
    #    mac/SPMediaKeyTapDelegate.m\
    #    mac/SPInvocationGrabbing/NSObject+SPInvocationGrabbing.m

