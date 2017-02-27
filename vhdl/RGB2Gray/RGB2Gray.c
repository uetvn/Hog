/*
 * Project name   : LSI Contest 2017
 * File name      : RGB2Gray.c
 * Created date   : Mon 27 Feb 2017
 * Author         : Huy Hung Ho
 * Last modified  : Mon 27 Feb 2017
 * Desc           :
 */
#include <stdio.h>

static const int YR = 19595, YB = 7471, YG = 38470;

/*
 * Convert from RGB to Gray pixel image
 * - r    is red ingredient
 * - g    is green ingredient
 * - b    is blue ingredient
 */
char RGB2Gray(char r, char g, char b)
{
        unsigned int tmp = ((r * YR  + g * YG + b * YB + 32768) >> 16);
        return tmp > 255 ? 255 : (tmp & 0xFF);
}

int main ()
{
	printf("%d \n", RGB2Gray(200, 100, 17));
	return 0;
}
