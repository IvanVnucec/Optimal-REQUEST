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
dT = 0.1;              % senzor refresh time, in seconds
simulation_time = 72;  % in seconds

t = 0:dT:simulation_time;
num_of_iter = length(t);

% ======================== measurements =========================
% === import simulated data ===
filename = 'measurements.csv';
data_from_file = importdata(filename);
data_from_file = struct2cell(data_from_file);
data = data_from_file{1};

acc_ref_meas = data(:,1:3)';         % ref. acc. m/s^2
mag_ref_meas = data(:,4:6)';         % ref. mag. uT

acc_bdy_meas = data(:,10:12)';       % body acc. m/s^2
mag_bdy_meas = data(:,13:15)';       % body mag. uT
gyr_bdy_meas = data(:,16:18)';       % body ang. vel. rad/s

qib_gt = data(:,19:22)';             % ground truh quat.
angle_real = 2.0 * acos(abs(qib_gt(1,:)));

euler_est = zeros(3, num_of_iter);
euler_gt = zeros(3, num_of_iter);

% === white Gauss zero mean noise ===
gyr_bdy_meas_noise_std = 0.01;       % rad/s
acc_bdy_meas_noise_std = 0.01;       % m/s^2
mag_bdy_meas_noise_std = 10.0;       % uT

% TODO: See how we can calculate Mu meas nose (see eq. 36)
Mu_noise_std = acc_bdy_meas_noise_std + mag_bdy_meas_noise_std; % for R computation
Eta_noise_std = gyr_bdy_meas_noise_std;                         % for Q computation

% == add gaussian noise to body measurements ===
gyr_bdy_meas = gyr_bdy_meas + randn(size(gyr_bdy_meas)) * gyr_bdy_meas_noise_std;
acc_bdy_meas = acc_bdy_meas + randn(size(acc_bdy_meas)) * acc_bdy_meas_noise_std;
mag_bdy_meas = mag_bdy_meas + randn(size(mag_bdy_meas)) * mag_bdy_meas_noise_std;

% === normalize measurement vectors ===
% reference
acc_ref_meas = acc_ref_meas ./ vecnorm(acc_ref_meas);
mag_ref_meas = mag_ref_meas ./ vecnorm(mag_ref_meas);
% body
acc_bdy_meas = acc_bdy_meas ./ vecnorm(acc_bdy_meas);
mag_bdy_meas = mag_bdy_meas ./ vecnorm(mag_bdy_meas);

% ======================== algorithm output =====================
K_out = zeros(4, 4, num_of_iter);
q_out = zeros(4, 1, num_of_iter);
angle_out = zeros(1, num_of_iter);
Rho_out = zeros(1, num_of_iter);

% ==================== initialization k=0 =======================
k = 1; % k=1 because of MATLAB counting from 1 and not from 0

% prepare first measurement and weights
r0 = [mag_ref_meas(:,k), acc_ref_meas(:,k)];
b0 = [mag_bdy_meas(:,k), acc_bdy_meas(:,k)];
[~, ncols] = size(b0); 
a0 = ones(1, ncols) ./ ncols; % equal weights

dm0 = sum(a0); % Ref. A eq. 11a
dK0 = calculate_dK(r0, b0, a0);
R0 = calculate_R(r0, b0, Mu_noise_std^2);

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
    Q = calculate_Q(B, z, Sigma, Eta_noise_std^2, dT);
    
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
    
    R = calculate_R(r, b, Mu_noise_std^2);
    
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
    K_out(:,:,k) = K;
    q = get_quat_from_K(K);
    q_out(:,:,k) = q;
    angle_out(:,k) = 2.0 * acos(abs(q(1)));
    Rho_out(k) = Rho;
      
    euler_est(:,k) = qib2Euler(q);
    euler_gt(:,k) = qib2Euler(qib_gt(:,k));
end

% plot real and estimated angle
subplot(3,1,1);
hold on;
plot(t, rad2deg(angle_real));
plot(t, rad2deg(angle_out));
title('Real and Estimated angle vs Time');
xlabel('time [s]'); 
ylabel('angle [deg]');
legend('Real angle', 'Estimated angle')
grid on;

% plot angle difference between real and estimated angle
subplot(3,1,2);
plot(t, rad2deg(angle_real - angle_out)); 
title('Real vs Estimated angle difference vs Time');
xlabel('time [s]'); 
ylabel('angle [deg]');
grid on;

% plot the optimal filter gain
subplot(3,1,3);
semilogy(t, Rho_out); 
title('Rho vs Time'); 
xlabel('time [s]'); 
ylabel('Rho');
grid on;

figure;
subplot(3,1,1);
plot(t, euler_gt(1,:), t, euler_est(1,:));
ylim([-180 180]);
grid on;
title('Real and Estimated Euler angle vs Time');
legend('Real angle', 'Estimated angle')
xlabel('Time [s]');
ylabel('Psi [deg]');

subplot(3,1,2);
plot(t, euler_gt(2,:), t, euler_est(2,:));
ylim([-180 180]);
grid on;
title('Real and Estimated Euler angle vs Time');
legend('Real angle', 'Estimated angle')
xlabel('Time [s]');
ylabel('Theta [deg]');

subplot(3,1,3);
plot(t, euler_gt(3,:), t, euler_est(3,:));
ylim([-180 180]);
grid on;
title('Real and Estimated Euler angle vs Time');
legend('Real angle', 'Estimated angle')
xlabel('Time [s]');
ylabel('Phi [deg]');









