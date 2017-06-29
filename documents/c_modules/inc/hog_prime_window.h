/*
 * Project name   : Human detection by HOG
 * File name      : hog_prime_window.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#ifndef HOG_PRIME_WINDOW_H
#define HOG_PRIME_WINDOW_H

#include "mytypes.h"
#include "pack.h"

unsigned hog_prime_window(struct HOG_window *hog_window, uint32 head, uint8 *src, uint32 w, uint32 h);

#endif
