#ifndef ROXEEPLATIPUS_MERGUEZ_H
#define ROXEEPLATIPUS_MERGUEZ_H

#include "libroxeeplatipus_global.h"
#include <QtCore/qobject.h>
#include <QWidget>
#include <QEvent>

namespace RoxeePlatipus{

class LIBROXEEPLATIPUSSHARED_EXPORT RemoteMerguez: public QObject {
    Q_OBJECT
public:
    explicit RemoteMerguez(QWidget * win, QObject *parent = 0);
    void hello(int sig, bool pressed);

signals:
    void merguez(int sig, bool pressed);

public slots:

private:
    class Private;
    Private* d;
    bool eventFilter(QObject *object, QEvent *event);
};

}
#endif // ROXEEPLATIPUS_MERGUEZ_H
