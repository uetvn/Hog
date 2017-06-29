/*
 * Project name   : Human detection by HOG
 * File name      : hog_next_window.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#include "hog_next_window.h"

/* Using window 128x64 = 7x15 block */
unsigned hog_next_window(struct HOG_window *hog_column, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    uint8   i;
    for (i = 0; i < columns; i++) {
        hog_next_row(hog_column[i].hog_row, head, src, w, h);
        head    += 8 * w;
    }
    return 0;
}
