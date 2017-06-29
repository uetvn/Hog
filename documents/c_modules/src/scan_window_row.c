/*
 * Project name   : Human detection by HOG
 * File name      : scan_window_row.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#include "scan_window_row.h"

unsigned scan_window_row(uint32 *object, struct HOG_window *hog_column, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    hog_prime_window(hog_column, head, src, w, h);

    if (svm_classification(hog_column) == 1)
        saving_object(object, head);

    uint32  i;
    for (i = head; i <=  head + w - window_w; i += 8) {
        hog_next_window(hog_column, i, src, w, h);

        if (svm_classification(hog_column) == 1)
            saving_object(object, i);
    }

    return 0;
}
