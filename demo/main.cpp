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

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    RoxeePlatipus::AppUtils * a;
    RoxeePlatipus::BasePowerManagement * b;
    RoxeePlatipus::LesserWindow * c;
    RoxeePlatipus::MediaKeys * d;
    RoxeePlatipus::RemoteMerguez * e;
    RoxeePlatipus::PowerManager * f;

    return app.exec();
}
