
% for debug
clear all;
colordef black

iter = 100;

Mu_noise_var_factors = 0.05 + (0.3-0.05) * rand(1, iter); 
rms_errors = zeros(3, iter);

hold on
for j = 1:10
    generate_measurements
    Mu_noise_var_const = Mu_noise_var;
for steps = 1 : iter
    Mu_noise_var = Mu_noise_var_const * Mu_noise_var_factors(steps);
   
    main

    e = angle_diff(euler_est, euler_gt).^2;
    ms_e = mean(e, 2);
    rms_errors(:,steps) = sqrt(ms_e);
end

errors = sqrt(sum(rms_errors.^2));
[min_error, index] = min(errors);
fprintf('factor = %f -> rms_error = [%f %f %f] rad\n', ...
    Mu_noise_var_factors(index), rms_errors(:,index));

scatter(Mu_noise_var_factors, errors)
end
hold off
xlabel('variance factor');
ylabel('angle RMS error');







