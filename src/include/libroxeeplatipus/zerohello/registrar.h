#ifndef ROXEEPLATIPUS_ZEROHELLO_REGISTRAR_H
#define ROXEEPLATIPUS_ZEROHELLO_REGISTRAR_H

#include "libroxeeplatipus/libroxeeplatipus_global.h"
#include "libroxeeplatipus/zerohello/record.h"
#include "libroxeeplatipus/zerohello/genericzero.h"

#include <QObject>
#include <QSocketNotifier>

#include <dns_sd.h>

namespace RoxeePlatipus {

namespace ZeroHello {

class LIBROXEEPLATIPUSSHARED_EXPORT Registrar : public GenericZero
{
  Q_OBJECT

public:
    explicit Registrar(QObject *parent = 0);

    /*! \brief Register a new service */
    void registerService(const Record &record, quint16 servicePort);

    /*! \brief Access the registered service */
    Record record() const
    {
        return finalRecord;
    }

signals:
    void registered(const Record &record);

private slots:

private:
    static void DNSSD_API registerHandler(
            DNSServiceRef,
            DNSServiceFlags,
            DNSServiceErrorType,
            const char *,
            const char *,
            const char *,
            void *
            );

    Record finalRecord;
};

}
}

#endif // ROXEEPLATIPUS_ZEROHELLO_REGISTRAR_H
