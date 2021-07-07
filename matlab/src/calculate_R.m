function [R] = calculate_R(r, b, var)
%CALCULATE_R Function computes the R matrix used in Optimal-REQUEST 
%            algorithm.
%   Compute matrice 'R' with reference matrice 'r', body measurements
%   matrice 'b' and measurement variance 'var'.
%
%   Ref. C eq. B.2.2.4a - B.2.2.4d, (for references list see main.m file under reference 
%   comment section).
%
% Author:     Ivan Vnucec
% University: FER, Zagreb
% Date:       May, 2021
% License:    MIT

[~, ncols] = size(r);

R11 = zeros(3, 3);
for i = 1 : ncols
    ri = r(:, i);
    bi = b(:, i);
    
    rx = [0, -ri(3), ri(2); ri(3), 0, -ri(1); -ri(2), ri(1), 0];

    R11 = R11 + (3.0 - (ri' * bi)^2) * eye(3) + (bi' * ri) * (bi * ri' + ri * bi') ...
        + rx * (bi * bi') * rx';
end

R11 = var / ncols * R11;
R12 = zeros(3, 1);
R21 = R12';
R22 = 2.0 * var / ncols;

R = [R11, R12; R21, R22];
end

