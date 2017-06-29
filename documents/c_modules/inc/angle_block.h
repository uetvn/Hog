/*
 * Project name   : Human detection by HOG
 * File name      : angle_block.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Thu 13 Apr 2017
 * Desc           :
 */

#ifndef ANGLE_BLOCK_H
#define ANGLE_BLOCK_H

#include "mytypes.h"
#include "pack.h"

unsigned angle_block(float *result, int8 *dx, int8 *dy, uint32 w, uint32 h);

float angle_pixel(int8 dx, int8 dy);

#endif
