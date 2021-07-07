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
dT = 10;                        % Sampling time in seconds
n  = [0 0 1]';                  % Rotation vector (unnormalized)
n_velocity = 1;                 % Angular velocity around rotation vector in rad/s

% === Sensors white Gauss zero mean noise ===
% we got this values by measuring our IMU sensor
acc_bdy_meas_noise_std = [0.01195    0.01202    0.01290]';        % m/s^2
mag_bdy_meas_noise_std = [0.77086    0.76900    0.76907]';        % uT
gyr_bdy_meas_noise_std = [0.00049    0.00052    0.00068]';        % rad/s

% === Gyroscope bias rate of change ===
% this value was not measured
% this value must be constant
gyr_bdy_meas_bias_rate = 0 * [1  1  1]';           % rad/s/s

t = 0:dT:simulation_time;
num_of_iter = length(t);

n_norm = n ./ vecnorm(n);

% Vector measurements
% Inertial, NED coordinates
% we got this values by measuring our IMU sensor and looking into IGRF model (google it)
acc_ref_meas = zeros(3, num_of_iter) + [-0.48133   -0.46010   -9.25942]';   % m/s^2
mag_ref_meas = zeros(3, num_of_iter) + [39.96922   24.34472    3.66588]';   % uT
gyr_ref_meas = zeros(3, num_of_iter) + n_velocity * n_norm;                 % rad/s
% Body
acc_bdy_meas_true = zeros(3, num_of_iter);
mag_bdy_meas_true = zeros(3, num_of_iter);
gyr_bdy_meas_true = zeros(3, num_of_iter);
% True quaternion
qib_gt = zeros(4, num_of_iter);
% True Euler angles
euler_gt = zeros(3, num_of_iter);
% True Angle
% This is valid because ang. vel. is constant
alpha = n_velocity * t;
angle_gt = zeros(1, num_of_iter);

% calculate the gyro bias for every iteration
% we can do this because bias rate is constant
gyr_bdy_meas_bias = t .* gyr_bdy_meas_bias_rate;

% rotate the reference measurements to create true body measurements
for i = 1:num_of_iter
    qib_gt(:,i) = [cos(alpha(i)/2); sin(alpha(i)/2) * n_norm];
    angle_gt(i) = 2.0 * acos(abs(qib_gt(1,i)));
    Rib = qib2Rib(qib_gt(:,i));
    acc_bdy_meas_true(:,i) = Rib * acc_ref_meas(:,i);
    mag_bdy_meas_true(:,i) = Rib * mag_ref_meas(:,i);
    gyr_bdy_meas_true(:,i) = Rib * gyr_ref_meas(:,i);
    euler_gt(:,i) = qib2Euler(qib_gt(:,i));
end

% === compute Mu and Eta noise variances for Q and R computation ===
% for R computation
mean_acc_bdy_len = mean(vecnorm(acc_bdy_meas_true));     % m/s^2
mean_mag_bdy_len = mean(vecnorm(mag_bdy_meas_true));     % uT
% normalize noise std to vector mean
norm_acc_bdy_std = acc_bdy_meas_noise_std / mean_acc_bdy_len;
norm_mag_bdy_std = mag_bdy_meas_noise_std / mean_mag_bdy_len;
% calculate normalized variances
Mu_noise_var = sum(norm_acc_bdy_std.^2 + norm_mag_bdy_std.^2);
% for Q computation
Eta_noise_var = sum(gyr_bdy_meas_noise_std.^2);

% === add gaussian noise to body measurements ===
acc_bdy_meas = acc_bdy_meas_true + randn(size(acc_bdy_meas_true)) .* acc_bdy_meas_noise_std;
mag_bdy_meas = mag_bdy_meas_true + randn(size(mag_bdy_meas_true)) .* mag_bdy_meas_noise_std;
gyr_bdy_meas = gyr_bdy_meas_true + randn(size(gyr_bdy_meas_true)) .* gyr_bdy_meas_noise_std;

% === add gyro bias ===
gyr_bdy_meas = gyr_bdy_meas + gyr_bdy_meas_bias;

% === normalize acc and mag measurement vectors ===
% reference
acc_ref_meas = acc_ref_meas ./ vecnorm(acc_ref_meas);
mag_ref_meas = mag_ref_meas ./ vecnorm(mag_ref_meas);
% body
acc_bdy_meas = acc_bdy_meas ./ vecnorm(acc_bdy_meas);
mag_bdy_meas = mag_bdy_meas ./ vecnorm(mag_bdy_meas);

acc_bdy_meas_true = acc_bdy_meas_true ./ vecnorm(acc_bdy_meas_true);
mag_bdy_meas_true = mag_bdy_meas_true ./ vecnorm(mag_bdy_meas_true);


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

