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

#ifndef ROXEEPLATIPUS_LESSERWINDOW_H
#define ROXEEPLATIPUS_LESSERWINDOW_H

#include "libroxeeplatipus/libroxeeplatipus_global.h"
#include <QWidget>

namespace RoxeePlatipus {

class LIBROXEEPLATIPUSSHARED_EXPORT LesserWindow: public QWidget {
    Q_OBJECT
public:
    explicit LesserWindow(QWidget *parent = 0);
    int x() const;
    int y() const;

    //    void toto();
//    void setGeometry(int x, int y, int w, int h);

    //protected:
//    void paintEvent(QPaintEvent *event);
//    void resizeEvent(QResizeEvent *event);
//    void mousePressEvent(QMouseEvent *event);
//    void mouseReleaseEvent(QMouseEvent *event);
//    void mouseDoubleClickEvent(QMouseEvent *event);

//    void keyPressEvent(QKeyEvent *event);
//    void focusInEvent(QFocusEvent *event);
//    void focusOutEvent(QFocusEvent *event);

//    void mouseMoveEvent(QMouseEvent *event);
//    void keyReleaseEvent(QKeyEvent * event);
//    void wheelEvent(QWheelEvent * event);

//    void enterEvent(QEvent * event);
//    void leaveEvent(QEvent * event);
//    void moveEvent(QMoveEvent * event);
//    void closeEvent(QCloseEvent * event);

//    bool event(QEvent * event)
//    {
//        qDebug() << "tipie" << event->type();
////        if(event->type() == QEvent::Resize){
////        if(event->type() == QEvent::LayoutRequest){
//        if(event->type() == QEvent::UpdateRequest){
//            qDebug() << "Getting relayout in main widget";
//            QRect r(0, 0, this->width(), this->height());
//            QStackedLayout * l = (QStackedLayout *) this->layout();
//            l->currentWidget()->setGeometry(r);
//            qDebug() << "Realyouting" << l->currentWidget();
//            event->accept();
//            return true;
////            this->setGeometry(0, 0, 1000, 1000);
//        }
//        QWidget::event(event);
//    }

//    void setGeometry(int x, int y, int w, int h)
//    {
//        qDebug() << "INTERCEPTING SHIT";
////        if(w < this->minimumWidth())
////            w = this->minimumWidth();
////        if(h < this->minimumHeight())
////            h = this->minimumHeight();
//        QRect r(x, y, w, h);
//        QWidget::setGeometry(r);
//        QRect r2d2(0, 0, this->width(), this->height());
//        this->layout()->setGeometry(r2d2);
//    }



protected:
    // Emit mouse moves over the video player
//    void mouseMoveEvent(QMouseEvent *)
//    {
//        qDebug() << "GOT A MOVE DAMNITE";
////        emit outboundMouseMove(event);
//    }


//    void dropEvent(QDropEvent * e)
//    {
//        if(e->mimeData()->urls().length()){
//            QList<QUrl> ulist = e->mimeData()->urls();
//            QFileInfo * inf;
//            foreach (QUrl u, ulist){
//                qDebug() << "Received drops: " << u.path();
//                inf = new QFileInfo(u.path());
//                if(inf->isDir())
//                    emit hasDirectoryDrop(u.path());
//                else if(inf->isFile())
//                    emit hasFileDrop(u.path());
//            }
//        }
//        e->acceptProposedAction();
//    }

//    void dragEnterEvent(QDragEnterEvent *e)
//    {
//        if(e->mimeData()->urls().length()){
//            qDebug() << "Received drops";
//        }
//        e->acceptProposedAction();
//    }

//    bool macEvent ( EventHandlerCallRef caller, EventRef event )
//    {
////        [NSApplication sharedApplication];
//        qDebug() << " Mac event handling on the container";
//        qDebug() << event;
//        return false;
////        return QWidget::macEvent(caller, event);
//    }


signals:
//    void outboundMouseMove();
//    void hasFileDrop(const QString & path);
//    void hasDirectoryDrop(const QString & path);

public slots:
    
};
}

#endif // ROXEEPLATIPUS_LESSERWINDOW_H

