#ifndef POWERMANAGEMENTMAC_H
#define POWERMANAGEMENTMAC_H

#include "libroxeeplatipus/basepowermanagement.h"
#include <IOKit/pwr_mgt/IOPMLib.h>

class PowerManagementMac : public RoxeePlatipus::BasePowerManagement
{
    Q_OBJECT
public:
    explicit PowerManagementMac(QObject * parent = 0);
    ~PowerManagementMac();

    void setState(const uint /* busy */, const QString & /*reason*/ );

signals:

public slots:

private:
//  uint m_busy;
  IOPMAssertionID m_assertionID;
  io_connect_t m_connectIO;
};

#endif // POWERMANAGEMENTMAC_H
