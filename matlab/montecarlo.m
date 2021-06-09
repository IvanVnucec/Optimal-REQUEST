
% for debug
clear all;
close all;
rng('default'); % comment this line if running on GNU Octave
colordef black

Mu_noise_var_fact = 1;
main
e = angle_diff(angle_gt, angle_est);
s_e = e * e';
ms_e = s_e/3;
rms_e = sqrt(ms_e);
fprintf('factor = %f -> rms_error = %f\n', Mu_noise_var_fact, rms_e);

Mu_noise_var_fact = 0.1;
main
e = angle_diff(angle_gt, angle_est);
s_e = e * e';
ms_e = s_e/3;
rms_e = sqrt(ms_e);
fprintf('factor = %f -> rms_error = %f\n', Mu_noise_var_fact, rms_e);

Mu_noise_var_fact = 0.01;
main
e = angle_diff(angle_gt, angle_est);
s_e = e * e';
ms_e = s_e/3;
rms_e = sqrt(ms_e);
fprintf('factor = %f -> rms_error = %f\n', Mu_noise_var_fact, rms_e);
















