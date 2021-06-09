% =========================== info ==============================
% Script for testing the Optimal-REQUEST algorithm.
% Works in MATLAB or GNU Octave. For GNU Octave delete the
% rng('default'); line because rng function is not yet 
% implemented.
%
% Author: Ivan Vnucec, 2021
% License: MIT

% =========================== START =============================

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

alg_err = angle_diff(euler_gt, euler_est).^2;
alg_err = sum(alg_err);
alg_err = alg_err .* Rho_est;
    
    
    
    
    
    
    
    
    
    
    
    
    




