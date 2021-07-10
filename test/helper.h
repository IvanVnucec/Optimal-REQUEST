#ifndef HELPER_H
#define HELPER_H

void get_euler_from_q(float euler[3], float q[4]);
float euler_rms_error(float e1[3], float e2[3]);

#endif // HELPER_H