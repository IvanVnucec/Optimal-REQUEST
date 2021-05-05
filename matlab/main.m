% =========================== info ==============================
% Script for testing the Optimal-REQUEST algorithm.
% Works in MATLAB or GNU Octave.
%
% Author: Ivan Vnucec, 2021
% License: MIT

% =========================== notes =============================
% All numbered equations are from Optimal-REQUEST algorithm 
% paper unless noted otherwise.
% 
% Indexes with k+1 are written without indexes and indexes with 
% k are written with _k. For example dm_k+1 is written as dm and
% dm_k is written as dmk.

% =========================== START =============================
% for debug
clear all;
close all;
rng('default');

% =========================== constants =========================
dT = 1;              % senzor refresh time, in seconds
simulation_time = 200;   % in seconds

num_of_iter = simulation_time / dT;
t = linspace(0, simulation_time, num_of_iter);

% ======================== measurements =========================
% === white Gauss zero mean noise ===
% TODO: add units below
gyr_bdy_meas_noise_std = 0.1;       % rad/s
acc_bdy_meas_noise_std = 0.15;      % m/s
mag_bdy_meas_noise_std = 100.15;    % nT

% TODO: See how we can calculate Mu meas nose (see eq. 36)
Mu_noise_std = acc_bdy_meas_noise_std + mag_bdy_meas_noise_std; % for R computation
Eta_noise_std = gyr_bdy_meas_noise_std;                         % for Q computation

% === w/o noise ===
% reference
acc_ref_meas = zeros(3, num_of_iter) + [0 0 -9.81]';            % m/s
mag_ref_meas = zeros(3, num_of_iter) + [22165.4 1743 42786.9]'; % nT

% rotate reference vectors to create body vectors
% rotate about by an angle
k = [1 1 1]';
angle = 2*pi/3;

% body
gyr_bdy_meas = zeros(3, num_of_iter);               % rad/s
acc_bdy_meas = rodrigues(acc_ref_meas, k, angle);   % m/s
mag_bdy_meas = rodrigues(mag_ref_meas, k, angle);   % nT

% == add noise to measurements ===
gyr_bdy_meas = gyr_bdy_meas + randn(size(gyr_bdy_meas)) * gyr_bdy_meas_noise_std;
acc_bdy_meas = acc_bdy_meas + randn(size(acc_bdy_meas)) * acc_bdy_meas_noise_std;
mag_bdy_meas = mag_bdy_meas + randn(size(mag_bdy_meas)) * mag_bdy_meas_noise_std;

% === normalize measurement vectors ===
% reference
acc_ref_meas = acc_ref_meas ./ vecnorm(acc_ref_meas);
mag_ref_meas = mag_ref_meas ./ vecnorm(mag_ref_meas);
% body
gyr_bdy_meas = gyr_bdy_meas ./ vecnorm(gyr_bdy_meas);
acc_bdy_meas = acc_bdy_meas ./ vecnorm(acc_bdy_meas);
mag_bdy_meas = mag_bdy_meas ./ vecnorm(mag_bdy_meas);

% ======================== algorithm output =====================
K_out = zeros(4, 4, num_of_iter);
q_out = zeros(4, 1, num_of_iter);
angle_out = zeros(1, num_of_iter);
Rho_out = zeros(1, num_of_iter);

% ==================== initialization k=0 =======================
k = 1; % because of MATLAB counting from 1 and not from 0

r0 = [mag_ref_meas(:,k), acc_ref_meas(:,k)];
b0 = [mag_bdy_meas(:,k), acc_bdy_meas(:,k)];
[~, ncols] = size(r0); 
a0 = ones(1, ncols) / ncols; % equal weights

% set dm0
dm0 = sum(a0); % see text after eq. 28

% calculate dK0
[dK0] = calculate_dK(r0, b0, a0);

% calculate R0
R0 = calculate_R(r0, b0, Mu_noise_std^2);

K = dK0; % eq. 3.59
P = R0;  % eq. 3.60
mk = dm0; % eq. 3.61

% ======================== algorithm ============================
for k = 2 : num_of_iter
    % =================== time update ===================
    % get angular velocity measurement
    w = gyr_bdy_meas(:,k);
    
    % eq. 4
    wx = [0, -w(3), w(2); w(3), 0, -w(1); -w(2), w(1), 0];
    
    % eq. 10
    Omega = 1.0 / 2 * [-wx, w; -w', 0];
    
    % eq. 9
    Phi = expm(Omega * dT); % eq. 9
    
    [B, ~, z, Sigma] = get_util_matrices(K);
    Q = calculate_Q(B, z, Sigma, Eta_noise_std^2, dT);
    
    % eq. 11
    K = Phi * K * Phi';
    
    % eq. 69
    P = Phi * P * Phi' + Q;
    
    % ================ measurement update ===============
    % referent vector measurements
    r = [mag_ref_meas(:,k), acc_ref_meas(:,k)];
    % body vector measurements
    b = [mag_bdy_meas(:,k), acc_bdy_meas(:,k)];
    % calc. meas. weights
    [~, ncols] = size(r); 
    a = ones(1, ncols) / ncols; % equal weights 
    
    dm = sum(a);
    
    R = calculate_R(r, b, Mu_noise_std^2);
    
    % eq. 70
    Rho = (mk^2 * trace(P)) / (mk^2 * trace(P) + dm^2 * trace(R));
    
    % eq. 71
    m = (1.0 - Rho) * mk + Rho * dm;
    
    [dK] = calculate_dK(r, b, a);
    
    % eq. 72
    K = (1.0 - Rho) * mk / m * K + Rho * dm / m * dK;
    
    % eq. 73
    P = ((1.0 - Rho) * mk / m)^2 * P + (Rho * dm / m)^2 * R;
    
    % for the next iteration m_k = m_k+1
    mk = m;
    
    % store calculated K and q for debug
    K_out(:,:,k) = K;
    q = get_quat_from_K(K);
    q_out(:,:,k) = q;
    angle_out(:,k) = 2.0 * atan2(sqrt(q(2)^2 + q(3)^2 + q(4)^2), q(1));
    Rho_out(k) = Rho;
end

figure;
plot(t, rad2deg(angle - angle_out)); 
title('Real vs Estimated angle difference vs Time');
xlabel('time [s]'); 
ylabel('angle [deg]');
grid on;

% plot the optimal filter gain
figure; 
semilogy(t, Rho_out); 
title('Rho vs Time'); 
xlabel('time [s]'); 
ylabel('Rho');
grid on;









