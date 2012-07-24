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

#ifndef ROXEEPLATIPUS_BASEPOWERMANAGEMENT_H
#define ROXEEPLATIPUS_BASEPOWERMANAGEMENT_H

#include "libroxeeplatipus/libroxeeplatipus_global.h"
#include <QtCore/qobject.h>
#include <QtCore/qdebug.h>

namespace RoxeePlatipus {

class LIBROXEEPLATIPUSSHARED_EXPORT BasePowerManagement : public QObject
{
  Q_OBJECT

public:
  BasePowerManagement(QObject * /*parent*/ = 0)
  {
      qDebug() << " [M] System/PowerManagement: constructor";
  }

  ~BasePowerManagement()
  {
      qDebug() << " [M] System/PowerManagement: destructor";
  }

  Q_PROPERTY(uint state READ getState WRITE setState)
  Q_PROPERTY(uint NONE READ none)
  Q_PROPERTY(uint SYSTEM READ system)
  Q_PROPERTY(uint SCREEN READ screen)

  uint getState(){return 0;}
  void setState(uint /* busy */ ){}
  uint none()   {return 0;}
  uint system() {return 1;}
  uint screen() {return 2;}

};

}

#endif // ROXEEPLATIPUS_BASEPOWERMANAGEMENT_H
