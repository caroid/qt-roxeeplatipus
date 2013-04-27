/*
 * Copyright 2012 WebItUp <contact@webitup.fr>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA  02110-1301  USA
 */

#include "libroxeeplatipus/lesserwindow.h"
#include <QDebug>
#include <QDesktopWidget>
#include <QApplication>
#include <QRect>
//#include <AppKit/NSDockTile.h>
#include <AppKit/NSApplication.h>
#include <QApplication>
#include <QDesktopWidget>
#include <Cocoa/Cocoa.h>
#include <AppKit/NSWindow.h>
#include <AppKit/NSUserDefaultsController.h>


//@interface DockIconClickEventHandler : NSObject
//{
//@public
//    RoxeePlatipus::LesserWindow* monitor;
//}
//- (void)handle:(NSAppleEventDescriptor*)event withReplyEvent:(NSAppleEventDescriptor*)replyEvent;
//@end

//@implementation DockIconClickEventHandler
//- (void)handle:(NSAppleEventDescriptor*)event withReplyEvent:(NSAppleEventDescriptor*)replyEvent {
//    NSLog(@"Has clikcy deep inside");
//    if (monitor)
//        monitor->emitClicky();
//}
//@end


namespace RoxeePlatipus{

// Access system prefs in a funky way
// http://stackoverflow.com/questions/6099338/how-to-know-if-window-is-minimizable-when-titlebar-was-double-clicked

//class LesserWindow::Private
//{
//    public:
//        DockIconClickEventHandler* handler;
//};

LesserWindow::LesserWindow(QWidget *parent)
    : QWidget(parent)
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

//    // Clicky handler
//    d = new LesserWindow::Private();
//    d->handler = [[DockIconClickEventHandler alloc] init];
//    d->handler->monitor = this;

//    [[NSAppleEventManager sharedAppleEventManager]
//     setEventHandler:d->handler
//     andSelector:@selector(handle:withReplyEvent:)
//     forEventClass:kCoreEventClass
//     andEventID:kAEReopenApplication];
//    // End of clicky handler

//    qDebug() << "Installed shity click";




    // XXX stoping here
    // SetMovable works for QT5, not QT4 - and it's unproven what happens before OSX Lion
    // Right now, the code is left in a state where it only works in QT5
    // And has lots of bugs (on release stopShit doesn't work outside of the view)
    NSView *nsview = (NSView *) this->winId();
    NSWindow *nswindow = [nsview window];
    // Changing style mask
//    if([nswindow respondsToSelector:@selector(toggleFullScreen:)]){
        // QT5 here
        // Lion get this
        NSResponder *resp = [nswindow firstResponder];
//        NSUInteger masks = [nswindow styleMask];
//        [nswindow setStyleMask: masks&~NSTitledWindowMask]; // NSBorderlessWindowMask|NSResizableWindowMask]; &NSTexturedBackgroundWindowMask
//        [nswindow setStyleMask: NSTitledWindowMask|NSTexturedBackgroundWindowMask|NSResizableWindowMask]; // NSBorderlessWindowMask|NSResizableWindowMask]; &NSTexturedBackgroundWindowMask
        [nswindow setStyleMask: NSTitledWindowMask|NSTexturedBackgroundWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask]; // NSBorderlessWindowMask|NSResizableWindowMask]; &NSTexturedBackgroundWindowMask
        [nswindow makeFirstResponder: resp];
        [nswindow makeKeyAndOrderFront:nswindow];
        [nswindow setMovableByWindowBackground: NO];
//        NSBorderlessWindowMask = 0,
//        NSTitledWindowMask = 1 << 0,
//        NSClosableWindowMask = 1 << 1,
//        NSMiniaturizableWindowMask = 1 << 2,
//        NSResizableWindowMask = 1 << 3,
//        NSTexturedBackgroundWindowMask = 1 << 8

