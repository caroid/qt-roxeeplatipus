#ifndef ROXEEPLATIPUS_ZEROHELLO_ZERO_H
#define ROXEEPLATIPUS_ZEROHELLO_ZERO_H

#include "libroxeeplatipus/libroxeeplatipus_global.h"

#include <QObject>
#include <QVariant>
#include <QVariantList>
#include <QStringList>
#include <QtNetwork/QHostInfo>
#include "libroxeeplatipus/zerohello/record.h"

namespace RoxeePlatipus {

namespace ZeroHello {

class ZeroHello : public QObject
{
    Q_OBJECT
public:
    explicit ZeroHello(QObject * parent = 0);
    Q_INVOKABLE void registerService(const QString &name, const QString &regType, int port, const QString &domain);
    Q_INVOKABLE void resolve(const QString &name, const QString &regType, const QString &domain);
    Q_INVOKABLE void browse(const QString & serviceType);

signals:
    void registered(const QString &name, const QString &regType, const QString &domain);
    void resolved(QStringList list);
    void discovered(QStringList list);

private slots:
    void resolveCompleteSlot(const QHostInfo & qhi,int port);
    void registeredSlot(const Record & record);
    void newAnnounceSlot(const QList<Record> list);

};

}
}


#endif // ROXEEPLATIPUS_ZEROHELLO_ZERO_H
