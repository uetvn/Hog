/*
 * Project name   : Human detection by HOG
 * File name      : hog_block_16x16.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#ifndef HOG_BLOCK_16X16_H
#define HOG_BLOCK_16X16_H

#include "mytypes.h"
#include "pack.h"

unsigned hog_block_16x16(float *result, uint32 head, uint8 *src, uint32 w, uint32 h);

#endif