        //    }else{
//        // QT4 here
//        // Non Lion get the usual punishment - nothing else seems to work - and break havoc when coming from fullscreen
//        this->setWindowFlags(Qt::FramelessWindowHint);//  | Qt::WindowSystemMenuHint);
//    }

//    this->setWindowFlags(Qt::FramelessWindowHint);//  | Qt::WindowSystemMenuHint);
    [pool release];
//    installEventFilter(this);
}

//void LesserWindow::emitClicky()
//{
//    qDebug() << "Got a clicky click on the docky";
//    emit dockIconClicked();
//}

//LesserWindow::~LesserWindow()
//{
//    delete d;
//}

void LesserWindow::startMovable()
{
    qDebug() << "Start movable";
    NSView *nsview = (NSView *) this->winId();
    NSWindow *nswindow = [nsview window];
    [nswindow setMovableByWindowBackground: YES];
}

void LesserWindow::stopMovable()
{
    qDebug() << "Stop movable";
    NSView *nsview = (NSView *) this->winId();
    NSWindow *nswindow = [nsview window];
    [nswindow setMovableByWindowBackground: NO];
}


// The reason for this is that QT is broken when it comes to maximize and/or n/ne/w resizing
int LesserWindow::x() const
{
    NSView *nsview = (NSView *) this->winId();
    NSWindow *nswindow = [nsview window];
    return [nswindow frame].origin.x;
}

void LesserWindow::move(int x, int y)
{
    NSView *nsview = (NSView *) this->winId();
//    int delta = [[NSScreen mainScreen] frame].size.height - [[NSScreen mainScreen] visibleFrame].size.height;
//    if(delta > 0 && delta > y)
//        y = delta;

    NSWindow *nswindow = [nsview window];
    NSPoint newPoint = NSMakePoint (x, [[NSScreen mainScreen] frame].size.height - y);

    qDebug() << "*******";
    qDebug() << this->x();
    qDebug() << newPoint.x;
//    qDebug() << this->y();
//    qDebug() << newPoint.y;

    [nswindow setFrameTopLeftPoint: newPoint];
}

int LesserWindow::y() const
{
    NSView *nsview = (NSView *) this->winId();
    return ([[NSScreen mainScreen] frame].size.height - [[nsview window] frame].origin.y - [[nsview window] frame].size.height);
}

bool LesserWindow::minimizeOnDoubleClick() const
{
    //Get settings from "System Preferences" >  "Appearance" > "Double-click on windows title bar to minimize"
    NSString *const MDAppleMiniaturizeOnDoubleClickKey = @"AppleMiniaturizeOnDoubleClick";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults addSuiteNamed:NSGlobalDomain];
    return [[userDefaults objectForKey:MDAppleMiniaturizeOnDoubleClickKey] boolValue];
}

bool LesserWindow::hasNaturalStyle() const
{
    NSString * const kAppleAquaColorVariant = @"AppleAquaColorVariant";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults addSuiteNamed:NSGlobalDomain];
    NSNumber *color = [userDefaults objectForKey:kAppleAquaColorVariant];
    // graphite is 6
    // acqua is 1
    return !([color intValue] == 6);
}

bool LesserWindow::needsResizer() const
{
    NSView *nsview = (NSView *) this->winId();
    NSWindow *nswindow = [nsview window];
    // Lion get this
    return ![nswindow respondsToSelector:@selector(toggleFullScreen:)];
}

//bool LesserWindow::eventFilter(QObject * object, QEvent *event)
//{
//    qDebug() << "have" << event->type();
//    NSView *nsview = (NSView *) this->winId();
//    NSWindow *nswindow = [nsview window];
//    NSRect f = [nswindow frame];

