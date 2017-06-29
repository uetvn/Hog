/*
 * Project name   : Human detection by HOG
 * File name      : angle_block.c
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Thu 13 Apr 2017
 * Desc           :
 */

#include <angle_block.h>

unsigned angle_block(float *result, int8 *dx, int8 *dy, uint32 w, uint32 h)
{
    uint32  i;
    for (i = 0; i < w * h; i++)
        result[i] = angle_pixel(dx[i], dy[i]);
}

float angle_pixel(int8 dx, int8 dy)
{
    float   result;
    if (dy == 0)
        result = 0;
    else if (dx == 0)
        result = PI/2;
    else if (dx <= 16 && dy <= 16)
        result = LUT_angle[(dy - 1) * 16 + dx - 1];
    else
        result = atan((float)dy / dx);// / PI * PI_DEGREE;

    return result;
}
