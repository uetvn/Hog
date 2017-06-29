/*
 * Project name   : Human detection by HOG
 * File name      : dy_block_8x8.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Thu 13 Apr 2017
 * Desc           :
 */

#include "dy_block_8x8.h"

unsigned dy_block_8x8(int8 *result, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    uint8   i;
    for (i = 0; i < 8; i++) {
        result[i]       = dy_pixel(head + i, src, w, h);
        result[i + 8]   = dy_pixel(head + w + i, src, w, h);
        result[i + 16]  = dy_pixel(head + 2 * w + i, src, w, h);
        result[i + 24]  = dy_pixel(head + 3 * w + i, src, w, h);
        result[i + 32]  = dy_pixel(head + 4 * w + i, src, w, h);
        result[i + 40]  = dy_pixel(head + 5 * w + i, src, w, h);
        result[i + 48]  = dy_pixel(head + 6 * w + i, src, w, h);
        result[i + 56]  = dy_pixel(head + 7 * w + i, src, w, h);
    }
    return 0;
}

int8 dy_pixel(uint32 head, uint8 *src, uint32 w, uint32 h)
{
    _assert(head < w * h);

    if  (head < w  || head >= w * (h - 1))
        return 0;

    int8    value   = src[head + w] - src[head - w];

    return value > 0 ? value : 0;
}
