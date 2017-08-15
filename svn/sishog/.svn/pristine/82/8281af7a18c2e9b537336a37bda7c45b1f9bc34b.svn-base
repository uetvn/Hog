/*
 * Project name   : Human detection by HOG
 * File name      : svm_window.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#ifndef SVM_WINDOW_H
#define SVM_WINDOW_H

#include "pack.h"

/*
 * hog_column : hog feature's image window
 * Desciptions: using svm classification to detect object in image window, if detected object then return 1
 */
uint8 svm_classification(struct HOG_window *hog_column);

/*
 * classificating svm of 16x16 pixel block
 */
unsigned svm_block_16x16(float *result, float *hog, float *svm);

#endif
