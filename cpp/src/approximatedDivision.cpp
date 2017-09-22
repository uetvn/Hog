/*
 * Project name   :
 * File name      : approximatedDivision.cpp
 * Created date   : Fri 15 Sep 2017 11:24:19 AM ICT
 * Author         : Huy-Hung Ho
 * Last modified  : Fri 15 Sep 2017 11:28:40 AM ICT
 * Desc           :
 */
#include "approximatedDivision.h"
#include <cmath>
#include <fstream>

uint32 check_nearest_smaller_power_of_2(uint32 n)
{
	n |= (n >>  1);
    n |= (n >>  2);
    n |= (n >>  4);
    n |= (n >>  8);
    n |= (n >> 16);
    return n - (n >> 1);
}


//--NOTE Num using 13 bit */
uint32 approximatedDivision(uint32 num, uint32 den)
{
    uint32 result;
    uint32 nearest_smaller_power_of_2;
    uint32 nearest_smaller_add_one_quarter;
    uint32 nearest_smaller_add_two_quarters;
    uint32 nearest_smaller_add_three_quarters;
    uint32 leftMostBit;
    uint32 num_shift_16_bit = num << 16;

    nearest_smaller_power_of_2 = check_nearest_smaller_power_of_2(den);
    leftMostBit = (uint32)log2((double) nearest_smaller_power_of_2);

    nearest_smaller_add_one_quarter = nearest_smaller_power_of_2
                                    + (nearest_smaller_power_of_2 >> 2);
    nearest_smaller_add_two_quarters = nearest_smaller_power_of_2
                                     + (nearest_smaller_power_of_2 >> 1);
    nearest_smaller_add_three_quarters = nearest_smaller_power_of_2
                                       + ((3 * nearest_smaller_power_of_2) >> 2);

    /* Have event shift 33 bit */
    if (den > nearest_smaller_add_three_quarters) {
        //printf("TH4\n");
        result = num_shift_16_bit >> (leftMostBit + 1);
    }
    else if (den > nearest_smaller_add_two_quarters)
    {
        //printf("TH3\n");
        result = (num_shift_16_bit >> (leftMostBit + 1))
               + (num_shift_16_bit >> (leftMostBit + 3));
    }
    else if (den > nearest_smaller_add_one_quarter) {
        //printf("TH2\n");
        result = (num_shift_16_bit >> (leftMostBit + 1))
               + (num_shift_16_bit >> (leftMostBit + 2));
    }
    else if (den >= nearest_smaller_power_of_2) {
        //printf("TH1\n");
        result = (num_shift_16_bit >> (leftMostBit + 1))
               + (num_shift_16_bit >> (leftMostBit + 2))
               + (num_shift_16_bit >> (leftMostBit + 3));
    }
    else {
        //printf("TH0\n");
        result = num_shift_16_bit;
    }
    /*
    printf("nearest_smaller_power_of_2        = %d \n", nearest_smaller_power_of_2);
    printf("nearest_smaller_add_one_quarter   = %d \n", nearest_smaller_add_one_quarter);
    printf("nearest_smaller_add_two_quarters  = %d \n", nearest_smaller_add_two_quarters);
    printf("nearest_smaller_add_three_quarters= %d \n", nearest_smaller_add_three_quarters);

    printf("\n num = %d \t den = %d leftMostBit = %d\n", num, den, leftMostBit);
    printf("result = %d \n\n", result);
*/
	return result;
}
