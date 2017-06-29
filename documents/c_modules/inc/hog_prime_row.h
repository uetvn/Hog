/*
 * Project name   : Human detection by HOG
 * File name      : hog_prime_row.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Thu 13 Apr 2017
 * Desc           :
 */

#ifndef HOG_PRIME_ROW_H
#define HOG_PRIME_ROW_H

#include "mytypes.h"
#include "pack.h"

unsigned hog_prime_row(struct HOG_row *hog_row, uint32 head, uint8 *src, uint32 w, uint32 h);

#endif
