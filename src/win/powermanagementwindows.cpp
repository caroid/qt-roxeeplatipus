#include "powermanagementwindows.h"

#include <Windows.h>
#include <QtCore/qdebug.h>

PowerManagementWindows::PowerManagementWindows(QObject *parent) :
    BasePowerManagement(parent), m_busy(0)
{
    qDebug() << " [M] System/PowerManagement: constructor";
}

uint PowerManagementWindows::getState()
{
    qDebug() << " [M] System/PowerManagement: query state";
    return m_busy;
}

void PowerManagementWindows::setState(uint busy)
{
    qDebug() << " [M] System/PowerManagement: set new state";
    if(m_busy == busy){
        return;
    }
    m_busy = busy;
    if(busy){
        SetThreadExecutionState(ES_CONTINUOUS | ES_SYSTEM_REQUIRED);
    }else{
        SetThreadExecutionState(ES_CONTINUOUS);
    }
    return;
}

