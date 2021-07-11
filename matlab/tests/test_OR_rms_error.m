function [test_passed] = test_OR_rms_error()
% =========================== Info ==============================
% About: Generate measurement and run the Optimal-REQUEST algorithm. Return
% false if RMS error of the Euler angles is greather than 
% std_rms_err_threshold variable value.
% If test fails it will save figure plots of Euler angles error in the 
% figures directory.
%
% Author:     Ivan Vnucec
% University: FER, Zagreb
% Date:       Jul, 2021
% License:    MIT

% =========================== START =============================
% for debug
clear all;

addpath('./../', './../utils');

% ====================== TEST PARAMETERS ========================
std_rms_err_threshold = 1.5;    % Degrees, RMS error threshold for test pass or fail
simulation_time  = 2000;        % Simulation time in seconds
dT = 10;                        % Sensor sampling period in seconds

% generate and load measurements
measurements = gen_meas(simulation_time, dT);
meas = load(measurements);

% ======================== algorithm output =====================
K_est = zeros(4, 4, meas.num_of_iter);
q_est = zeros(4, meas.num_of_iter);
euler_est = zeros(3, meas.num_of_iter);
angle_est = zeros(1, meas.num_of_iter);
Rho_est = zeros(1, meas.num_of_iter);
P_est = zeros(4, 4, meas.num_of_iter);

% ==================== initialization k=0 =======================
k = 1; % k=1 because of MATLAB counting from 1 and not from 0

% prepare first measurement
r0 = [meas.mag_ref_meas(:,k), meas.acc_ref_meas(:,k)];
b0 = [meas.mag_bdy_meas(:,k), meas.acc_bdy_meas(:,k)];

% Init structure handle for Optimal-REQUEST functions
s = struct('w', zeros(3, 1), ...
    'r', r0, ...
    'b', b0, ...
    'Mu_noise_var', meas.Mu_noise_var, ...
    'Eta_noise_var', meas.Eta_noise_var, ...
    'dT', meas.dT, ...
    'K', zeros(4), ...
    'P', zeros(4), ...
    'mk', 0.0, ...
    'Rho', 0.0);

s = optimal_request_init(s);

% ======================== algorithm ============================
for k = 2 : meas.num_of_iter
    % get angular velocity measurement
    s.w = meas.gyr_bdy_meas(:,k);
    
    % referent vector measurements
    s.r = [meas.mag_ref_meas(:,k), meas.acc_ref_meas(:,k)];
    % body vector measurements
    s.b = [meas.mag_bdy_meas(:,k), meas.acc_bdy_meas(:,k)];
    
    s = optimal_request(s);
    
    % store calculated K and q for debug
    K_est(:,:,k) = s.K;
    q = get_quat_from_K(s.K);
    q_est(:,k) = q;
    angle_est(:,k) = 2.0 * acos(abs(q(1)));
    euler_est(:,k) = qib2Euler(q);
    Rho_est(k) = s.Rho;
    P_est(:,:,k) = s.P;
end

% calculate RMS error in degrees
angle_difference = rad2deg(angle_diff(euler_est, meas.euler_gt)); % deg
rms_err = sqrt(sum(angle_difference.^2)); % deg
std_rms_err = sqrt(var(rms_err)); % deg
mean_rms_err = mean(rms_err); %deg

% print errors to the output stream
fprintf("Std RMS error = %f [deg]\n", std_rms_err);
fprintf("std_rms_err_threshold = %f [deg]\n\n", std_rms_err_threshold);

% plot angle errors
figure(1);
plot(meas.t, angle_difference); 
title('Real vs Estimated Euler angles differences vs Time');
xlabel('time [s]'); 
ylabel('angle [deg]');
saveas(gcf, 'figures/euler_angles_error.jpg');
close;

figure(2);
plot(meas.t, rms_err); 
title('Real vs Estimated Euler angles RMS error vs Time');
xlabel('time [s]'); 
ylabel('angle [deg]');
saveas(gcf, 'figures/euler_angles_rms_error.jpg');
close;

% save test results to file so we can compare it with implementation in C
mkdir ../../logs
fileID = fopen('../../logs/test_OR_rms_error_results.log', 'w');
fprintf(fileID, '%.7f\n', mean_rms_err);
fprintf(fileID, '%.7f', std_rms_err);
fclose(fileID);

if std_rms_err < std_rms_err_threshold
    test_passed = true;
else
    test_passed = false;
end

end

