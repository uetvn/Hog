/*
 * Project name   :
 * File name      : window_hog_comp.cpp
 * Created date   : Thu 21 Sep 2017 10:01:44 AM ICT
 * Author         : Huy-Hung Ho
 * Last modified  : Thu 21 Sep 2017 10:01:44 AM ICT
 * Desc           :
 */
#include <cstdlib>
#include "approximatedDivision.h"
#include "window_hog_comp.h"

uint32 *window_hog_comp (uint32 *dataIn, uint32 length)
{
    uint32 *result  = (uint32*)calloc(sizeof(uint32), length);
    uint32 cumulative_cb;
    uint32 counter  = 0;
    while (counter < length) {

        /* Sum of 4 cb */
        cumulative_cb = 0;
        uint32 i;
        for (i = 0; i < 4; i++) {
            cumulative_cb += dataIn[counter];
            counter++;
        }

        for (i = 0; i < 32; i++) {
            result[counter] = approximatedDivision(dataIn[counter], cumulative_cb);
            counter++;
        }
    }
    return result;
}
