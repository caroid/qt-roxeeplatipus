#include "zero.h"
#include <libroxeeplatipus/zerohello/browser.h>
#include <libroxeeplatipus/zerohello/registrar.h>
#include <QTime>
#include <QSystemTrayIcon>
#include <libroxeeplatipus/notifier.h>

using namespace RoxeePlatipus::ZeroHello;
Zero::Zero(QObject *parent) :
    QObject(parent)
{
    // Service type
    QString serviceType = QString("_roxee._tcp");
    // Service name
    QString sayMyNameBaby = QString("Raymond");

    // Take a port (XXX should really be your service port)
    int high = 50000;
    int low = 8080;
    QTime time = QTime::currentTime();
    qsrand((uint)time.msec());
    int port = qrand() % ((high + 1) - low) + low;

    // Call upon the registrar
    registrar = new Registrar(this);
    // Create our record (name+hostname+port, type)
    Record ourselves = Record(sayMyNameBaby.append(QHostInfo::localHostName()).append(QString::number(port)), serviceType, "");
    // And register ourselves
    registrar->registerService(ourselves, port);
    // Connect to be notified that registration went through
    connect(registrar, SIGNAL(registered(const Record &)), this, SLOT(registeredSlot(const Record &)));

    // Now, start a browser
    Browser * browser = new Browser();
    // And discover for our serviceType
    browser->browse(serviceType);
    // Connect the browser to our slot
    connect(browser,SIGNAL(changed(const QList<Record>)), this, SLOT(newAnnounceSlot(const QList<Record>)));

}

void Zero::newAnnounceSlot(const QList<Record> &list)
{
    QSystemTrayIcon * t = new QSystemTrayIcon();
    t->show();
//    RoxeePlatipus::Notificator * n = new RoxeePlatipus::Notificator("program name", t);
//    n->notify(RoxeePlatipus::Notificator::Information, "title something", "text something");
    RoxeePlatipus::Notifier * n = new RoxeePlatipus::Notifier(this, t);
    n->notify("MyApp", "MyTitle", "MyText", QIcon(), true);

    // Get signaled when we discover new stuff
    qDebug() << "Hohoho, there is somebody in there! Vous voulez du chocolat?";
    foreach (RoxeePlatipus::ZeroHello::Record record, list) {
        if(registrar->record() == record){
            qDebug() << "Not interested by our own record";
        }else{
            qDebug() << " **** FOUND ****";
            qDebug() << record.registeredType;
            qDebug() << record.replyDomain;
            qDebug() << record.serviceName;

            // And resolve it as well
            Resolver * r = new Resolver(this);
            r->connect(r, SIGNAL(resolved(const QHostInfo,int)), this, SLOT(resolveCompleteSlot(const QHostInfo, int)));
            r->resolve(record);
        }
    }
}

void Zero::resolveCompleteSlot(const QHostInfo & qhi,int port)
{
    // Get signaled when we end resolving some discovered stuff
    qDebug() << "Something was resolved tada!";
    QList<QHostAddress> list = qhi.addresses();
    foreach(QHostAddress addr, list){
        qDebug() << addr.toString() << port;
    }
}

void Zero::registeredSlot(const Record &)
{
    qDebug() << "Yeah, we registered";
}
