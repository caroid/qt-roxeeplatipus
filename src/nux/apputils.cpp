#include "libroxeeplatipus/apputils.h"

namespace RoxeePlatipus {

void AppUtils::badgeMe(const QString &/*text*/)
{
}

void AppUtils::bitchMe()
{
}

bool AppUtils::hasCustomFullscreen(QWidget * /*mainWindow*/)
{
    return false;
}

bool AppUtils::isFullScreen(QWidget * mainWindow)
{
    return mainWindow->isFullScreen();
}

bool AppUtils::fullscrenToggle(QWidget * mainWindow)
{
    if(!mainWindow->isFullScreen()){
        mainWindow->showFullScreen();
    }
    else if(mainWindow->isMaximized())
        mainWindow->showMaximized();
    else
        mainWindow->showNormal();
    return mainWindow->isFullScreen();
}

}

