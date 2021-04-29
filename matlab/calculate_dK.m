function [dK] = calculate_dK(r, b, Rho)
%CALCULATE_DK Summary of this function goes here
%   Detailed explanation goes here

[~, S, z, Sigma] = get_util_matrices(r, b, Rho);

dK = 1.0 / Rho * [S - Sigma * eye(3), z; z', Sigma];
end
