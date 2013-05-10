#ifndef ROXEEPLATIPUS_ZEROHELLO_RESOLVER_H
#define ROXEEPLATIPUS_ZEROHELLO_RESOLVER_H

#include "libroxeeplatipus/libroxeeplatipus_global.h"
#include "libroxeeplatipus/zerohello/genericzero.h"
#include "libroxeeplatipus/zerohello/record.h"

#include <QObject>
#include <QtNetwork/QHostInfo>
#include <QSocketNotifier>

#include <dns_sd.h>

namespace RoxeePlatipus {

namespace ZeroHello {

class LIBROXEEPLATIPUSSHARED_EXPORT Resolver : public GenericZero
{
  Q_OBJECT

public:
    Resolver(QObject *parent);

    void resolve(const Record &record);

signals:
    void resolved(const QHostInfo &hostInfo, int port);

private slots:
    void finishConnect(const QHostInfo &hostInfo);

private:
    static void DNSSD_API replyHandler(
            DNSServiceRef,
            DNSServiceFlags,
            quint32,
            DNSServiceErrorType,
            const char *,
            const char *,
            quint16,
            quint16,
            const unsigned char *,
            void *
    );

    int bonjourPort;
};
}
}
#endif // ROXEEPLATIPUS_ZEROHELLO_RESOLVER_H
