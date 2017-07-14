/*
 * Project name   :
 * File name      : calc.c
 * Created date   : Tuesday 07/02/17
 * Author         : Huy Hung Ho
 * Last modified  : Monday 07/10/17
 * Desc           :
 */

#include <stdio.h>
#include <math.h>

double sind(double angle)
{
        double angleradians = angle * M_PI / 180.0f;
            return sin(angleradians);
}

double cosd(double angle)
{
        double angleradians = angle * M_PI / 180.0f;
            return cos(angleradians);
}

int main ()
{
    double p1, p2;
    scanf("%lf %lf", &p1, &p2);
    double x = cosd(p1)*sind(p2) - cosd(p2)*sind(p1);
    printf("x = %lf\n", x);
    printf("m1 = %.0lf * dx - %.0lf * dy;\n", 1024*sind(p2) / x, 1024*cosd(p2) / x);
    printf("m2 = %.0lf * dy - %.0lf * dx;\n", 1024*cosd(p1) / x, 1024*sind(p1) / x);
	return 0;
}

