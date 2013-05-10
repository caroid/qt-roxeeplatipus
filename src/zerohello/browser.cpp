#include "libroxeeplatipus/zerohello/browser.h"

namespace RoxeePlatipus{
namespace ZeroHello{

Browser::Browser(QObject *parent) :
    GenericZero(parent), browsingType(QString::fromUtf8(""))
{
}

void Browser::browse(const QString &serviceType)
{
    browsingType = serviceType;
    // Call browse
    DNSServiceErrorType err = DNSServiceBrowse(
                &dnssref,
                0,
                0,
                serviceType.toUtf8().constData(),
                0,
                browseHandler,
                this
                );

    goBaby(err);
}

void Browser::browseHandler(
        DNSServiceRef,
        DNSServiceFlags flags,
        quint32,
        DNSServiceErrorType errorCode,
        const char *serviceName,
        const char *regType,
        const char *replyDomain,
        void *context
        )
{
    // Get context back
    Browser *browser = static_cast<Browser *>(context);

    // Handle error
    if (errorCode != kDNSServiceErr_NoError) {
        emit browser->error(errorCode);
        return;
    }
    // Create record
    Record record(serviceName, regType, replyDomain);
    // Handle read
    if (flags & kDNSServiceFlagsAdd) {
        if (!browser->bonjourRecords.contains(record))
            browser->bonjourRecords.append(record);
    } else {
        browser->bonjourRecords.removeAll(record);
    }
    if (!(flags & kDNSServiceFlagsMoreComing)) {
        emit browser->changed(browser->bonjourRecords);
    }
}

}
}
