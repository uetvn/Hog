/*
 * Project name   : Human detection by HOG
 * File name      : hog_prime_window.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#include "hog_prime_window.h"

/* Using window (window_w)x(window_h): (rows)x(columns) block */
unsigned hog_prime_window(struct HOG_window *hog_column, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    uint8   i;
    for (i = 0; i < columns; i++) {
        hog_prime_row(hog_column[i].hog_row, head, src, w, h);
        head    += 8 * w;
    }
    return 0;
}
