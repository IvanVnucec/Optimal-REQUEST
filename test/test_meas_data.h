// Generated by {project_root}/matlab/tests/gen_meas_for_c.m script.
// Author: Ivan Vnucec, 2021
// License: MIT

#ifndef TEST_MEAS_DATA_H
#define TEST_MEAS_DATA_H

#define TEST_MEAS_DATA_MEAS_LEN (201)
#define TEST_MEAS_DATA_MU_NOISE_VAR (0.0008117f)
#define TEST_MEAS_DATA_ETA_NOISE_VAR (0.0000010f)
#define TEST_MEAS_DATA_DT (10.0000000f)	// seconds

extern float test_meas_data_ref_acc[TEST_MEAS_DATA_MEAS_LEN][3];	// m/s^2
extern float test_meas_data_ref_mag[TEST_MEAS_DATA_MEAS_LEN][3];	// uT
extern float test_meas_data_bdy_acc[TEST_MEAS_DATA_MEAS_LEN][3];	// m/s^2
extern float test_meas_data_bdy_mag[TEST_MEAS_DATA_MEAS_LEN][3];	// uT
extern float test_meas_data_bdy_gyr[TEST_MEAS_DATA_MEAS_LEN][3];	// rad/s
extern float test_meas_data_euler_gt[TEST_MEAS_DATA_MEAS_LEN][3];	// rad

#endif // TEST_MEAS_DATA_H
