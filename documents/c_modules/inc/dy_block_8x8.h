/*
 * Project name   : Human detection by HOG
 * File name      : dy_block_8x8.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Thu 13 Apr 2017
 * Desc           :
 */

#ifndef DY_BLOCK_8X8_H
#define DY_BLOCK_8X8_H

#include "mytypes.h"
#include "pack.h"

unsigned dy_block_8x8(int8 *result, uint32 head, uint8 *src, uint32 w, uint32 h);

int8 dy_pixel(uint32 head, uint8 *src, uint32 w, uint32 h);

#endif
