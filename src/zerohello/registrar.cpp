#include "libroxeeplatipus/zerohello/registrar.h"

namespace RoxeePlatipus{
namespace ZeroHello{

Registrar::Registrar(QObject *parent)
  : GenericZero(parent)
{
}

void Registrar::registerService(const Record &record, quint16 servicePort)
{
    if (dnssref) {
        qWarning("Already registered a service");
        return;
    }

    quint16 bigEndianPort = servicePort;
#if Q_BYTE_ORDER == Q_LITTLE_ENDIAN
    bigEndianPort = ((servicePort & 0x00ff) << 8) | ((servicePort & 0xff00) >> 8);
#endif
    // Call register
    DNSServiceErrorType err = DNSServiceRegister(
                &dnssref,
                0,
                0,
                record.serviceName.toUtf8().constData(),
                record.registeredType.toUtf8().constData(),
                record.replyDomain.isEmpty() ? 0 : record.replyDomain.toUtf8().constData(),
                0,
                bigEndianPort,
                0,
                0,
                registerHandler,
                this
                );

    goBaby(err);
}

void Registrar::registerHandler(
        DNSServiceRef,
        DNSServiceFlags,
        DNSServiceErrorType errorCode,
        const char *name,
        const char *regType,
        const char *domain,
        void *data)
{
    // Get context back
    Registrar *registrar = static_cast<Registrar *>(data);

    // On err
    if (errorCode != kDNSServiceErr_NoError) {
        emit registrar->error(errorCode);
        return;
    }

    // Store record
    registrar->finalRecord = Record(QString::fromUtf8(name), QString::fromUtf8(regType), QString::fromUtf8(domain));

    // Say we registered
    emit registrar->registered(registrar->finalRecord);
}

}
}
