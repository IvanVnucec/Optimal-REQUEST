%% Generates accelerometer, magnetometer and gyro measurements
%
% Generate artificial measurements for Optimal-REQUEST algorithm testing.
%
% Author: Josip Loncar, 
% FER, Zagreb, Croatia
% Date: 2021


simulation_time  = 2000;  % Simulation time in seconds
dT = 10;               % Sampling time in seconds
n  = [0, 0, 1]';        % Rotation vector (unnormalized)
omega = 1;             % Angular velocity around rotation vector in rad/s

t = 0:dT:simulation_time;
num_of_iter = length(t);

n_norm = n ./ vecnorm(n);

% Vector measurements
% Inertial, NED coordinates
acc_ref_meas = zeros(3, num_of_iter) + [0 0 -9.81]';             % m/s^2
mag_ref_meas = zeros(3, num_of_iter) + [22.2 1.7 42.7]';         % uT
gyr_ref_meas = zeros(3, num_of_iter) + omega * n_norm;  % rad/s
% Body
acc_bdy_meas_true = zeros(3, num_of_iter);
mag_bdy_meas_true = zeros(3, num_of_iter);
gyr_bdy_meas_true = zeros(3, num_of_iter);
% True quaternion
qib_gt = zeros(4, num_of_iter);
% True Euler angles
euler_gt = zeros(3, num_of_iter);
% True Angle
% This is valid because ang. vel. is constant
alpha = omega * t;
angle_gt = zeros(1, num_of_iter);

for i = 1:num_of_iter
    qib_gt(:,i) = [cos(alpha(i)/2); sin(alpha(i)/2) * n_norm];
    angle_gt(i) = 2.0 * acos(abs(qib_gt(1,i)));
    Rib = qib2Rib(qib_gt(:,i));
    acc_bdy_meas_true(:,i) = Rib * acc_ref_meas(:,i);
    mag_bdy_meas_true(:,i) = Rib * mag_ref_meas(:,i);
    gyr_bdy_meas_true(:,i) = Rib * gyr_ref_meas(:,i);
    euler_gt(:,i) = qib2Euler(qib_gt(:,i));
end

















