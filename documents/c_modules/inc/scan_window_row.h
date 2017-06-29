/*
 * Project name   : Human detection by HOG
 * File name      : scan_window_row.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#ifndef SCAN_WINDOW_ROW_H
#define SCAN_WINDOW_ROW_H

#include "mytypes.h"
#include "pack.h"

unsigned scan_window_row(uint32 *object, struct HOG_window *hog_column, uint32 head, uint8 *src, uint32 w, uint32 h);

#endif
