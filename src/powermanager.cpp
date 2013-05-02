#include "libroxeeplatipus/powermanager.h"

#ifdef Q_OS_MAC
#include "mac/powermanagementmac.h"
#elif defined(Q_OS_WIN)
#include "win/powermanagementwin.h"
#elif defined(Q_OS_UNIX) && defined(Q_DBUS_EXPORT)
#include "nux/powermanagementnux.h"
#endif

namespace RoxeePlatipus{

PowerManager::PowerManager(QObject * parent): QObject(parent)
{
#ifdef Q_OS_MAC
    pm = new PowerManagementMac(this);
#elif defined(Q_OS_WIN)
    pm = new PowerManagementWin(this);
#elif defined(Q_OS_UNIX) && defined(Q_DBUS_EXPORT)
    pm = new PowerManagementNux(this);
#endif
    qDebug() << " [M] PowerManagement: constructor";
}

uint PowerManager::getState()
{
    return pm->getState();
}

void PowerManager::setState(const uint busy, const QString & reason )
{
    return pm->setState(busy, reason);
}

}
