/*
 * Project name   : Human detection by HOG
 * File name      : RGB2Y_img.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#include "RGB2Y_img.h"

/* Convert RGB to Y of an image */
unsigned RGB2Y_img(uint8 *result, uint8 *src, uint32 w, uint32 h)
{
    uint32	i;
    for (i = 0; i < w * h; i++)
        result[i] = RGB_to_Y(src[3 * i], src[3 * i + 1], src[3 * i + 2]);
	return 0;
}

