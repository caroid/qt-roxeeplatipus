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

#include "libroxeeplatipus/notifier.h"
#include <QMessageBox>

#ifdef Q_OS_MAC
#include "mac/specialnotifier.h"
#elif defined(Q_OS_UNIX) && defined(Q_DBUS_EXPORT)
#include "nux/specialnotifiernux.h"
#else
class SpecialNotifier : public RoxeePlatipus::BaseNotifier
{
public:
    explicit SpecialNotifier(QObject * parent = 0): RoxeePlatipus::BaseNotifier(parent)
    {

    }
};
#endif

namespace RoxeePlatipus{

Notifier::Notifier(QObject * parent, QSystemTrayIcon * tray):
    QObject(parent), trayicon(tray)
{
    // Use any avalaible notifier
    notifier = new SpecialNotifier(this);
}

void Notifier::notify(const QString & appName, const QString & title, const QString & text, const QIcon & icon, bool critical)
{
    bool result = notifier->notify(appName, title, text, icon);
    if(result)
        return;

    if(trayicon && trayicon->supportsMessages())
    {
        trayicon->showMessage(title, text, QSystemTrayIcon::MessageIcon(QSystemTrayIcon::NoIcon));
        return;
    }

    if(critical){
        QMessageBox::critical(0, title, text, QMessageBox::Ok, QMessageBox::Ok);
    }
}

}
