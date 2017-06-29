/*
 * Project name   : Human detection by HOG
 * File name      : magnit_block.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Thu 13 Apr 2017
 * Desc           :
 */

#ifndef MAGNIT_BLOCK_H
#define MAGNIT_BLOCK_H

#include "mytypes.h"
#include "pack.h"

unsigned magnit_block(float *result, int8 *dx, int8 *dy, uint32 w, uint32 h);

float magnit_pixel(int8 dx, int8 dy);

#endif
