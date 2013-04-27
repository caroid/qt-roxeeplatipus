#ifndef POWERMANAGEMENTNUX_H
#define POWERMANAGEMENTNUX_H

#include "libroxeeplatipus/basepowermanagement.h"

QT_BEGIN_NAMESPACE
class QDBusPendingCallWatcher;
QT_END_NAMESPACE

class PowerManagementNux : public RoxeePlatipus::BasePowerManagement
{
    Q_OBJECT
public:
    explicit PowerManagementNux(QObject *parent = 0);
    ~PowerManagementNux();
    Q_INVOKABLE void setState(const uint busy, const QString & reason);

signals:

public slots:

private slots:
    void OnAsyncReply(QDBusPendingCallWatcher *call);

private:
    enum state
    {
        error,
        idle,
        request_busy,
        busy,
        request_idle
    };

    enum state m_state;
    enum state m_intended_state;
    unsigned int m_cookie;
    bool m_use_gsm;

private:

};

#endif // POWERMANAGEMENTNUX_H
