#ifndef GENERICZERO_H
#define GENERICZERO_H

#include "libroxeeplatipus/libroxeeplatipus_global.h"
#include <QObject>

#include <QSocketNotifier>
#include <dns_sd.h>

namespace RoxeePlatipus {

namespace ZeroHello {

class LIBROXEEPLATIPUSSHARED_EXPORT GenericZero : public QObject
{
    Q_OBJECT
public:
    explicit GenericZero(QObject *parent = 0);
    ~GenericZero();
    
signals:
    void error(DNSServiceErrorType err);

private slots:
    void activated();

protected:
    void goBaby(DNSServiceErrorType err);
    DNSServiceRef dnssref;

private:
    QSocketNotifier *bonjourSocket;

    
};

}
}
#endif // GENERICZERO_H
