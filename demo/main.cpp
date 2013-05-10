#include <QApplication>
#include <QMainWindow>
#include <QHBoxLayout>

#include <libroxeeplatipus/root.h>
#include <libroxeeplatipus/apputils.h>
#include <libroxeeplatipus/basepowermanagement.h>
#include <libroxeeplatipus/lesserwindow.h>
#include <libroxeeplatipus/mediakeys.h>
#include <libroxeeplatipus/merguez.h>
#include <libroxeeplatipus/powermanager.h>
#include <libroxeeplatipus/QT425.h>

#include "zero.h"


int main(int argc, char *argv[])
{

    QApplication app(argc, argv);

    RoxeePlatipus::Root * root = new RoxeePlatipus::Root();
    qDebug() << root->getName();
    qDebug() << root->getBuildType();
    qDebug() << root->getLinkType();
    qDebug() << root->getQt();
    qDebug() << root->getVendor();
    qDebug() << root->getVersion();
    qDebug() << root->getRevision();
    qDebug() << root->getChangeset();

    qDebug() << root->getLibName();
    qDebug() << root->getLibVersion();
    qDebug() << root->getLibRevision();

    QWidget * main = new QWidget();

    Zero * z = new Zero();



    //    RoxeePlatipus::AppUtils * a;
//    RoxeePlatipus::BasePowerManagement * b;
//    RoxeePlatipus::LesserWindow * c;
//    RoxeePlatipus::MediaKeys * d;
//    RoxeePlatipus::RemoteMerguez * e;
//    RoxeePlatipus::PowerManager * f;
//    qDebug() << QStandardPaths::writableLocation(QStandardPaths::CacheLocation);

    return app.exec();
}
