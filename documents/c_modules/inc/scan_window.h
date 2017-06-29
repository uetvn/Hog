/*
 * Project name   : Human detection by HOG
 * File name      : scan_window.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#ifndef SCAN_WINDOW_H
#define SCAN_WINDOW_H

#include "mytypes.h"
#include "pack.h"

unsigned scan_window(uint32 *object, uint8 *src, uint32 w, uint32 h);

#endif
