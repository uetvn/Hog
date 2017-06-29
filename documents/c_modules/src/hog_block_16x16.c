/*
 * Project name   : Human detection by hog
 * File name      : hog_block_16x16.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#include <hog_block_16x16.h>

unsigned hog_block_16x16(float *result, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    float   *hog_8x8_1  = malloc(sizeof(float) * 9);
    float   *hog_8x8_2  = malloc(sizeof(float) * 9);
    float   *hog_8x8_3  = malloc(sizeof(float) * 9);
    float   *hog_8x8_4  = malloc(sizeof(float) * 9);

    hog_block_8x8(hog_8x8_1, head,             src, w, h);
    hog_block_8x8(hog_8x8_2, head + 8 * w,     src, w, h);
    hog_block_8x8(hog_8x8_3, head + 8,         src, w, h);
    hog_block_8x8(hog_8x8_4, head + 8 * w + 8, src, w, h);

    norm_block_16x16(result, hog_8x8_1, hog_8x8_2, hog_8x8_3, hog_8x8_4);

    return 0;
}
