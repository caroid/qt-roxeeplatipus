# Generic QT/OS settings
mac{
    QMAKE_MACOSX_DEPLOYMENT_TARGET = $$ROXEE_MIN_OSX
}

win32{
    # Exclude cruft from the SDK
    DEFINES += WIN32_LEAN_AND_MEAN

    # Windows XP
    DEFINES += _WIN32_WINNT=0x0501
    DEFINES += _WIN32_IE=0x0501

    DEFINES += WIN32
    DEFINES += _WIN32

    # Large support
    DEFINES += _FILE_OFFSET_BITS=64

    DEFINES += UNICODE
    DEFINES += _UNICODE
    DEFINES += __USE_W32_SOCKETS

}
