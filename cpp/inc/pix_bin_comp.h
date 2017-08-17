/*
 * Project name   :
 * File name      : pix_bin_comp.h
 * Created date   : Thu 20 Jul 2017 12:24:32 PM +07
 * Author         : Ngoc-Sinh Nguyen
 * Last modified  : Thu 20 Jul 2017 12:24:32 PM +07
 * Desc           :
 */

#ifndef PIX_BIN_COM
#define PIX_BIN_COM

#include "config.h"

#define DEGREE_0 0
#define DEGREE_10 10
#define DEGREE_30 30
#define DEGREE_50 50
#define DEGREE_70 70
#define DEGREE_90 90
#define DEGREE_110 110
#define DEGREE_130 130
#define DEGREE_150 150
#define DEGREE_170 170
/* --------------------------------------------------------------------------*/
/**
 * \brief  Calculate angle and magnitute (HOG) of pixel P(x)(y)
 *
 * \param x_plus_1      P(x + 1)(y)
 * \param x_minus_1     P(x - 1)(y)
 * \param y_plus_1      P(x)(y + 1)
 * \param y_minus_1     P(x)(y-1)
 * \param angle_1       Standard angle: 10,30,...
 * \param angle_2       Standard angle
 * \param mag_1         Magnitute of angle 1
 * \param mag_2         Magnitute of angle_2
 *
 * \returns
 */
/* --------------------------------------------------------------------------*/
int pix_bin_comp(uint8 x_plus_1, uint8 x_minus_1,
        uint8 y_plus_1, uint8 y_minus_1,
        uint8 *angle_1, uint8 *angle_2,
        float *mag_1, float *mag_2);

int  solve_system_of_2_equation(float a1, float b1, float c1,
        float a2, float b2, float c2, float *root1, float *root2);

#endif /* ifndef PIX_BIN_COM */
