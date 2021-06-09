
% for debug
clear all;
close all;
rng('default'); % comment this line if running on GNU Octave
colordef black

Mu_noise_var_fact = 1;
main
e = angle_diff(euler_est, euler_gt).^2;
ms_e = sum(e, 2)/length(e);
rms_e = sqrt(ms_e);
fprintf('factor = %f -> rms_error = [%f %f %f] rad\n', Mu_noise_var_fact, rms_e);

Mu_noise_var_fact = 0.1;
main
e = angle_diff(euler_est, euler_gt).^2;
ms_e = sum(e, 2)/length(e);
rms_e = sqrt(ms_e);
fprintf('factor = %f -> rms_error = [%f %f %f] rad\n', Mu_noise_var_fact, rms_e);

Mu_noise_var_fact = 0.01;
main
e = angle_diff(euler_est, euler_gt).^2;
ms_e = sum(e, 2)/length(e);
rms_e = sqrt(ms_e);
fprintf('factor = %f -> rms_error = [%f %f %f] rad\n', Mu_noise_var_fact, rms_e);
















