% =========================== info ==============================
% Script for testing the Optimal-REQUEST algorithm.
% Works in MATLAB or GNU Octave. For GNU Octave delete the
% rng('default'); line because rng function is not yet 
% implemented.
%
% Author: Ivan Vnucec, 2021
% License: MIT

% =========================== START =============================
% for debug
clear all;
close all;
rng('default'); % comment this line if running on GNU Octave
colordef black;

% ======================== measurements =========================
% === import simulated data ===
generate_measurements

% === white Gauss zero mean noise ===
gyr_bdy_meas_noise_std = 0.1;       % rad/s
acc_bdy_meas_noise_std = 0.1;       % m/s^2
mag_bdy_meas_noise_std = 10.0;      % uT

% === compute Mu and Eta noise variances for Q and R computation ===
% for R computation
mean_acc_bdy_len = mean(vecnorm(acc_bdy_meas_true));     % m/s^2
mean_mag_bdy_len = mean(vecnorm(mag_bdy_meas_true));     % uT
% normalize noise std to vector mean
norm_acc_bdy_std = acc_bdy_meas_noise_std / mean_acc_bdy_len;
norm_mag_bdy_std = mag_bdy_meas_noise_std / mean_mag_bdy_len;
% calculate normalized variances
Mu_noise_var = norm_acc_bdy_std^2 + norm_mag_bdy_std^2;
Mu_noise_var_fact = 1;  % TODO: Delete this after testing finishes.
Mu_noise_var = Mu_noise_var * Mu_noise_var_fact;
% for Q computation
Eta_noise_var = gyr_bdy_meas_noise_std^2;

% === add gaussian noise to body measurements ===
gyr_bdy_meas = gyr_bdy_meas_true + randn(size(gyr_bdy_meas_true)) * gyr_bdy_meas_noise_std;
acc_bdy_meas = acc_bdy_meas_true + randn(size(acc_bdy_meas_true)) * acc_bdy_meas_noise_std;
mag_bdy_meas = mag_bdy_meas_true + randn(size(mag_bdy_meas_true)) * mag_bdy_meas_noise_std;

% === normalize measurement vectors ===
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

% prepare first measurement and weights
r0 = [mag_ref_meas(:,k), acc_ref_meas(:,k)];
b0 = [mag_bdy_meas(:,k), acc_bdy_meas(:,k)];
[~, ncols] = size(b0); 
a0 = ones(1, ncols) ./ ncols; % equal weights

dm0 = sum(a0); % Ref. A eq. 11a
dK0 = calculate_dK(r0, b0, a0);
R0 = calculate_R(r0, b0, Mu_noise_var);

K = dK0;    % Ref. B eq. 65
P = R0;     % Ref. B eq. 66
mk = dm0;   % Ref. B eq. 67, mk = m_k

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

% plot Euler angles and difference in Euler angles
figure(1);
subplot(3,1,1);
plot(t, rad2deg(angdiff(euler_gt(1,:), euler_est(1,:))));
grid on;
title('Real and Estimated Euler angle difference vs Time');
xlabel('Time [s]');
ylabel('Psi [deg]');

subplot(3,1,2);
plot(t, rad2deg(angdiff(euler_gt(2,:), euler_est(2,:))));
grid on;
title('Real and Estimated Euler angle difference vs Time');
xlabel('Time [s]');
ylabel('Theta [deg]');

subplot(3,1,3);
plot(t, rad2deg(angdiff(euler_gt(3,:), euler_est(3,:))));
grid on;
title('Real and Estimated Euler angle difference vs Time');
xlabel('Time [s]');
ylabel('Phi [deg]');

% plot real and estimated angle
figure(2);
subplot(3,1,1);
hold on;
plot(t, rad2deg(angle_gt));
plot(t, rad2deg(angle_est));
title('Real and Estimated angle vs Time');
xlabel('time [s]'); 
ylabel('angle [deg]');
grid on;

% plot angle difference between real and estimated angle
subplot(3,1,2);
plot(t, rad2deg(angdiff(angle_gt, angle_est))); 
title('Real vs Estimated angle difference vs Time');
xlabel('time [s]'); 
ylabel('angle [deg]');
grid on;

% plot the optimal filter gain
subplot(3,1,3);
semilogy(t, Rho_est); 
title('Rho vs Time'); 
xlabel('time [s]'); 
ylabel('Rho');
grid on;

% TODO: Delete this after testing finishes.
alg_err = angle_diff(euler_gt, euler_est).^2;
alg_err = sum(alg_err);
alg_err = alg_err .* Rho_est;
fprintf('fac = %f\n', Mu_noise_var_fact);
fprintf('avg = %f\n', mean(alg_err));
fprintf('std = %f\n', var(alg_err)^0.5);

figure(3);
plot(20*log(alg_err));
grid on;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    




