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

% add src, utils and gen_meas folders to path
addpath('./../scripts', './../scripts/utils');

std_rms_err_threshold = 1.5;    % Degrees, RMS error threshold for test pass or fail
simulation_time  = 2000;        % Simulation time in seconds
dT = 10;                        % Sensor sampling period in seconds
measurements = gen_meas(simulation_time, dT);
load(measurements); % TODO: Specify what variables we want to load

% ======================== algorithm output =====================
K_est = zeros(4, 4, num_of_iter);
q_est = zeros(4, num_of_iter);
euler_est = zeros(3, num_of_iter);
angle_est = zeros(1, num_of_iter);
Rho_est = zeros(1, num_of_iter);
P_est = zeros(4, 4, num_of_iter);

% ==================== initialization k=0 =======================
k = 1; % k=1 because of MATLAB counting from 1 and not from 0

% prepare first measurement
r0 = [mag_ref_meas(:,k), acc_ref_meas(:,k)];
b0 = [mag_bdy_meas(:,k), acc_bdy_meas(:,k)];

[K, P, mk] = optimal_request_init(r0, b0, Mu_noise_var);

% ======================== algorithm ============================
for k = 2 : num_of_iter
    % get angular velocity measurement
    w = gyr_bdy_meas(:,k);
    
    % referent vector measurements
    r = [mag_ref_meas(:,k), acc_ref_meas(:,k)];
    % body vector measurements
    b = [mag_bdy_meas(:,k), acc_bdy_meas(:,k)];
    
    [K, P, mk, Rho] = optimal_request(K, P, mk, w, r, b, ...
        Mu_noise_var, Eta_noise_var, dT);
    
    % store calculated K and q for debug
    K_est(:,:,k) = K;
    q = get_quat_from_K(K);
    q_est(:,k) = q;
    angle_est(:,k) = 2.0 * acos(abs(q(1)));
    euler_est(:,k) = qib2Euler(q);
    Rho_est(k) = Rho;
    P_est(:,:,k) = P;
end

% calculate RMS error in degrees
angle_difference = rad2deg(angle_diff(euler_est, euler_gt)); % deg
rms_err = sqrt(sum(angle_difference.^2)); % deg
std_rms_err = sqrt(var(rms_err)); % deg

% print errors to the output stream
fprintf("Std RMS error = %f [deg]\n", std_rms_err);
fprintf("std_rms_err_threshold = %f [deg]\n\n", std_rms_err_threshold);

% plot angle errors
figure(1);
plot(t, angle_difference); 
title('Real vs Estimated Euler angles differences vs Time');
xlabel('time [s]'); 
ylabel('angle [deg]');
saveas(gcf, 'figures/figure1.jpg');
close

figure(2);
plot(t, rms_err); 
title('Real vs Estimated Euler angles RMS error vs Time');
xlabel('time [s]'); 
ylabel('angle [deg]');
saveas(gcf, 'figures/figure1.jpg');
close

if std_rms_err < std_rms_err_threshold
    test_passed = true;
else
    test_passed = false;
end

end

