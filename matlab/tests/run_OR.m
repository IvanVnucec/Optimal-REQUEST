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
colordef black

% add scripts folder to path
addpath('./../scripts');

% ====================== TEST PARAMETERS ========================
simulation_time = 2000;     % simulation time in sec
dT = 10;                    % sensor sampling period in sec

% generate and load measurements
measurements = gen_meas(simulation_time, dT);
meas = load(measurements);

% ======================== algorithm output =====================
K_est = zeros(4, 4, meas.num_of_iter);
q_est = zeros(4, meas.num_of_iter);
euler_est = zeros(3, meas.num_of_iter);
angle_est = zeros(1, meas.num_of_iter);
Rho_est = zeros(1, meas.num_of_iter);
P_est = zeros(4, 4, meas.num_of_iter);

% ==================== initialization k=0 =======================
k = 1; % k=1 because of MATLAB counting from 1 and not from 0

% prepare first measurement
r0 = [meas.mag_ref_meas(:,k), meas.acc_ref_meas(:,k)];
b0 = [meas.mag_bdy_meas(:,k), meas.acc_bdy_meas(:,k)];

[K, P, mk] = optimal_request_init(r0, b0, meas.Mu_noise_var);

% ======================== algorithm ============================
for k = 2 : meas.num_of_iter
    % get angular velocity measurement
    w = meas.gyr_bdy_meas(:,k);
    
    % referent vector measurements
    r = [meas.mag_ref_meas(:,k), meas.acc_ref_meas(:,k)];
    % body vector measurements
    b = [meas.mag_bdy_meas(:,k), meas.acc_bdy_meas(:,k)];
    
    [K, P, mk, Rho] = optimal_request(K, P, mk, w, r, b, ...
        meas.Mu_noise_var, meas.Eta_noise_var, dT);
    
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
plot(meas.t, angle_diff(euler_est, meas.euler_gt)); 
title('Real vs Estimated Euler angles differences vs Time');
xlabel('time [s]'); 
ylabel('angle [deg]');
grid on;

% plot the optimal filter gain
figure(2); 
semilogy(meas.t, Rho_est); 
title('Rho vs Time'); 
xlabel('time [s]'); 
ylabel('Rho');
grid on;
