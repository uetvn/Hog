/*
 * Project name   : Human detection by HOG
 * File name      : svm_classification.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#ifndef SVM_H
#define SVM_H

#include "mytypes.h"
#include "pack.h"

uint8 svm_classification(struct HOG_window *hog_column);

#endif
