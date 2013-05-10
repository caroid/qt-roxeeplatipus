#include "libroxeeplatipus/zerohello/genericzero.h"

namespace RoxeePlatipus{
namespace ZeroHello{


GenericZero::GenericZero(QObject *parent) :
    QObject(parent), dnssref(0), bonjourSocket(0)
{
}

GenericZero::~GenericZero()
{
    if (dnssref) {
        DNSServiceRefDeallocate(dnssref);
        dnssref = 0;
    }
}

void GenericZero::goBaby(DNSServiceErrorType err)
{
    // On err, say so and return
    if (err != kDNSServiceErr_NoError) {
        emit error(err);
        return;
    }

    int sockfd = DNSServiceRefSockFD(dnssref);
    if (sockfd == -1) {
        emit error(kDNSServiceErr_Invalid);
        return;
    }

    bonjourSocket = new QSocketNotifier(sockfd, QSocketNotifier::Read, this);
    connect(bonjourSocket, SIGNAL(activated(int)), this, SLOT(activated()));
}

void GenericZero::activated()
{
    DNSServiceErrorType err = DNSServiceProcessResult(dnssref);
    if (err != kDNSServiceErr_NoError)
        emit error(err);
}

}
}
