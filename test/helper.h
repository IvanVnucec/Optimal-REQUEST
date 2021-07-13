#ifndef HELPER_H
#define HELPER_H

#define M_PI (3.14159265358979323846f)
#define RAD2DEG(x) ((x)/M_PI*180.0f)
#define DEG2RAD(x) ((x)/180.f*M_PI)

void rad2deg(float *out, float *in, int len);
void deg2rad(float *out, float *in, int len);
void get_euler_from_q(float euler[3], float q[4]);
float angle_diff(float a, float b);
float euler_rms_error(float e1[3], float e2[3]);
void mean_std(float *mean, float *std, float *data, int len);

#endif // HELPER_H