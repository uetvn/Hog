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
#include "appx_div.h"
#include "block_norm_comp.h"
#include "window_norm_comp.h"
using namespace std;


int main(int argc, char *argv[])
{
    window_norm_comp();
    //block_norm_comp();

    /* Print test case by C - max error rateis 20% now (denTest < 2^20)
    FILE *testCase = fopen("text/inf.txt", "w");
    int32 numTest;
    int32 denTest;
    int32 real;
    int32 appx;
    float errorRate;
    float maxErrorRate = 0;
    fprintf(testCase, "       num        den       appx       real     error \n");
    for (numTest = 0; numTest <= pow(2, 7); numTest++){// numTest < pow(2, 13); numTest++) {
        for (denTest = 1; denTest <= pow(2, 13); denTest++){//pow(2, 30); denTest >= (pow(2, 30) - 100); denTest--) {
            appx = appx_div(numTest, denTest);
            real = roundf((numTest << HIST_WIDTH) / (denTest + 0.01));

            errorRate = abs(real - appx) / (real + 0.01) * 100;
            if (errorRate > maxErrorRate)
                maxErrorRate = errorRate;

            fprintf(testCase, "%10d %10d %10d %10d %8.2f%% \n",
                    numTest, denTest, appx, real, errorRate);
            //fprintf(testCase, "%10d %10d %10d \n",
            //        numTest, denTest, appx);
        }
    }
    fclose(testCase);
    printf("Max error rate is %.2f %% \n",  maxErrorRate);
    */


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
    cout << appx_div(a, b) / 1024.0 << endl;
    */

	return 0;
}

