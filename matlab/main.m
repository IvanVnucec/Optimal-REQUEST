clear all;

% constants
NUM_OF_ITER = 100;

% initialization
dK0 = []; % eq. 12, 13
K = dK0;
P = R0;
m = dm0;

for k = 1 : NUM_OF_ITER
    % time update
    Phi = []; % eq. 9
    K = Phi * K * Phi.';
    Q = []; % eq. 24, 25, 44
    P = Phi * P * Phi.' + Q;
    
    % measurement update
    b = [];
    w = [];
    Rho = (m^2 * trace(P)) / (m^2 * trace(P) + dm^2 * trace(R));
    mk1 = (1 - Rho) * m + Rho * dmk1;
    bx = [0 -b3 b2; b3 0 -b1; -b2 b1 0];
    zk = Rho * bx * r;
    K = (1 - Rho) * mk / mk1 * K + Rho * dmk1 / mk1 * dK;
    B = Rho * b * r.';
    Sigma = trace(B);
    S = B + B.';
    dK = 1 / Rho * [S - Sigma * eye(3), zk; zk.', Sigma]; % eq. 12, 13
    R = []; % eq. 16, 17, 44
    P = ((1 - Rho) * mk / mk1)^2 * P + (Rho * dmk1 / mk1)^2 * R;
    
    % optimal quaternion
    q = get_eigenvector(K);
end







