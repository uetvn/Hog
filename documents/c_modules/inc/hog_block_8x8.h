/*
 * Project name   : Human detection by HOG
 * File name      : HOG_block_8x8.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Thu 13 Apr 2017
 * Desc           :
 */

#ifndef HOG_BLOCK_8X8_H
#define HOG_BLOCK_8X8_H

#include "mytypes.h"
#include "pack.h"

unsigned hog_block_8x8(float *hog_9bin, uint32 head, uint8 *src, uint32 w, uint32 h);

unsigned calculate_hog_9bin(float *hog_9bin, float *magnit, float *angle);

#endif
