/*
 * Project name   : Human detection by HOG
 * File name      : scan_window.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#include "scan_window.h"

/* First elemnent of *object array saves the number of object */
unsigned scan_window(uint32 *object, uint8 *src, uint32 w, uint32 h)
{
    object[0] = 0;
    uint32  head;
    uint32  tail = w * (h - window_h);

    struct HOG_window *hog_column;
    init_hog_window(&hog_column);

    uint32  i;
    for (head = 0; head <= tail; head += 8 * w)
        scan_window_row(object, hog_column, head, src, w, h);
    free_hog_window(hog_column);
    return 0;
}
