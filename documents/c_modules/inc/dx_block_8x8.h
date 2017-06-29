/*
 * Project name   : Human detection by HOG
 * File name      : dx_block_8x8.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Thu 13 Apr 2017
 * Desc           :
 */

#ifndef DX_BLOCK_8X8_H
#define DX_BLOCK_8X8_H

#include "mytypes.h"
#include "pack.h"

unsigned dx_block_8x8(int8 *result, uint32 head, uint8 *src, uint32 w);

int8 dx_pixel(uint32 head, uint8 *src, uint32 w);

#endif
