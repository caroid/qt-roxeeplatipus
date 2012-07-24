#ifndef ROXEEPLATIPUS_POWERMANAGER_H
#define ROXEEPLATIPUS_POWERMANAGER_H

#include "libroxeeplatipus/libroxeeplatipus_global.h"
#include <QObject>
#include "libroxeeplatipus/basepowermanagement.h"

namespace RoxeePlatipus
{
class LIBROXEEPLATIPUSSHARED_EXPORT PowerManager: public QObject {
    Q_OBJECT
public:
    static RoxeePlatipus::BasePowerManagement * getManager(QObject * parent = 0);

signals:
    
public slots:
    
};

}

#endif // ROXEEPLATIPUS_POWERMANAGER_H
