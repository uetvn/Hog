/*
 * Project name   :
 * File name      : !!FILE
 * Created date   : !!DATE
 * Author         : Huy Hung Ho
 * Last modified  : !!DATE
 * Desc           :
 */

#include <stdio.h>
#include <math.h>

int main ()
{
	float	alpha	= 0.298912;
	float	beta	= 0.586611;
	float	gamma	= 0.114478;
	int	x1	= 200;
	int	x2	= 100;
	int	x3	= 17;


	int	result1, result2, result3;
	result1	= (int) (x1*alpha + x2*beta + x3*gamma);
	printf("SW result: %d \n", result1);


	alpha	= 19595;//alpha * pow(2, 8);	// 77:	1001101
	beta	= 7471;//beta * pow(2, 8);	// 150:	10010110
	gamma	= 38470;//gamma * pow(2, 8);	// 29:	00011101
	x1	= (int)(x1*alpha / pow(2, 16));
	x2	= (int)(x2*beta / pow(2, 16));
	x3	= (int)(x3*gamma / pow(2, 16));
	result2 = x1 + x2 + x3;
	printf("HW result: %d \n", result2);
	printf("X1 - X2 - X3 = %d %d %d \n",  (int)(x1), (int)(x1), (int)(x1));



	x1	= x1 * (pow(2, 6) + pow(2, 3) + pow(2, 2)  + pow(2, 0));
	x2	= x2 * (pow(2, 7) + pow(2, 4) + pow(2, 2)  + pow(2, 1));
	x3	= x3 * (pow(2, 4) + pow(2, 3) + pow(2, 2)  + pow(2, 0));
	x1	/= pow(2, 8);
	x2	/= pow(2, 8);
	x3	/= pow(2, 8);
	result3	= (int)x1 + (int)x2 + (int)x3;
	printf("HW optimized result: %d \n", result3);
	printf("X1 - X2 - X3 = %d %d %d \n", (int)x1, (int)x2, (int)x3);
	return 0;
}
