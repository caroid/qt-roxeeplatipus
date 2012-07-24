#include "powermanagementmac.h"

#include <QtCore/qdebug.h>

PowerManagementMac::PowerManagementMac(QObject *parent) :
    BasePowerManagement(parent), m_busy(0), m_assertionID(0)
{
    qDebug() << " [M] System/PowerManagement: constructor";
    //    @param master_device_port  Just pass in MACH_PORT_NULL for master device port.
    //    @result Returns a io_connect_t handle on the root domain. Must be released with IOServiceClose() when done.
    m_connectIO = IOPMFindPowerManagement( MACH_PORT_NULL );
}

PowerManagementMac::~PowerManagementMac()
{
    qDebug() << " [M] System/PowerManagement: destructor";
    IOServiceClose(m_connectIO);
    if(m_assertionID){
        IOPMAssertionRelease(m_assertionID);
        m_assertionID = 0;
    }
}

uint PowerManagementMac::getState()
{
    qDebug() << " [M] System/PowerManagement: query state";
    return m_busy;
}

void PowerManagementMac::setState(uint busy)
{
    qDebug() << " [M] System/PowerManagement: set new state";
    if(m_busy == busy){
        return;
    }
    IOReturn success;
    // Release any previous assertion
    if(m_assertionID){
        success = IOPMAssertionRelease(m_assertionID);
        m_assertionID = 0;
    }
    // kIOPMAssertionTypePreventSystemSleep - general system sleep prevention (dark wake)
    switch(busy){
    case 1:
        success = IOPMAssertionCreate(kIOPMAssertionTypePreventUserIdleSystemSleep, kIOPMAssertionLevelOn, &m_assertionID);
        break;
    case 2:
        success = IOPMAssertionCreate(kIOPMAssertionTypePreventUserIdleDisplaySleep, kIOPMAssertionLevelOn, &m_assertionID);
        break;
    case 0:
        break;
    default:
        success = kIOReturnError;
        break;
    }
    if(success != kIOReturnSuccess){
        m_busy = this->none();
        qDebug() << " [M] PowerManagement: FAIL";
    }
    return;
}
