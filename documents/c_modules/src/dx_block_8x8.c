/*
 * Project name   : Human detection by HOG
 * File name      : dx_block_8x8.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Thu 13 Apr 2017
 * Desc           :
 */

#include "dx_block_8x8.h"

unsigned dx_block_8x8(int8 *result, uint32 head, uint8 *src, uint32 w)
{
    uint8   i;
    for (i = 0; i < 8; i++) {
        result[i]       = dx_pixel(head + i, src, w);
        result[i + 8]   = dx_pixel(head + w + i, src, w);
        result[i + 16]  = dx_pixel(head + 2 * w + i, src, w);
        result[i + 24]  = dx_pixel(head + 3 * w + i, src, w);
        result[i + 32]  = dx_pixel(head + 4 * w + i, src, w);
        result[i + 40]  = dx_pixel(head + 5 * w + i, src, w);
        result[i + 48]  = dx_pixel(head + 6 * w + i, src, w);
        result[i + 56]  = dx_pixel(head + 7 * w + i, src, w);
    }
    return 0;
}

int8 dx_pixel(uint32 head, uint8 *src, uint32 w)
{
    if  (head % w == 0 || head % w + 1 == w)
        return 0;

    int8    value   = src[head + 1] - src[head - 1];

    return value > 0 ? value : 0;
}
