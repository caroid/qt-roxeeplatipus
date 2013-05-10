#ifndef ROXEEPLATIPUS_ZEROHELLO_BROWSER_H
#define ROXEEPLATIPUS_ZEROHELLO_BROWSER_H

#include "libroxeeplatipus/libroxeeplatipus_global.h"
#include "libroxeeplatipus/zerohello/genericzero.h"
#include "libroxeeplatipus/zerohello/record.h"
#include "libroxeeplatipus/zerohello/resolver.h"

#include <QSocketNotifier>
#include <QDebug>
#include <QObject>

#include <dns_sd.h>

namespace RoxeePlatipus {

namespace ZeroHello {

class LIBROXEEPLATIPUSSHARED_EXPORT Browser : public GenericZero
{
    Q_OBJECT
public:
    explicit Browser(QObject *parent = 0);

    /*! \brief Call this to start browsing for serviceType */
    Q_INVOKABLE void browse(const QString &serviceType);

    /*! \brief Access the current records */
    QList<Record> records() const
    {
        return bonjourRecords;
    }

    /*! \brief Access the current serviceType (last call to browseForServiceType) */
    QString serviceType() const
    {
        return browsingType;
    }

signals:
    void changed(const QList<Record> &list);

private slots:

private:
    static void DNSSD_API browseHandler(
            DNSServiceRef,
            DNSServiceFlags,
            quint32,
            DNSServiceErrorType,
            const char *,
            const char *,
            const char *,
            void *
            );

    QList<Record> bonjourRecords;
    QString browsingType;

signals:
    
public slots:
    
};

}
}


#endif // ROXEEPLATIPUS_ZEROHELLO_BROWSER_H
