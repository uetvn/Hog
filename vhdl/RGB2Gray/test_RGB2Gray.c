/*
 * Project name   : LSI Contest 2017
 * File name      : RGB2Gray.c
 * Created date   : Mon 27 Feb 2017
 * Author         : Huy Hung Ho
 * Last modified  : Mon 27 Feb 2017
 * Desc           :
 */
#include <stdio.h>
#include <stdlib.h>

static const int YR = 19595, YB = 7471, YG = 38470;

/*
 * Convert from RGB to Gray pixel image
 * - r    is red ingredient
 * - g    is green ingredient
 * - b    is blue ingredient
 */
int RGB2Gray(int r, int g, int b)
{
        unsigned int tmp = ((r * YR  + g * YG + b * YB + 32768) >> 16);
        return tmp > 255 ? 255 : (tmp & 0xFF);
}

int main (int argc, char ** argv)
{
	int	red	= atoi(argv[1]);
	int	green	= atoi(argv[2]);
	int	blue	= atoi(argv[3]);
	printf("%d \n", RGB2Gray(red, green, blue));
	return 0;
}
