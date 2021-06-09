% =========================== info ==============================
% Script for testing the Optimal-REQUEST algorithm.
% Works in MATLAB or GNU Octave.
%
% Author: Ivan Vnucec, 2021
% License: MIT

% =========================== notes =============================
% Almost all of the algorithm equations have references to some
% paper. The reference equations are written in the form for ex.
% Ref A eq. 25 where letter 'A' denotes reference to the paper
% and the number '25' the equation number it that paper. The 
% references are listed under Reference section below.
% 
% Indexes with k+1 are written without indexes and indexes with 
% k are written with _k. For example dm_k+1 is written as dm and
% dm_k is written as dmk.

% ========================= references ==========================
% Ref A: 
%   REQUEST: A Recursive QUEST Algorithmfor Sequential Attitude Determination
%   Itzhack Y. Bar-Itzhack, 
%   https://sci-hub.se/https://doi.org/10.2514/3.21742
%
% Ref B: 
%   Optimal-REQUEST Algorithm for Attitude Determination,
%   D. Choukroun,I. Y. Bar-Itzhack, and Y. Oshman,
%   https://sci-hub.se/10.2514/1.10337
%
% Ref. C: 
%   Appendix B, Novel Methods for Attitude Determination Using Vector Observations,
%   Daniel Choukroun,
%   https://www.researchgate.net/profile/Daniel-Choukroun/publication/265455600_Novel_Methods_for_Attitude_Determination_Using_Vector_Observations/links/5509c02b0cf26198a639a83c/Novel-Methods-for-Attitude-Determination-Using-Vector-Observations.pdf#page=253
%
% Ref. D: 
%   Appendixes, ttitude Determination Using Vector Observations andthe Singular Value Decomposition
%   Markley, F. L.,
%   http://malcolmdshuster.com/FC_Markley_1988_J_SVD_JAS_MDSscan.pdf

% =========================== START =============================
% for debug
clear all;
close all;
rng('default');

% =========================== constants =========================
%dT = 0.1;              % senzor refresh time, in seconds
%simulation_time = 72;  % in seconds

%t = 0:dT:simulation_time;
%num_of_iter = length(t);

% ======================== measurements =========================
% === import simulated data ===
generate_measurements

% === white Gauss zero mean noise ===
gyr_bdy_meas_noise_std = 0.1;       % rad/s
acc_bdy_meas_noise_std = 0.1;       % m/s^2
mag_bdy_meas_noise_std = 10.0;       % uT

% === compute Mu and Eta noise variances for Q and R computation ===
% for R computation
mean_acc_bdy_len = mean(vecnorm(acc_bdy_meas_true));     % m/s^2
mean_mag_bdy_len = mean(vecnorm(mag_bdy_meas_true));     % uT
% normalize noise std to vector mean
norm_acc_bdy_std = acc_bdy_meas_noise_std / mean_acc_bdy_len;
norm_mag_bdy_std = mag_bdy_meas_noise_std / mean_mag_bdy_len;
% calculate normalized variances
Mu_noise_var = norm_acc_bdy_std^2 + norm_mag_bdy_std^2;
Mu_noise_var_fact = 1;
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
    % =================== time update ===================
    % get angular velocity measurement
    w = gyr_bdy_meas(:,k);
    
    % Ref. B eq. 4
    wx = [0, -w(3), w(2); w(3), 0, -w(1); -w(2), w(1), 0];
    
    % Ref. B eq. 10
    Omega = 1.0 / 2 * [-wx, w; -w', 0];
    
    % Ref. B eq. 9
    Phi = expm(Omega * dT); % eq. 9
    
    [B, ~, z, Sigma] = get_util_matrices(K);
    Q = calculate_Q(B, z, Sigma, Eta_noise_var, dT);
    
    % Ref. B eq. 11
    K = Phi * K * Phi';
    
    % Ref. B eq. 69
    P = Phi * P * Phi' + Q;
    
    % ================ measurement update ===============
    % referent vector measurements
    r = [mag_ref_meas(:,k), acc_ref_meas(:,k)];
    % body vector measurements
    b = [mag_bdy_meas(:,k), acc_bdy_meas(:,k)];
    % calc. meas. weights
    [~, ncols] = size(b); 
    a = ones(1, ncols) ./ ncols; % equal weights 
    
    dm = sum(a);
    
    R = calculate_R(r, b, Mu_noise_var);
    
    % Ref. B eq. 70
    Rho = (mk^2 * trace(P)) / (mk^2 * trace(P) + dm^2 * trace(R));
    
    % Ref. B eq. 71
    m = (1.0 - Rho) * mk + Rho * dm;
    
    dK = calculate_dK(r, b, a);
    
    % Ref. B eq. 72
    K = (1.0 - Rho) * mk / m * K + Rho * dm / m * dK;
    
    % Ref. B eq. 73
    P = ((1.0 - Rho) * mk / m)^2 * P + (Rho * dm / m)^2 * R;
    
    % for the next iteration m_k = m_k+1
    mk = m;
    
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

alg_err = angdiff(euler_gt, euler_est).^2;
alg_err = sum(alg_err);
alg_err = alg_err .* Rho_est;
fprintf('fac = %f\n', Mu_noise_var_fact);
fprintf('avg = %f\n', mean(alg_err));
fprintf('std = %f\n', var(alg_err)^0.5);

figure(3);
plot(20*log(alg_err));
grid on;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    




