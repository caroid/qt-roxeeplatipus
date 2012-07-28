#ifndef POWERMANAGEMENTWINDOWS_H
#define POWERMANAGEMENTWINDOWS_H

#include "libroxeeplatipus/basepowermanagement.h"

class PowerManagementWindows : public RoxeePlatipus::BasePowerManagement
{
    Q_OBJECT
public:
    explicit PowerManagementWindows(QObject *parent = 0);
    uint getState();
    void setState(uint busy);

signals:
    
public slots:
    
private:
  uint m_busy;
};

#endif // POWERMANAGEMENTWINDOWS_H
