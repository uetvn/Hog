/*
 * Project name   : Human detection by HOG
 * File name      : hog_next_row.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#ifndef HOG_NEXT_ROW_H
#define HOG_NEXT_ROW_H

#include "mytypes.h"
#include "pack.h"

unsigned hog_next_row(struct HOG_row *hog_row, uint32 head, uint8 *src, uint32 w, uint32 h);

#endif
