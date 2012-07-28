#include "libroxeeplatipus/merguez.h"

class RoxeePlatipus::RemoteMerguez::Private{
public:
};

namespace RoxeePlatipus{

RemoteMerguez::RemoteMerguez(QWidget * /*win*/, QObject * parent) :
QObject(parent)
{
}

bool RemoteMerguez::eventFilter(QObject */*object*/, QEvent */*event*/)
{
    return false;
}

void RemoteMerguez::hello(int /*sig*/, bool /*pressed*/){
}

}

