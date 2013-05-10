#include "libroxeeplatipus/zerohello/resolver.h"


namespace RoxeePlatipus{
namespace ZeroHello{

Resolver::Resolver(QObject *parent) : GenericZero(parent)
{
}

void Resolver::resolve(const Record &record)
{
    if (dnssref) {
        qWarning("Resolve already in process");
        return;
    }

    DNSServiceErrorType err = DNSServiceResolve(
                &dnssref,
                0,
                0,
                record.serviceName.toUtf8().constData(),
                record.registeredType.toUtf8().constData(),
                record.replyDomain.toUtf8().constData(),
                (DNSServiceResolveReply) replyHandler,
                this
                );

    goBaby(err);
}

void Resolver::replyHandler(
        DNSServiceRef,
        DNSServiceFlags, quint32,
        DNSServiceErrorType errorCode, const char *,
        const char *hostTarget,
        quint16 port,
        quint16,
        const unsigned char *,
        void *context
        )
{
    Resolver *resolver = static_cast<Resolver *>(context);
    if (errorCode != kDNSServiceErr_NoError) {
        emit resolver->error(errorCode);
        return;
    }

#if Q_BYTE_ORDER == Q_LITTLE_ENDIAN
    port = ((port & 0x00ff) << 8) | ((port & 0xff00) >> 8);
#endif
    resolver->bonjourPort = port;
    QHostInfo::lookupHost(QString::fromUtf8(hostTarget), resolver, SLOT(finishConnect(const QHostInfo &)));
}


void Resolver::finishConnect(const QHostInfo &hostInfo)
{
    emit resolved(hostInfo, bonjourPort);
}

}
}
