#ifndef ROXEEPLATIPUS_QT425_H
#define ROXEEPLATIPUS_QT425_H

#include "libroxeeplatipus/libroxeeplatipus_global.h"

#if (QT_VERSION < QT_VERSION_CHECK(5, 0, 0))
#include <QString>
#include <QDesktopServices>

class LIBROXEEPLATIPUSSHARED_EXPORT QStandardPaths: public QObject {
    Q_OBJECT
public:
    // Do not re-order, must match QDesktopServices
    enum StandardLocation {
        DesktopLocation,
        DocumentsLocation,
        FontsLocation,
        ApplicationsLocation,
        MusicLocation,
        MoviesLocation,
        PicturesLocation,
        TempLocation,
        HomeLocation,
        DataLocation,
        CacheLocation,
        GenericDataLocation,
        RuntimeLocation,
        ConfigLocation,
        DownloadLocation,
        GenericCacheLocation
    };

    static QString writableLocation(StandardLocation type)
    {
        switch(type){
        case QStandardPaths::CacheLocation:
            return QDesktopServices::storageLocation(QDesktopServices::CacheLocation);
            break;
        case QStandardPaths::DocumentsLocation:
            return QDesktopServices::storageLocation(QDesktopServices::DocumentsLocation);
            break;
        case QStandardPaths::TempLocation:
            return QDesktopServices::storageLocation(QDesktopServices::TempLocation);
            break;
        default:
            break;
        }
        return QString("");
    }

//    static QStringList standardLocations(StandardLocation type)
//    {
//    }

//    enum LocateOption {
//        LocateFile = 0x0,
//        LocateDirectory = 0x1
//    };
//    Q_DECLARE_FLAGS(LocateOptions, LocateOption)

//    static QString locate(StandardLocation type, const QString &fileName, LocateOptions options = LocateFile);
//    static QStringList locateAll(StandardLocation type, const QString &fileName, LocateOptions options = LocateFile);
//    static QString displayName(StandardLocation type);

//    static QString findExecutable(const QString &executableName, const QStringList &paths = QStringList());

//    static void enableTestMode(bool testMode);
//    static bool isTestModeEnabled();

private:
    // prevent construction
//    QStandardPaths();
//    ~QStandardPaths();
};
#else
#include <QStandardPaths>
#endif


#endif // ROXEEPLATIPUS_QT425_H
