clear all;  % for debug
close all;

% TODO: Remove index on the variables with index k+1, dmk1 -> dm
%       and set the variables with index k to dmk, m_k -> mk

% =========================== constants ==============================
NUM_OF_ITER = 100;
dt = 0.01;  % in seconds

% ======================== vector measurements ========================
w_meas = zeros(3, NUM_OF_ITER);  % angular velocity
r_meas = zeros(3, NUM_OF_ITER);  % reference vector
b_meas = zeros(3, NUM_OF_ITER);  % body vector

% ======================== initialization ==============================
% TODO: how do we set R0?
R0 = eye(4);

% TODO: how do we set dm?
mk = 1.0;

% dK_0, TODO: eq. 12, 13
dK = 0.001 * eye(4);

K = dK;
P = R0;

% ======================== algorithm ================================
for k = 1 : NUM_OF_ITER
    % =================== time update ===================
    % get angular velocity measurement
    w = w_meas(:,k);
    
    % eq. 4
    wx = [0, -w(3), w(2); w(3), 0, -w(1); -w(2), w(1), 0];
    
    % eq. 10
    Omega = 1.0/2 * [-wx, w; -w.', 0];
    
    % eq. 9
    Phi = expm(Omega * dt); % eq. 9
    
    % eq. 11
    K = Phi * K * Phi.';
    
    Q = calculate_Q(); % TODO: eq. 24, 25, 44
    
    % eq. 69
    P = Phi * P * Phi.' + Q;
    
    % ================ measurement update ===============
    % measure body vector
    b = b_meas(:,k);
    % measure reference vector
    r = r_meas(:,k);
    
    % dm_k+1, TODO: calculate dmk1, see: REQUEST paper eq. 11a
    dmk1 = 1.0; 
    
    R = calculate_R();  % TODO: eq. 16, 17, 44
    
    % eq. 70
    Rho = (mk^2 * trace(P)) / (mk^2 * trace(P) ...
            + dmk1^2 * trace(R));
    
    % m_k+1 = (1.0 - Rho_k+1) * m_k + Rho_k+1 * dm_k+1, eq. 71
    mk1 = (1.0 - Rho) * mk + Rho * dmk1;
    
    % eq. 72
    K = (1 - Rho) * mk / mk1 * K + Rho * dmk1 / mk1 * dK;
    
    % Calculate dK (eq. 12, 13)
    B = Rho * b * r.';
    S = B + B.';
    zk = Rho * cross(b, r);
    Sigma = trace(B);
    dK = 1 / Rho * [S - Sigma * eye(3), zk; zk.', Sigma];
    
    R = calculate_R(); % TODO: eq. 16, 17, 44
    
    % eq. 73
    P = ((1 - Rho) * mk / mk1)^2 * P ...
        + (Rho * dmk1 / mk1)^2 * R;
    
    % optimal quaternion
    q = get_eigenvector(K);
    
    % for the next iteration: k = k+1
    mk = mk1;    
end







