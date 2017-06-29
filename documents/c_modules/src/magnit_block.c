/*
 * Project name   : Human detection by HOG
 * File name      : magnit_block.c
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Thu 13 Apr 2017
 * Desc           :
 */

#include <magnit_block.h>

unsigned magnit_block(float *result, int8 *dx, int8 *dy, uint32 w, uint32 h)
{
    uint32  i;
    for (i = 0; i < w * h; i++)
        result[i] = magnit_pixel(dx[i], dy[i]);
}

float magnit_pixel(int8 dx, int8 dy)
{
    float   result;
    if (dx == 0)
        result = (float)dy;
    else if (dy == 0)
        result = (float)dx;
    else if (dx <= 16 && dy <= 16)
        result = LUT_magnit[(dx - 1) * 16 + dy - 1];
    else
        result = sqrt(dx * dx + dy * dy);

    return result;
}
