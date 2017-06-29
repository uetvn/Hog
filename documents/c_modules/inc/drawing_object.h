/*
 * Project name   : Human detection by HOG
 * File name      : drawing_object.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#ifndef DRAWING_OBJECT_H
#define DRAWING_OBJECT_H

#include "mytypes.h"
#include "pack.h"

unsigned drawing_object(uint32 *object, uint8 *rgb_src, uint32 w, uint32 h);

unsigned drawing_rectange(uint32 head, uint8 *rgb_src, uint32 w, uint32 h);

unsigned convert_color(uint32 head, uint8 *rgb_rc);

#endif
