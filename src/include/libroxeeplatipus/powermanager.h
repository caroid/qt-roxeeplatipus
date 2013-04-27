#ifndef ROXEEPLATIPUS_POWERMANAGER_H
#define ROXEEPLATIPUS_POWERMANAGER_H

#include "libroxeeplatipus/libroxeeplatipus_global.h"
#include <QObject>
#include "libroxeeplatipus/basepowermanagement.h"

namespace RoxeePlatipus
{
//class LIBROXEEPLATIPUSSHARED_EXPORT PowerManager: public QObject {
//    Q_OBJECT
//public:
//    static RoxeePlatipus::BasePowerManagement * getManager(QObject * parent = 0);

//signals:
    
//public slots:
    

class LIBROXEEPLATIPUSSHARED_EXPORT PowerManager : public QObject
{
  Q_OBJECT

public:
    PowerManager(QObject * parent = 0);

    Q_PROPERTY(uint state READ getState)

    uint getState();

    Q_PROPERTY(uint NONE READ getNone)
    Q_PROPERTY(uint SYSTEM READ getSystem)
    Q_PROPERTY(uint SCREEN READ getScreen)

    uint getSystem()
    {
        return BasePowerManagement::SYSTEM;
    }

    uint getScreen()
    {
        return BasePowerManagement::SCREEN;
    }

    uint getNone()
    {
        return BasePowerManagement::NONE;
    }

    Q_INVOKABLE void setState(const uint busy, const QString & reason );

private:
  BasePowerManagement * pm;

};

}

#endif // ROXEEPLATIPUS_POWERMANAGER_H
