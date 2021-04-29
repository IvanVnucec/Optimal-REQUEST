% =========================== info ==============================
% Script for testing the Optimal-REQUEST algorithm.
% Works in MATLAB or GNU Octave.
%
% Author: Ivan Vnučec, 2021
% License: MIT

% =========================== notes =============================
% All numbered equations are from Optimal-REQUEST algorithm 
% paper unless noted otherwise.
% 
% Indexes with k+1 are written without indexes and indexes with 
% k are written with _k. For example dm_k+1 is written as dm and
% dm_k is written as dmk.

% =========================== START =============================
clear all;  % for debug
close all;

% =========================== constants =========================
NUM_OF_ITER = 100;
dt = 0.01;  % in seconds

% ======================== vector measurements ==================
% white Gauss zero mean noise
% TODO: add units below
w_noise_std = 0.1;      % w vector noise sandard deviation
b_noise_std = 1.0;      % b vector noise sandard deviation

% w/o noise
w_meas = zeros(3, NUM_OF_ITER);                    % angular velocity
r_meas = zeros(3, NUM_OF_ITER);                    % reference vector
b_meas = zeros(3, NUM_OF_ITER); b_meas(1,:) = 1.0; % body vector

% add noise to measurements
w_meas = w_meas + randn(size(w_meas)) * w_noise_std;
b_meas = b_meas + randn(size(b_meas)) * b_noise_std;

% ======================== algorithm output =====================
K_out = zeros(4, 4, NUM_OF_ITER);
q_out = zeros(4, 1, NUM_OF_ITER);

% ======================== initialization =======================
% TODO: how do we set R0?
R0 = eye(4);

% TODO: how do we set dm?
mk = 1.0;

% dK_0, TODO: eq. 12, 13
dK = 0.001 * eye(4);

K = dK;
P = R0;

% ======================== algorithm ============================
for k = 1 : NUM_OF_ITER
    % =================== time update ===================
    % get angular velocity measurement
    w = w_meas(:,k);
    
    % eq. 4
    wx = [0, -w(3), w(2); w(3), 0, -w(1); -w(2), w(1), 0];
    
    % eq. 10
    Omega = 1.0 / 2 * [-wx, w; -w', 0];
    
    % eq. 9
    Phi = expm(Omega * dt); % eq. 9
    
    % eq. 11
    K = Phi * K * Phi';
    
    Q = calculate_Q(); % TODO: eq. 24, 25, 44
    
    % eq. 69
    P = Phi * P * Phi' + Q;
    
    % ================ measurement update ===============
    % get body vector measurements
    b = b_meas(:,k);
    % get referent vector measurements
    r = r_meas(:,k);
    
    % TODO: calculate dm, see: REQUEST paper eq. 11a
    dm = 1.0;
    
    % TODO: eq. 16, 17, 44
    R = calculate_R();
    
    % eq. 70
    Rho = (mk^2 * trace(P)) / (mk^2 * trace(P) + dm^2 * trace(R));
    
    % eq. 71
    m = (1.0 - Rho) * mk + Rho * dm;
    
    % eq. 72
    K = (1.0 - Rho) * mk / m * K + Rho * dm / m * dK;
    
    % Calculate dK (eq. 12, 13)
    B = Rho * b * r';
    S = B + B';
    z = Rho * cross(b, r);
    Sigma = trace(B);
    dK = 1.0 / Rho * [S - Sigma * eye(3), z; z', Sigma];
    
    % TODO: eq. 16, 17, 44
    R = calculate_R();
    
    % eq. 73
    P = ((1.0 - Rho) * mk / m)^2 * P ...
        + (Rho * dm / m)^2 * R;
    
    % for the next iteration m_k = m_k+1
    mk = m;   
    
    % store calculated K and q for debug
    K_out(:,:,k) = K;
    q_out(:,:,k) = get_quat_from_K(K);
end
