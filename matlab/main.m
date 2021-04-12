clear all;
close all;

% constants
NUM_OF_ITER = 100;
dt = 0.01;

% initialization
dK0 = []; % eq. 12, 13
K = dK0;
P = R0;
m = dm0;

for k = 1 : NUM_OF_ITER
    %% === time update ===
    w = measure_w(); % measure angular vel.
    
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
    
    %% === measurement update ===
    % measure b vector
    b = measure_b();
    
    % measure r vector
    r = measure_r();
    
    % TODO: how do we calculate dm?
    dm = 1.0; % maybe???
    
    % eq. 70
    Rho = (m^2 * trace(P)) / (m^2 * trace(P) + dm^2 * trace(R));
    
    % eq. 71
    mk1 = (1 - Rho) * m + Rho * dmk1;
    
    % eq. 72
    K = (1 - Rho) * mk / mk1 * K + Rho * dmk1 / mk1 * dK;
    
    % Calculate dK (eq. 12, 13)
    B = Rho * b * r.';
    S = B + B.';
    zk = Rho * vect(b, r);
    Sigma = trace(B);
    dK = 1 / Rho * [S - Sigma * eye(3), zk; zk.', Sigma];
    
    R = calculate_R(); % TODO: eq. 16, 17, 44
    
    % eq. 73
    P = ((1 - Rho) * mk / mk1)^2 * P + (Rho * dmk1 / mk1)^2 * R;
    
    % optimal quaternion
    q = get_eigenvector(K);
    
    % for the next iteration
    mk = mk1;
end







