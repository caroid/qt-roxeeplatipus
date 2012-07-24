#include "libroxeeplatipus/powermanager.h"

#ifdef Q_OS_MAC
#include "mac/powermanagementmac.h"
#elif defined(Q_OS_WIN)
#include "win/powermanagementwin.h"
#elif defined(Q_OS_UNIX) && define(Q_DBUS_EXPORT)
#include "nux/powermanagementnux.h"
#endif

namespace RoxeePlatipus{

RoxeePlatipus::BasePowerManagement * PowerManager::getManager(QObject * parent)
{
#ifdef Q_OS_MAC
    return (RoxeePlatipus::BasePowerManagement *) new PowerManagementMac(parent);
#elif defined(Q_OS_WIN)
    return (RoxeePlatipus::BasePowerManagement *) new PowerManagementWin(parent);
#elif defined(Q_OS_UNIX) && define(Q_DBUS_EXPORT)
    return (RoxeePlatipus::BasePowerManagement *) new PowerManagementNux(parent);
#else
    return (RoxeePlatipus::BasePowerManagement *) new BasePowerManagement(parent);
#endif
}

}