//    switch(event->type()){
//    case QEvent::Resize:
//    case QEvent::UpdateRequest:
//        [nsview setFrame: NSMakeRect(0, 0, f.size.width, f.size.height)];
//        [nsview setNeedsDisplay: YES];
//        qDebug() << "IN the mix";
//        break;
////    case QEvent::MouseButtonPress:
////    case QEvent::MouseButtonRelease:
////    case QEvent::MouseButtonDblClick:
////    case QEvent::MouseMove:
////    case QEvent::WindowActivate:
////    case QEvent::WindowDeactivate:
////    case QEvent::Paint:
//    default:
//        break;
//    }
//    return QWidget::eventFilter(object, event);
//}

//void LesserWindow::repaint()
//{
//    qDebug() << "REPAINTTTTTT";
//    NSView *nsview = (NSView *) this->winId();
//    NSWindow *nswindow = [nsview window];
//    NSRect f = [nswindow frame];
//    [nsview setFrame: NSMakeRect(0, -5, f.size.width, f.size.height + 50)];
//}

//void LesserWindow::update()
//{
//    qDebug() << "UPDATE";
//    NSView *nsview = (NSView *) this->winId();
//    NSWindow *nswindow = [nsview window];
//    NSRect f = [nswindow frame];
//    [nsview setFrame: NSMakeRect(0, -5, f.size.width, f.size.height + 50)];
//}

/*
void LesserWindow::setGeometry(int x, int y, int w, int h)
{
    qDebug() << "Trix and trix";

    QDesktopWidget * d = QApplication::desktop();
    QRect r = d->screenGeometry();

    NSView *nsview = (NSView *) this->winId();
    NSWindow *nswindow = [nsview window];
    // First, position the window itself correctly
//    [nswindow setFrameTopLeftPoint: NSMakePoint(x, r.height() - y)];
//    qDebug() << x;
//    qDebug() << r.width();
//    qDebug() << y;
//    qDebug() << r.height() - y;
    // Now, put the frame
    [nsview setFrame: NSMakeRect(0, 20, w, h + 20)];

    int dy = y - this->y();
//    NSFrameRect * f = [nswindow frame];
    int fy = [nsview frame].origin.y + dy;
//    [nsview setFrame: NSMakeRect(x, y, w, h)];
    qDebug() << [nsview frame].origin.x;
    qDebug() << [nsview frame].origin.y;
    qDebug() << [nsview frame].size.width;
    qDebug() << [nsview frame].size.height;
    qDebug() << x;
    qDebug() << y;
    qDebug() << w;
    qDebug() << h;
    qDebug() << [nsview frame].origin.x;
    qDebug() << [nsview frame].origin.y - dy;
    qDebug() << [nsview frame].size.width;
    qDebug() << [nsview frame].size.height;
//    QWidget::setGeometry(x, y, w, h);
//    [nswindow frame].origin.x = x;
//    [nswindow frame].origin.y = [nswindow frame].origin.y + dy;
//    [nswindow frame].size.w = w;
//    [nswindow frame].size.h = h;
}

*/

}

//int MainWidget::x()
//{

//}

//void MainWidget::setGeometry(int x, int y, int w, int h)
//{
//    qDebug() << "Doing the nasty dance";
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

//    NSView *nsview = (NSView *) this->winId();
//    NSWindow *window = [nsview window];

//    // XXXX

//    //    NSTitledWindowMask|NSResizableWindowMask
////        NSUInteger masks = 15;// [window styleMask];
////        [window setStyleMask: masks&~NSTitledWindowMask]; //NSBorderlessWindowMask
//// XXXX

//    NSPoint testPoint;
//    testPoint = NSMakePoint (x, y);

//    [window cascadeTopLeftFromPoint: testPoint];
//    [pool release];
//    // And force ourselves like crazies
//    QMacNativeWidget::setGeometry(0, 0, w, h);
//}

//void MainWidget::toto()
//{
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

//    NSWindow *window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 800, 600)
//                        styleMask: NSResizableWindowMask|NSTitledWindowMask|NSResizableWindowMask|NSClosableWindowMask|NSTexturedBackgroundWindowMask
//                        backing:NSBackingStoreBuffered defer:NO];

