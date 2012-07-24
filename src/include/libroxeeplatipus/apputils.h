#ifndef ROXEEPLATIPUS_APPUTILS_H
#define ROXEEPLATIPUS_APPUTILS_H

#include "libroxeeplatipus/libroxeeplatipus_global.h"
#include <QtCore/qobject.h>

#include <QtCore/QString>
#include <QWidget>

namespace RoxeePlatipus {

class LIBROXEEPLATIPUSSHARED_EXPORT AppUtils: public QObject {
    Q_OBJECT
public:

    static void badgeMe(const QString &text);
    static void bitchMe();

    static bool hasCustomFullscreen(QWidget * mainWindow);
    static bool isFullScreen(QWidget * mainWindow);
    static bool fullscrenToggle(QWidget * mainWindow);

    //    void flipSpace(void * winId, int newSpaceNumber);
};

}

#endif // ROXEEPLATIPUS_APPUTILS_H
