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
#include <AppKit/NSWindow.h>

namespace RoxeePlatipus{

LesserWindow::LesserWindow(QWidget *parent)
    : QWidget(parent)
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSView *nsview = (NSView *) this->winId();
    NSWindow *nswindow = [nsview window];
    NSResponder *resp = [nswindow firstResponder];
    [nswindow setMovableByWindowBackground: YES];
    NSUInteger masks = [nswindow styleMask];
    // Changing style mask
    [nswindow setStyleMask: masks&~NSTitledWindowMask]; // NSBorderlessWindowMask|NSResizableWindowMask];
    [nswindow makeFirstResponder: resp];
    [nswindow makeKeyAndOrderFront:nswindow];
    [pool release];
}

// The reason for this is that QT is broken when it comes to maximize and/or n/ne/w resizing
int LesserWindow::x() const
{
    NSView *nsview = (NSView *) this->winId();
    NSWindow *nswindow = [nsview window];
    return [nswindow frame].origin.x;
}

int LesserWindow::y() const
{
    QDesktopWidget * d = QApplication::desktop();
    QRect r = d->geometry();
    NSView *nsview = (NSView *) this->winId();
    NSWindow *nswindow = [nsview window];
    return (r.height() - [nswindow frame].origin.y - [nswindow frame].size.height);
}
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

