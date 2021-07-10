% for debug
clear all;

simulation_time  = 2000;        % Simulation time in seconds
dT = 10;                        % Sensor sampling period in seconds

% generate and load measurements
measurements = gen_meas(simulation_time, dT);
meas = load(measurements);

%meas.acc_bdy_meas
%meas.mag_bdy_meas
%meas.gyr_bdy_meas

c_filepath = '../../test/test_meas_data.c';
h_filepath = '../../test/test_meas_data.h';
MEAS_LEN = length(meas.acc_bdy_meas);

%% Write .h file
fileID = fopen(h_filepath, 'w');
fprintf(fileID, '#define MEAS_LEN (%d)\n\n', MEAS_LEN);
fprintf(fileID, 'extern float test_meas_data_acc[MEAS_LEN][3];\n');
fprintf(fileID, 'extern float test_meas_data_mag[MEAS_LEN][3];\n');
fprintf(fileID, 'extern float test_meas_data_gyr[MEAS_LEN][3];\n');
fprintf(fileID, 'extern float test_meas_data_euler_gt[MEAS_LEN][3];\n');
fclose(fileID);

%% Write .c file
fileID = fopen(c_filepath, 'w');
fprintf(fileID, '#include "test_meas_data.h"\n\n');

%% Accelerometer data
fprintf(fileID, 'float test_meas_data_acc[MEAS_LEN][3] = {\n');
fprintf(fileID, '    {%.7ff, %.7ff, %.7ff},\n', meas.acc_bdy_meas);
fprintf(fileID, '};\n\n');

%% Magnetometer data
fprintf(fileID, 'float test_meas_data_mag[MEAS_LEN][3] = {\n');
fprintf(fileID, '    {%.7ff, %.7ff, %.7ff},\n', meas.mag_bdy_meas);
fprintf(fileID, '};\n\n');

%% Gyro data
fprintf(fileID, 'float test_meas_data_gyr[MEAS_LEN][3] = {\n');
fprintf(fileID, '    {%.7ff, %.7ff, %.7ff},\n', meas.gyr_bdy_meas);
fprintf(fileID, '};\n\n');

%% Euler ground truth
fprintf(fileID, 'float test_meas_data_euler_gt[MEAS_LEN][3] = {\n');
fprintf(fileID, '    {%.7ff, %.7ff, %.7ff},\n', meas.euler_gt);
fprintf(fileID, '};\n\n');

fclose(fileID);








