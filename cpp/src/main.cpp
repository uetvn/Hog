/*
 * Project name   :
 * File name      : main.cpp
 * Created date   : Wed 16 Aug 2017 09:27:01 AM ICT
 * Author         : Huy-Hung Ho
 * Last modified  : Wed 16 Aug 2017 09:27:01 AM ICT
 * Desc           :
 */

#include <iostream>
#include <string.h>
#include <fstream>
#include <cmath>
#include "config.h"
#include "HOGProcessor.h"
#include "approximatedDivision.h"
#include "window_hog_comp.h"
using namespace std;


int main(int argc, char *argv[])
{
    /* Test case for block
    const uint32 SIZE_BLOCK = 36 + 4;
    FILE *testCase = fopen("divisionTest.txt", "w");
    uint32 *block = malloc(sizeof(uint32) * SIZE_BLOCK);

    uint32 i;
    fclose(testCase);
    */
    //approximatedDivision(1, 3);
    /* Print test case by C - max error rateis 1.00% now (denTest < 2^20) */
    FILE *testCase = fopen("divisionTest.txt", "w");
    int32 numTest;
    int32 denTest;
    int32 real;
    int32 appx;
    float errorRate;
    float maxErrorRate = 0;
    for (numTest = 0; numTest < pow(2, 13); numTest++) {
        for (denTest = 1; denTest < pow(2, 15); denTest++) {
            real = (numTest << 16) / (denTest + 1);
            appx = approximatedDivision(numTest, denTest);
            errorRate = abs(real - appx) / (real + 0.001);
            if (errorRate > maxErrorRate)
                maxErrorRate = errorRate;
            fprintf(testCase, "%10d %10d %10d %10d %4.4f \n",
                    numTest, denTest, appx, real, errorRate);
        }
    }
    fclose(testCase);
    printf("Max error rate is %.2f %% \n",  maxErrorRate);
    //*/


    /* Test of shift
    int n;
    cin >> n;
    cout << (n |= n >> 6) << endl;
    */

    /* Test of HOGProcessor
	int m_wcell		= 8;
	int m_hcell		= 8;
	int m_wblock	= 2;
	int m_hblock	= 2;
	int m_wwindow	= 64;
	int m_hwindow	= 128;
	int m_overlap	= 1; // 0.5


    const char* imgname = "people.png";
    char fileFeaturesName[400];
    strcpy(fileFeaturesName, imgname);
    strcat(fileFeaturesName,"_features.txt");
    ofstream fileFeatures(fileFeaturesName);
    HOGProcessor hog;
    hog.setParams(cvSize(m_wcell,m_hcell),cvSize(m_wblock,m_hblock),m_overlap);
    CvMat* features;
    features = hog.calcHOGFromImage(imgname,cvSize(m_wwindow,m_hwindow),1);
    hog.writeFeatureVector(features, fileFeatures);
    */

    /* Test of approximateDivision
    int a, b;
    cin >> a;
    cin >> b;

    cout << "(" << a << " / " << b << ") = " << a / (double)b << endl;
    cout << approximatedDivision(a, b) / 1024.0 << endl;
    */

	return 0;
}

