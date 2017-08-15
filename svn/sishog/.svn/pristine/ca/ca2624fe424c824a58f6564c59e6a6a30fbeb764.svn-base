/*
 * Project name   : Human detection by HOG
 * File name      : svm_window.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Wed 19 Apr 2017
 * Desc           :
 */

#include "svm_window.h"

unsigned svm_window(uint32 *is_detected, struct HOG_window *hog_column)
{
    float   *svm_trained = malloc(sizeof(float) * HOG_number);
    readFileFloats(svm_trained, "svm_trained.txt", HOG_number);

    float   *hog, *svm;
    float   *score  = malloc(sizeof(float));
    *score  = BIAS;
    *is_detected = 0;

    uint8   i, j;
    for (i = 0; i < columns; i++)
    for (j = 0; j < rows; j++) {
        hog = hog_column[i].hog_row[j].hog_block_16x16;
        svm = svm_trained + (i * rows + j) * 36;
        svm_block_16x16(score, hog, svm);
    }

    if (*score > 0.0)
        *is_detected = 1;
    return 0;
}

unsigned svm_block_16x16(float *result, float *hog, float *svm)
{
    uint8   i;
    for (i = 0; i < 36; i++)
        *result += hog[i] * svm[i];
    return 0;
}
