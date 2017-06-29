/*
 * Project name   : Human detection by HOG
 * File name      : svm_classification.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#include "svm_classification.h"

uint8 svm_classification(struct HOG_window *hog_column)
{
    float   *svm_trained = malloc(sizeof(float) * HOG_number);
    readFileFloats(svm_trained, "svm_trained.txt", HOG_number);

    float   *hog, *svm;
    float   *score  = malloc(sizeof(float));
    *score  = BIAS;

    uint8   i, j;
    for (i = 0; i < columns; i++)
    for (j = 0; j < rows; j++) {
        hog = hog_column[i].hog_row[j].hog_block_16x16;
        svm = svm_trained + (i * rows + j) * 36;
        svm_block_16x16(score, hog, svm);
    }

    uint8 result = 0;
    if (*score > 0.0)
        result = 1;
    return result;
}