//    [window setMovableByWindowBackground: YES];

////styleMask:NSTitledWindowMask|NSResizableWindowMask|NSClosableWindowMask
//    // NSBorderlessWindowMask|
////    NSWindow *window = [[NSWindow alloc] initWithContentRect:NSMakeRect(200, app.desktop()->height() - 200, 239, 200)
////                             styleMask:NSTitledWindowMask | NSClosableWindowMask
////                                       | NSMiniaturizableWindowMask | NSResizableWindowMask
////                             backing:NSBackingStoreBuffered defer:NO];

//    //    [nswindow setMovableByWindowBackground: YES];
////    NSUInteger masks = [nswindow styleMask];
////    qDebug() << "has masks" << masks;
////    [nswindow setStyleMask: masks&~NSTitledWindowMask]; // NSBorderlessWindowMask|NSResizableWindowMask];
////    qDebug() << "bitch is working modal" << [nswindow worksWhenModal];
////    [nswindow makeKeyWindow];
////    [nswindow makeMainWindow];


////    QMacNativeWidget *nativeWidget = new QMacNativeWidget();
//    this->move(0, 0);
//    this->setPalette(QPalette(Qt::red));
//    this->setAutoFillBackground(true);
//    this->setAttribute(Qt::WA_LayoutUsesWidgetRect);
////    QVBoxLayout *layout = new QVBoxLayout();
////    QPushButton *pushButton = new QPushButton("An Embedded Qt Button!", nativeWidget);
////    pushButton->setAttribute(Qt::WA_LayoutUsesWidgetRect); // Don't use the layout rect calculated from QMacStyle.
////    layout->addWidget(pushButton);
////    nativeWidget->setLayout(layout);

//    // Adjust Cocoa layouts
//    NSView *nativeWidgetView = reinterpret_cast<NSView *>(this->winId());
//    NSView *contentView = [window contentView];

//    [contentView setAutoresizesSubviews:YES];

//    [nativeWidgetView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
//    [nativeWidgetView setAutoresizesSubviews:YES];

//    //    NSView *pushButtonView = reinterpret_cast<NSView *>(pushButton->winId());
////    [pushButtonView setAutoresizingMask:NSViewWidthSizable];

//    // Add the nativeWidget to the window.
//    [contentView addSubview:nativeWidgetView]; //  positioned:NSWindowAbove relativeTo:nil];


//    NSPoint testPoint;
//    testPoint = NSMakePoint (0, 0);
//    [nativeWidgetView setFrameOrigin: testPoint];
//    [contentView setFrameOrigin: testPoint];

//    this->show();

//    //    pushButton->show();

//    // Show the window.
//    [window makeKeyAndOrderFront:window];
//    [pool release];

////    QMacNativeWidget::show();
//}



/*
void MainWidget::paintEvent(QPaintEvent *aPaintEvent)
{
    qDebug() << "CULLLL";
    qreal opacity(1);
    int roundness(12);
  QRect widget_rect = this->rect();

    QPainter painter(this);
    painter.save();

    painter.setRenderHint(QPainter::Antialiasing);
    painter.setPen(Qt::red);

  // clip
    QPainterPath rounded_rect;
    rounded_rect.addRoundRect(1, 1, widget_rect.width() - 2, widget_rect.height() - 2, roundness, roundness);
    painter.setClipPath(rounded_rect);

    // get clipping region
  QRegion maskregion = painter.clipRegion();

  // mask the widget
  setMask(maskregion);
  painter.setOpacity(opacity);

  // fill path with color
  painter.fillPath(rounded_rect,QBrush(Qt::black));

  // restore painter
  painter.restore();

}
*/


