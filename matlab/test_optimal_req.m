% =========================== Info ==============================
% About: Test the Optimal-REQUEST algorithm with GNU Octave
%
% Author:     Ivan Vnucec
% University: FER, Zagreb
% Date:       Jul, 2021
% License:    MIT

% =========================== START =============================
% for debug
clear all;

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

% calculate RMS error in degrees
err = sqrt(sum((euler_est - euler_gt).^2)) * 180.0 / pi;
max_err = max(err);
err_threshold = 10; % deg

printf("max_err = %f [deg]\n", max_err);
printf("err_threshold = %f [deg]\n\n", err_threshold);


if max_err < err_threshold
    printf("Test Succeded!")
    exit(0);
else
    printf("Test Failed: error greather than error threshold!");
    exit(1); % fail
end
