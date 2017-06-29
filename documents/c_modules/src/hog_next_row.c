/*
 * Project name   : Human detection by HOG
 * File name      : hog_next_row.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#include "hog_next_row.h"

/* Using window 128x64 = 7x15 block */
unsigned hog_next_row(struct HOG_row *hog_row, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    float *next_row = malloc(sizeof(float) * 36);
    head    += window_w - 16;
    hog_block_16x16(next_row, head, src, w, h);
    free(hog_row[0].hog_block_16x16);

    uint8   i;
    for (i = 0; i < rows - 1; i++) {
        hog_row[i].hog_block_16x16 = hog_row[i + 1].hog_block_16x16;
    }
    hog_row[rows - 1].hog_block_16x16 = next_row;

    return 0;
}
