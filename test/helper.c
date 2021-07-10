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

float euler_rms_error(float e1[3], float e2[3])
{
    float a = e1[0] - e2[0];
    float b = e1[1] - e2[1];
    float c = e1[2] - e2[2];

    return sqrtf(a*a + b*b + c*c);
}
