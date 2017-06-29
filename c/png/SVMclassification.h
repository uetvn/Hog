/*
 * Project name   :
 * File name      : SVMclassification.c
 * Created date   : Fri 24 Mar 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 24 Mar 2017
 * Desc           :
 */

#include <stdio.h>
#include "helper.h"

/*
 * Compare between HOG feature and SVM feature to detect
 * - nDetects		is number of position
 * - save_detects	is the info of position
 * - pointer		is extend window pointer
 */
void SVM_Classification(float *HOG_Feature, uint8 *nDetects, struct Object *save_detects, uint32 pointer);
