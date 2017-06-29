/*
 * Project name   : Human detection by HOG
 * File name      : svm_block_16x16.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#ifndef SVM_BLOCK_16X16_H
#define SVM_BLOCK_16X16_H

#include "mytypes.h"
#include "pack.h"

unsigned svm_block_16x16(float *result, float *hog, float *svm);

#endif
