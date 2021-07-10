#include <math.h>

#include "helper.h"

void get_euler_from_q(float euler[3], float q[4]) 
{
    float q1 = q[0];
    float q2 = q[1];
    float q3 = q[2];
    float q4 = q[3];
    float psi, theta, phi;

    psi =  atan2f(2.0f * (q2*q3 + q1*q4), q1*q1 + q2*q2 - q3*q3 - q4*q4);
    theta = asinf(2.0f * (q1*q3 - q2*q4));
    phi =  atan2f(2.0f * (q3*q4 + q1*q2), q1*q1 - q2*q2 - q3*q3 + q4*q4);

    euler[0] = psi;
    euler[1] = theta; 
    euler[2] = phi;
}

float angle_diff(float a, float b)
{
    float d = a - b;
    float divident = d + (float)M_PI;
    float divisor = 2.0f*(float)M_PI;
    float mod = divident - divisor * floorf(divident/divisor);

    // wrap the result into the interval [-pi pi)
    return mod - (float)M_PI;
}

float euler_rms_error(float e1[3], float e2[3])
{
    float a = angle_diff(e1[0], e2[0]);
    float b = angle_diff(e1[1], e2[1]);
    float c = angle_diff(e1[2], e2[2]);

    return sqrtf(a*a + b*b + c*c);
}

void mean_std(float *mean, float *std, float *data, int len)
{
    float sum1 = 0.0f, sum2 = 0.0f;

    for (int i=0; i<len; i++)
        sum1 += data[i];

    *mean = sum1 / len;

    for (int i=0; i<len; i++)
        sum2 += (data[i] - *mean) * (data[i] - *mean);

    *std = sqrtf(sum2 / (len - 1));
}
