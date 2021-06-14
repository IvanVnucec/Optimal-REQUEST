% =========================== Info ==============================
% About: Script for testing the Optimal-REQUEST algorithm. It generates 
%        artificial measurements, runs Optimal-REQUEST algorithm and plots 
%        the differences between true and estimated angles.

%
% Author:     Ivan Vnucec
% University: FER, Zagreb
% Date:       May, 2021
% License:    MIT

% =========================== START =============================
% for debug
clear all;
rng('default');
colordef black;

% generate all the data we need in main.m file
generate_measurements

% ======================== algorithm output =====================
K_est = zeros(4, 4, num_of_iter);
q_est = zeros(4, num_of_iter);
euler_est = zeros(3, num_of_iter);
angle_est = zeros(1, num_of_iter);
Rho_est = zeros(1, num_of_iter);
P_est = zeros(4, 4, num_of_iter);

% ==================== initialization k=0 =======================
k = 1; % k=1 because of MATLAB counting from 1 and not from 0

% prepare first measurement
r0 = [mag_ref_meas(:,k), acc_ref_meas(:,k)];
b0 = [mag_bdy_meas(:,k), acc_bdy_meas(:,k)];

[K, P, mk] = optimal_request_init(r0, b0, Mu_noise_var);

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

% ======================== plotting ============================
% plot angle difference between real and estimated angle
figure(1);
plot(t, angle_diff(euler_est, euler_gt)); 
title('Real vs Estimated Euler angles differences vs Time');
xlabel('time [s]'); 
ylabel('angle [deg]');
grid on;

% plot the optimal filter gain
figure(2); 
semilogy(t, Rho_est); 
title('Rho vs Time'); 
xlabel('time [s]'); 
ylabel('Rho');
grid on;


% ======================= Private functions =========================

function [q] = get_quat_from_K(K)
%GET_QUAT_FROM_K Function returns the eigenvector of matrice 'K' with the 
%   largest eigenvalue. 
%   The returned vector is quaternion rotation.
%
%   Ref. B states:
%   The optimal quaternionË†qk+1/k+1is the eigenvector ofKk+1/k+1,which belongs to its maximal eigenvalue.

% get eigenvector
[V, D] = eig(K);

% sort eigenvectors by eigenvalues
[~, ind] = sort(diag(D));
Vs = V(:,ind);

% pick the one with the largest eigenvalue which is at the end
q = Vs(:,end);

% Ref. B eq. 3 (text under), we are using different quaternion representation
q = [q(4); q(1:3)];

end
