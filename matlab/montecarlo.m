
% for debug
clear all;
colordef black

generate_measurements
Mu_noise_var_const = Mu_noise_var;

hold on

Mu_noise_var_fact = 1;
Mu_noise_var = Mu_noise_var_const * Mu_noise_var_fact;
main
e = angle_diff(euler_est, euler_gt).^2;
% calculate rms of errors in every iteration of optimal req
rms_err_by_iter = sqrt(mean(e.^2));
disp_name = sprintf('Fact = %f', Mu_noise_var_fact);
plot(rms_err_by_iter', 'DisplayName', disp_name)

Mu_noise_var_fact = 0.1;
Mu_noise_var = Mu_noise_var_const * Mu_noise_var_fact;
main
e = angle_diff(euler_est, euler_gt).^2;
% calculate rms of errors in every iteration of optimal req
rms_err_by_iter = sqrt(mean(e.^2));
disp_name = sprintf('Fact = %f', Mu_noise_var_fact);
plot(rms_err_by_iter', 'DisplayName', disp_name)

Mu_noise_var_fact = 0.01;
Mu_noise_var = Mu_noise_var_const * Mu_noise_var_fact;
main
e = angle_diff(euler_est, euler_gt).^2;
% calculate rms of errors in every iteration of optimal req
rms_err_by_iter = sqrt(mean(e.^2));
disp_name = sprintf('Fact = %f', Mu_noise_var_fact);
plot(rms_err_by_iter', 'DisplayName', disp_name)

hold off

legend;
xlabel('k');
ylabel('RMS error of all 3 angles');







