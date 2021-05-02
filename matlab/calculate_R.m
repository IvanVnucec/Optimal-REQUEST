function [R] = calculate_R(r, b, variance)
%CALCULATE_Q Summary of this function goes here
%   Detailed explanation goes here
% see NOVEL METHODSFORATTITUDE DETERMINATIONUSING VECTOR OBSERVATIONSDaniel Choukroun
% Appendix B

[~, ncols] = size(r);

R11 = zeros(3, 3);
for k = 1 : ncols
    rk = r(:, k);
    bk = b(:, k);
    
    rx = [0, -rk(3), rk(2); rk(3), 0, -rk(1); -rk(2), rk(1), 0];

    R11 = R11 + (3.0 - (rk' * bk)^2) * eye(3) + (bk' * rk) * (bk * rk' + rk * bk') ...
        + rx * (bk * bk') * rx';
end

R11 = variance / ncols * R11;
R12 = zeros(3, 1);
R21 = R12';
R22 = 2.0 * variance / ncols;

R = [R11, R12; R21, R22];
end

