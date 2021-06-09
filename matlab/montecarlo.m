
% for debug
clear all;
close all;
rng('default'); % comment this line if running on GNU Octave
colordef black

Mu_noise_var_fact = 1;
main
figure(1)
hold on
plot(log(Rho_est))
hold off
figure(2)
hold on
diff = rad2deg(angle_diff(euler_gt, euler_est));
plot(diff(1,:));
hold off
figure(3)
hold on
diff = rad2deg(angle_diff(euler_gt, euler_est));
plot(diff(2,:));
hold off
figure(4)
hold on
diff = rad2deg(angle_diff(euler_gt, euler_est));
plot(diff(3,:));
hold off
figure(5)
hold on
diff = rad2deg(angle_diff(angle_est, angle_gt));
plot(diff);
hold off
figure(6)
hold on
[up, lo] = envelope(diff, 30, 'peak');
envel = [up; lo]';
plot(envel, 'y');
hold off

Mu_noise_var_fact = 0.1;
main
figure(1)
hold on
plot(log(Rho_est))
hold off
figure(2)
hold on
diff = rad2deg(angle_diff(euler_gt, euler_est));
plot(diff(1,:));
hold off
figure(3)
hold on
diff = rad2deg(angle_diff(euler_gt, euler_est));
plot(diff(2,:));
hold off
figure(4)
hold on
diff = rad2deg(angle_diff(euler_gt, euler_est));
plot(diff(3,:));
hold off
figure(5)
hold on
diff = rad2deg(angle_diff(angle_est, angle_gt));
plot(diff);
hold off
figure(6)
hold on
[up, lo] = envelope(diff, 30, 'peak');
envel = [up; lo]';
plot(envel, 'b');
hold off

Mu_noise_var_fact = 0.01;
main
figure(1)
hold on
plot(log(Rho_est))
hold off
figure(2)
hold on
diff = rad2deg(angle_diff(euler_gt, euler_est));
plot(diff(1,:));
hold off
figure(3)
hold on
diff = rad2deg(angle_diff(euler_gt, euler_est));
plot(diff(2,:));
hold off
figure(4)
hold on
diff = rad2deg(angle_diff(euler_gt, euler_est));
plot(diff(3,:));
hold off
figure(5)
hold on
diff = rad2deg(angle_diff(angle_est, angle_gt));
plot(diff);
hold off
figure(6)
hold on
[up, lo] = envelope(diff, 30, 'peak');
envel = [up; lo]';
plot(envel, 'r');
hold off

Mu_noise_var_fact = 10;
main
figure(1)
hold on
plot(log(Rho_est))
hold off
figure(2)
hold on
diff = rad2deg(angle_diff(euler_gt, euler_est));
plot(diff(1,:));
hold off
figure(3)
hold on
diff = rad2deg(angle_diff(euler_gt, euler_est));
plot(diff(2,:));
hold off
figure(4)
hold on
diff = rad2deg(angle_diff(euler_gt, euler_est));
plot(diff(3,:));
hold off
figure(5)
hold on
diff = rad2deg(angle_diff(angle_est, angle_gt));
plot(diff);
hold off
figure(6)
hold on
[up, lo] = envelope(diff, 30, 'peak');
envel = [up; lo]';
plot(envel, 'g');
hold off

figure(1); 
legend('var = var * 1', 'var = var * 0.1', 'var = var * 0.01', 'var = var * 10');
figure(2); 
legend('var = var * 1', 'var = var * 0.1', 'var = var * 0.01', 'var = var * 10');
figure(3); 
legend('var = var * 1', 'var = var * 0.1', 'var = var * 0.01', 'var = var * 10');
figure(4); 
legend('var = var * 1', 'var = var * 0.1', 'var = var * 0.01', 'var = var * 10');
figure(5); 
legend('var = var * 1', 'var = var * 0.1', 'var = var * 0.01', 'var = var * 10');
figure(6); 
dim = [0 0 0.3 0.3];
str = {'ZUTO var = var * 1', 'PLAVO var = var * 0.1', 'CRVENO var = var * 0.01', 'ZELENO var = var * 10'};
t = annotation('textbox',dim,'String',str,'FitBoxToText','on');
t.BackgroundColor = 'white';

figure(1); 
title('Rho (Kalmanovo pojacanje)');
figure(2); 
title('greska u 1. eulerovom kutu u stupnjevima');
figure(3); 
title('greska u 2. eulerovom kutu u stupnjevima');
figure(4); 
title('greska u 3. eulerovom kutu u stupnjevima');
figure(5); 
title('greska u kutu rotacije u stupnjevima');
figure(6); 
title('envelopa greske u kutu rotacije u stupnjevima');


















