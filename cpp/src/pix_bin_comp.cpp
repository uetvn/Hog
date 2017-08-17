/*
 * Project name   : Human detection by HOG
 * File name      : pix_bin_comp.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Thu 10 Aug 2017 02:46:03 PM ICT
 * Desc           :
 */

#include <math.h>
#include "pix_bin_comp.h"

#define msin(x) fabs(sin(x * (PI / 180.0)))
#define mcos(x) fabs(cos(x * (PI / 180.0)))

int pix_bin_comp(uint8 x_plus_1, uint8 x_minus_1, uint8 y_plus_1, uint8 y_minus_1,
        uint8 *angle_1, uint8 *angle_2,
        float *mag_1, float *mag_2
        )
{
    int8 dx = x_plus_1 - x_minus_1;
    int8 dy = y_plus_1 - y_minus_1;
    if (dx < 0) dx = 0;
    if (dy < 0) dy = 0;

    /* Angle calculation */
    if (dy){
        if (dx){
            if (dy * 91 > dx * 250 ){
                *angle_1 = DEGREE_70;
                *angle_2 = DEGREE_90;
            }
            else if ( dy * 193 > dx * 230){
                *angle_1 = DEGREE_50;
                *angle_2 = DEGREE_70;
            }
            else if ( dy * 97 > dx * 56){ // 194 / 112
                *angle_1 = DEGREE_30;
                *angle_2 = DEGREE_50;
            }
            else if ( dy * 244 > dx * 43){
                *angle_1 = DEGREE_10;
                *angle_2 = DEGREE_30;
            }
            else{
                *angle_1 = DEGREE_170;
                *angle_2 = DEGREE_10;
            }
        }
        else { // dy#0, dx==0
            *angle_1 = DEGREE_90;
            *angle_2 = DEGREE_90;
            *mag_1 = dy;
            *mag_2 = 0;
        }
    }
    else{
        *angle_1 = DEGREE_170;
        *angle_2 = DEGREE_10;
    }

    /* Magitute calculation*/
    if (*angle_1 != DEGREE_90) {
        if (*angle_1 != DEGREE_170) {
            solve_system_of_2_equation(
                            mcos(*angle_1), mcos(*angle_2), dx,
                            msin(*angle_1), msin(*angle_2), dy,
                            mag_1, mag_2
                            );
        }else{
            solve_system_of_2_equation(
                            mcos(*angle_1), mcos(*angle_2), dx,
                            (0 - msin(*angle_1)), msin(*angle_2), dy,
                            mag_1, mag_2
                            );
        }
    }
    return 0;
   if ( (x_plus_1 > x_minus_1) ^ (y_plus_1 > y_minus_1)) {
       *angle_1 = 180 - *angle_1;
       *angle_2 = 180 - *angle_2;
   }
   //print_info(x_plus_1, x_minus_1, y_plus_1, y_minus_1, *angle_1,  *angle_2, *mag_1,  *mag_2);
}


int  solve_system_of_2_equation(float a1, float b1, float c1,
        float a2, float b2, float c2, float *root1, float *root2)
{
    float D  = a1 * b2 - a2 * b1;
    float Dx, Dy;

    if (c1 * b2 > c2 * b1) {
        Dx = c1 * b2 - c2 * b1;
    } else Dx = 0;

    if (a1 * c2 > a2 * c1) {
        Dy = a1 * c2 - a2 * c1;
    } else Dy = 0;

    if (D) {
        *root1  = Dx / D;
        *root2  = Dy / D;
    }

    else {
        printf("Error: \n");
        return 1;
    }

    return 0;
}


