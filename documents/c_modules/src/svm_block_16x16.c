/*
 * Project name   : Human detection by HOG
 * File name      : svm_block_16x16.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#include "svm_block_16x16.h"

unsigned svm_block_16x16(float *result, float *hog, float *svm)
{
    uint8   i;
    for (i = 0; i < 36; i++)
        *result += hog[i] * svm[i];
    return 0;
}
