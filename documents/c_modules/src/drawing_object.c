/*
 * Project name   : Human detection by HOG
 * File name      : drawing_object.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#include "drawing_object.h"

unsigned drawing_object(uint32 *object, uint8 *rgb_src, uint32 w, uint32 h)
{
    uint32  i;
    uint32  head;
    for (i = 0; i < object[0]; i++) {
        head    = object[i + 1];
        drawing_rectange(head, rgb_src, w, h);
    }
}

unsigned drawing_rectange(uint32 head, uint8 *rgb_src, uint32 w, uint32 h)
{
    uint32   i;
    for(i = 0; i < window_w; i++) {
        convert_color(head + i, rgb_src);
        convert_color(head + w * window_h + i, rgb_src);
    }
    for(i = 0; i < window_h; i++) {
        convert_color(head + i * w, rgb_src);
        convert_color(head + i * w + window_w, rgb_src);
    }


}

unsigned convert_color(uint32 head, uint8 *rgb_rc)
{
    rgb_rc[3 * head]     = 255;
    rgb_rc[3 * head + 1] = 255;
    rgb_rc[3 * head + 2] = 255;
    return 0;
}
