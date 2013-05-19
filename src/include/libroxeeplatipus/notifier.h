/**
 * Copyright (c) 2012, WebItUp <contact@webitup.fr>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef ROXEEPLATIPUS_NOTIFIER_H
#define ROXEEPLATIPUS_NOTIFIER_H

#include "libroxeeplatipus/libroxeeplatipus_global.h"
#include "libroxeeplatipus/basenotifier.h"

#include <QSystemTrayIcon>

namespace RoxeePlatipus
{

class LIBROXEEPLATIPUSSHARED_EXPORT Notifier : public QObject
{
  Q_OBJECT

public:
    explicit Notifier(QObject * parent = 0, QSystemTrayIcon * tray = 0);

    Q_PROPERTY(int APP READ APP)
    static int APP(){return QSystemTrayIcon::NoIcon;}
    Q_PROPERTY(int INFO READ INFO)
    static int INFO(){return QSystemTrayIcon::Information;}
    Q_PROPERTY(int WARNING READ WARNING)
    static int WARNING(){return QSystemTrayIcon::Warning;}
    Q_PROPERTY(int CRITICAL READ CRITICAL)
    static int CRITICAL(){return QSystemTrayIcon::Critical;}

    Q_INVOKABLE void notify(
            const QString & appName,
            const QString & title,
            const QString & subtitle,
            const QString & text,
            const QPixmap & icon = QPixmap(),
            int severity = QSystemTrayIcon::NoIcon,
            int time = 10000
            );

    Q_INVOKABLE bool canNotify();

private:
    BaseNotifier * notifier;
    QSystemTrayIcon * trayicon;
};

}

#endif // ROXEEPLATIPUS_NOTIFIER_H