//void MainWidget::paintEvent(QPaintEvent * /*e*/)
//{
//    qDebug() << " [Widget Events] paint";
////    static const QPoint hourHand[3] = {
////        QPoint(7, 8),
////        QPoint(-7, 8),
////        QPoint(0, -40)
////    };
////    static const QPoint minuteHand[3] = {
////        QPoint(7, 8),
////        QPoint(-7, 8),
////        QPoint(0, -70)
////    };

////    QColor hourColor(127, 0, 127);
////    QColor minuteColor(0, 127, 127, 191);

////    int side = qMin(width(), height());

////    QPainter painter(this);
////    painter.setRenderHint(QPainter::Antialiasing);
////    painter.translate(width() / 2, height() / 2);
////    painter.scale(side / 200.0, side / 200.0);

////    painter.setPen(Qt::NoPen);
////    painter.setBrush(hourColor);

////    painter.save();
//////    painter.rotate(30.0 * ((time.hour() + time.minute() / 60.0)));
////    painter.drawConvexPolygon(hourHand, 3);
////    painter.restore();

////    painter.setPen(hourColor);

////    for (int i = 0; i < 12; ++i) {
////        painter.drawLine(88, 0, 96, 0);
////        painter.rotate(30.0);
////    }

////    painter.setPen(Qt::NoPen);
////    painter.setBrush(minuteColor);

////    painter.save();
////    // painter.rotate(6.0 * (time.minute() + time.second() / 60.0));
////    painter.drawConvexPolygon(minuteHand, 3);
////    painter.restore();

////    painter.setPen(minuteColor);

////    for (int j = 0; j < 60; ++j) {
////        if ((j % 5) != 0)
////            painter.drawLine(92, 0, 96, 0);
////        painter.rotate(6.0);
////    }
//}

//void MainWidget::resizeEvent(QResizeEvent * /*event*/)
//{
//    qDebug() << " [Widget Events] resize";
////    int side = qMin(width(), height());
////    QRegion maskedRegion(width() / 2 - side / 2, height() / 2 - side / 2, side,
////                         side, QRegion::Ellipse);
////    setMask(maskedRegion);
//}


//void MainWidget::mousePressEvent(QMouseEvent */*event*/)
//{
//    qDebug() << " [Widget Events] mousePress";
//}

//void MainWidget::mouseReleaseEvent(QMouseEvent */*event*/)
//{
//    qDebug() << " [Widget Events] mouseRelease";
//}

//void MainWidget::mouseDoubleClickEvent(QMouseEvent */*event*/)
//{
//    qDebug() << " [Widget Events] mouseDoubleClick";
//}


//void MainWidget::keyPressEvent(QKeyEvent */*event*/)
//{
//    qDebug() << " [Widget Events] keyPress";
//}

//void MainWidget::focusInEvent(QFocusEvent */*event*/)
//{
//    qDebug() << " [Widget Events] focusIn";
//}

//void MainWidget::focusOutEvent(QFocusEvent */*event*/)
//{
//    qDebug() << " [Widget Events] focusOut";
//}

//void MainWidget::mouseMoveEvent(QMouseEvent */*event*/)
//{
//    qDebug() << " [Widget Events] mouseMove";
//}

//void MainWidget::keyReleaseEvent(QKeyEvent * /*event*/)
//{
//    qDebug() << " [Widget Events] keyRelease";
//}

//void MainWidget::wheelEvent(QWheelEvent * /*event*/)
//{
//    qDebug() << " [Widget Events] ************************* wheel";
//}


//void MainWidget::enterEvent(QEvent * /*event*/)
//{
//    qDebug() << " [Widget Events] enter";
//}

//void MainWidget::leaveEvent(QEvent * /*event*/)
//{
//    qDebug() << " [Widget Events] leave";
//}

//void MainWidget::moveEvent(QMoveEvent * /*event*/)
//{
//    qDebug() << " [Widget Events] move";
//}

//void MainWidget::closeEvent(QCloseEvent * /*event*/)
//{
//    qDebug() << " [Widget Events] close";
//}

