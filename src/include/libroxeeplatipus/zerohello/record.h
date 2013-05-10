#ifndef ROXEEPLATIPUS_ZEROHELLO_RECORD_H
#define ROXEEPLATIPUS_ZEROHELLO_RECORD_H

#include "libroxeeplatipus/libroxeeplatipus_global.h"

#include <QObject>

namespace RoxeePlatipus {

namespace ZeroHello {

class LIBROXEEPLATIPUSSHARED_EXPORT Record
{
public:
    explicit Record() {}
    explicit Record(const QString &name, const QString &regType,const QString &domain):
        serviceName(name), registeredType(regType), replyDomain(domain)
    {
    }

    explicit Record(const char *name, const char *regType, const char *domain) {
        serviceName = QString::fromUtf8(name);
        registeredType = QString::fromUtf8(regType);
        replyDomain = QString::fromUtf8(domain);
    }

    QString serviceName;
    QString registeredType;
    QString replyDomain;

    bool operator==(const Record &other) const {
        return  serviceName == other.serviceName
                && registeredType == other.registeredType
                && replyDomain == other.replyDomain;
    }
};

}
}


#endif // ROXEEPLATIPUS_ZEROHELLO_RECORD_H
