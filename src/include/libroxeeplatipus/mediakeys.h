#ifndef ROXEEPLATIPUS_MEDIAKEYS_H
#define ROXEEPLATIPUS_MEDIAKEYS_H

#include "libroxeeplatipus/libroxeeplatipus_global.h"
#include <QtCore/qobject.h>
#include <QWidget>
#include <QEvent>

namespace RoxeePlatipus{

class LIBROXEEPLATIPUSSHARED_EXPORT MediaKeys: public QObject {
    Q_OBJECT
public:
    explicit MediaKeys(QWidget * win, QObject *parent = 0);
    void hello(int keyCode, int keyRepeat, bool isUp);

signals:
    void merguez(int sig, bool repeat, bool pressed);

public slots:

private:
    class Private;
    Private* d;
    bool eventFilter(QObject *object, QEvent *event);
};

}
#endif // ROXEEPLATIPUS_MEDIAKEYS_H
