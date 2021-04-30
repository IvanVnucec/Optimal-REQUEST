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
% for debug
clear all;
close all;
%rng('default');

% =========================== constants =========================
NUM_OF_ITER = 100;
dT = 0.01;  % in seconds

% ======================== vector measurements ==================
% white Gauss zero mean noise
% TODO: add units below
w_noise_std = 0.1;      % w vector noise sandard deviation
b_noise_std = 0.15;     % b vector noise sandard deviation

% w/o noise
w_meas = zeros(3, NUM_OF_ITER);     % angular velocity
r_meas = zeros(3, NUM_OF_ITER); r_meas(1,:) = 1.0; % ref. vector
b_meas = zeros(3, NUM_OF_ITER); b_meas(1,:) = 1.0; % body vector

% normalize measurement vectors
r_meas = r_meas ./ vecnorm(r_meas);
b_meas = b_meas ./ vecnorm(b_meas);

% for debug
angle_b_r = acos(dot(r_meas, b_meas));

% add noise to measurements
w_meas = w_meas + randn(size(w_meas)) * w_noise_std;
b_meas = b_meas + randn(size(b_meas)) * b_noise_std;

% normalize measurement vectors
w_meas = w_meas ./ vecnorm(w_meas);
r_meas = r_meas ./ vecnorm(r_meas);
b_meas = b_meas ./ vecnorm(b_meas);

% ======================== algorithm output =====================
K_out = zeros(4, 4, NUM_OF_ITER);
q_out = zeros(4, 1, NUM_OF_ITER);
angle = zeros(1, NUM_OF_ITER);

% ==================== initialization k=1 =======================
Q0 = calculate_Q(r_meas(:,1), b_meas(:,1), w_noise_std^2, dT);
R0 = calculate_R(r_meas(:,1), b_meas(:,1), b_noise_std^2);

mk0 = 1.0;

% Rho = 1.0 <=> put all the weight to the measuerements
Rho0 = 1.0;
dK0 = calculate_dK(r_meas(:,1), b_meas(:,1), Rho0);

mk = mk0;
dK = dK0;
K = dK;
P = R0;
Q = Q0;

% ======================== algorithm ============================
for k = 2 : NUM_OF_ITER
    % =================== time update ===================
    % get angular velocity measurement
    w = w_meas(:,k);
    
    % eq. 4
    wx = [0, -w(3), w(2); w(3), 0, -w(1); -w(2), w(1), 0];
    
    % eq. 10
    Omega = 1.0 / 2 * [-wx, w; -w', 0];
    
    % eq. 9
    Phi = expm(Omega * dT); % eq. 9
    
    % eq. 11
    K = Phi * K * Phi';
    
    % eq. 69
    P = Phi * P * Phi' + Q;
    
    % ================ measurement update ===============
    % get body vector measurements
    b = b_meas(:,k);
    % get referent vector measurements
    r = r_meas(:,k);
    
    Q = calculate_Q(r, b, w_noise_std^2, dT);
    
    % TODO: calculate dm, see: REQUEST paper eq. 11a
    dm = 1.0;
    
    R = calculate_R(r, b, b_noise_std^2);
    
    % eq. 70
    Rho = (mk^2 * trace(P)) / (mk^2 * trace(P) + dm^2 * trace(R));
    
    % eq. 71
    m = (1.0 - Rho) * mk + Rho * dm;
    
    dK = calculate_dK(r, b, Rho);
    
    % eq. 72
    K = (1.0 - Rho) * mk / m * K + Rho * dm / m * dK;
    
    % eq. 73
    P = ((1.0 - Rho) * mk / m)^2 * P ...
        + (Rho * dm / m)^2 * R;
    
    % for the next iteration m_k = m_k+1
    mk = m;   
    
    % store calculated K and q for debug
    K_out(:,:,k) = K;
    q = get_quat_from_K(K);
    q_out(:,:,k) = q;
    angle(:,k) = 2.0 * atan2(sqrt(q(2)^2 + q(3)^2 + q(4)^2), q(1));
end

% plot the angle diff between the real and estimated angle
diff = pi - abs(mod(abs(angle - angle_b_r), 2*pi) - pi);
plot(diff);









