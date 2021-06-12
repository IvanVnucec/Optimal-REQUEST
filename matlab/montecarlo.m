% =========================== Info ==============================
% About: File used to test Optimal-REQUEST algorithm
% 
% Author: Ivan Vnucec, FER, Zagreb, 2021
% License: MIT

% for debug
clear all;
colordef black

generate_measurements

% save measurement noise variance for later use
Mu_noise_var_const = Mu_noise_var;

hold on

% test with the same measurement variance
Mu_noise_var_fact = 1;
Mu_noise_var = Mu_noise_var_const * Mu_noise_var_fact;
main
rms_err = euler_rms_error(euler_est, euler_gt);
disp_name = sprintf('Fact = %f', Mu_noise_var_fact);
plot(rms_err', 'DisplayName', disp_name)

% test with the 10 times smaller measurement variance
Mu_noise_var_fact = 0.1;
Mu_noise_var = Mu_noise_var_const * Mu_noise_var_fact;
main
rms_err = euler_rms_error(euler_est, euler_gt);
disp_name = sprintf('Fact = %f', Mu_noise_var_fact);
plot(rms_err', 'DisplayName', disp_name)

% test with the 100 times smaller measurement variance
Mu_noise_var_fact = 0.01;
Mu_noise_var = Mu_noise_var_const * Mu_noise_var_fact;
main
rms_err = euler_rms_error(euler_est, euler_gt);
disp_name = sprintf('Fact = %f', Mu_noise_var_fact);
plot(rms_err', 'DisplayName', disp_name)

hold off

legend;
xlabel('k');
ylabel('RMS error of all 3 angles');

% Calculate Euler angles RMS error between 3 Euler angles
function rms_err = euler_rms_error(euler_est, euler_gt)
    e = angle_diff(euler_est, euler_gt).^2;
    rms_err = sqrt(mean(e.^2));
end
