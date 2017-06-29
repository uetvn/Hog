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
void SVM_Classification(float *HOG_Feature, uint8 *nDetects, struct Object *save_detects, uint32 pointer)
{
	float   *trainSVM       = readFileFloats("trainSVM_matrix.txt", SVMnumber);
	float	score		= BIAS;

	uint32	i;
	for (i = 0; i < SVMnumber; i++) {
		score += HOG_Feature[i] * trainSVM[i];
	}
	if (score > 0.0) {
		save_detects[*nDetects].nWindows = pointer;
		save_detects[*nDetects].resizeSize = 1;
		save_detects[*nDetects].score = score;
		(*nDetects)++;
	}

	free(trainSVM);

	return;
}


