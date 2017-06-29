/*
 * Project name   : Human detection by HOG
 * File name      : hog_prime_row.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Thu 13 Apr 2017
 * Desc           :
 */

#include "hog_prime_row.h"

/* Using window 128x64 = 7x15 block */
unsigned hog_prime_row(struct HOG_row *hog_row, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    float   *hog_8x8_1    = malloc(sizeof(float) * 9);
    float   *hog_8x8_2    = malloc(sizeof(float) * 9);
    float   *hog_8x8_3    = malloc(sizeof(float) * 9);
    float   *hog_8x8_4    = malloc(sizeof(float) * 9);

    /* Precalcultion */
    hog_block_8x8(hog_8x8_1,  head,         src, w, h);
    hog_block_8x8(hog_8x8_2,  head + 8 * w, src, w, h);

    uint32  i;
    for (i = 0; i < rows; i++) {
        head    += 8;
        hog_block_8x8(hog_8x8_3,  head, src, w, h);
        hog_block_8x8(hog_8x8_4,  head + 8 * w, src, w, h);

        norm_block_16x16(hog_row[i].hog_block_16x16, hog_8x8_1, hog_8x8_2, hog_8x8_3, hog_8x8_4);
        i++;
        if (i == rows)
            break;

        head    += 8;
        hog_block_8x8(hog_8x8_1,  head, src, w, h);
        hog_block_8x8(hog_8x8_2,  head + 8 * w, src, w, h);

        norm_block_16x16(hog_row[i].hog_block_16x16, hog_8x8_3, hog_8x8_4, hog_8x8_1, hog_8x8_2);
    }

    return 0;
}
