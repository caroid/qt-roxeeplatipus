#include <AppKit/NSWindow.h>

#include "merguez.h"
#include "cocoainit.h"
#include "AppleRemote.h"
#include "RemoteControl.h"
#include <QDebug>

@class AppleRemote;
@interface SaucisseMain : NSObject <NSWindowDelegate>
-(SaucisseMain*) setCallback: (RoxeePlatipus::RemoteMerguez *) merguez;
 RoxeePlatipus::RemoteMerguez * memere;
@end

@implementation SaucisseMain
    // implementation file
    - (void) sendRemoteButtonEvent: (RemoteControlEventIdentifier) event
                       pressedDown: (BOOL) pressedDown
                       remoteControl: (RemoteControl*) remoteControl
    {
         memere->hello(event, pressedDown);
    }

-(SaucisseMain*) setCallback: (RoxeePlatipus::RemoteMerguez *) merguez
{
    memere = merguez;
}

@end


class RoxeePlatipus::RemoteMerguez::Private{
public:
    RemoteControl * rem;
    SaucisseMain * saucisse;
};

namespace RoxeePlatipus{

RemoteMerguez::RemoteMerguez(QWidget * win, QObject *parent) :
QObject(parent)
{
    CocoaInitializer initializer;
    d = new Private();
    d->saucisse = [SaucisseMain alloc];
    [d->saucisse setCallback: this];
    d->rem = [AppleRemote alloc];
    [d->rem initWithDelegate: d->saucisse];
    if(win->isActiveWindow())
        [d->rem startListening: d->saucisse];
    else
        [d->rem stopListening: d->saucisse];
    win->installEventFilter(this);
}

bool RemoteMerguez::eventFilter(QObject *object, QEvent *event)
{
    switch(event->type()){
    case QEvent::WindowActivate:
        [d->rem startListening: d->saucisse];
        break;
    case QEvent::WindowDeactivate:
        [d->rem stopListening: d->saucisse];
        break;
    }
    return false;
}

void RemoteMerguez::hello(int sig, bool pressed){
    emit merguez(sig, pressed);
}

}

