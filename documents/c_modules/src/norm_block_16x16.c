/*
 * Project name   : Human detection by HOG
 * File name      : norm_block_16x16.c
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Thu 13 Apr 2017
 * Desc           :
 */

#include <norm_block_16x16.h>
#include <math.h>

unsigned norm_block_16x16(float *result, float *block1, float *block2, float *block3, float *block4)
{
    float   sum = 0;
    uint8   i;
    for (i = 0; i < 36; i++) {
        if (i < 9)
            sum += block1[i] * block1[i];
        else if (i < 18)
            sum += block2[i - 9] * block2[i - 9];
        else if (i < 27)
            sum += block3[i - 18] * block3[i - 18];
        else
            sum += block4[i - 27] * block4[i - 27];
    }

    for (i = 0; i < 36; i++) {
        if (i < 9)
            result[i] = block1[i] / (sqrt(sum) + 0.001);
        else if (i < 18)
            result[i] = block2[i - 9] / (sqrt(sum) + 0.001);
        else if (i < 27)
            result[i] = block3[i - 18] / (sqrt(sum) + 0.001);
        else
            result[i] = block4[i - 27] / (sqrt(sum) + 0.001);
    }
    return 0;
}
