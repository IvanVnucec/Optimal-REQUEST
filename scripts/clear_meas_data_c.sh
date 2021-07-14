#!/bin/bash

TEST_MEAS_DATA_C_FILE=../test/test_meas_data.c

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

read -r -d '' VAR << EOM
// Generated by {project_root}/matlab/tests/gen_meas_for_c.m script.
// Data in this script is generated in the script above.
// Author: Ivan Vnucec, 2021
// License: MIT

#include "test_meas_data.h"

float test_meas_data_ref_acc[TEST_MEAS_DATA_MEAS_LEN][3];   // m/s^2
float test_meas_data_ref_mag[TEST_MEAS_DATA_MEAS_LEN][3];   // uT
float test_meas_data_bdy_acc[TEST_MEAS_DATA_MEAS_LEN][3];   // m/s^2
float test_meas_data_bdy_mag[TEST_MEAS_DATA_MEAS_LEN][3];   // uT
float test_meas_data_bdy_gyr[TEST_MEAS_DATA_MEAS_LEN][3];   // rad/s
float test_meas_data_euler_gt[TEST_MEAS_DATA_MEAS_LEN][3];  // rad

EOM

echo "$VAR" > "$TEST_MEAS_DATA_C_FILE"
