function [Q] = calculate_Q(r, b, var, dT)
%CALCULATE_Q Summary of this function goes here
%   Detailed explanation goes here
% see NOVEL METHODSFORATTITUDE DETERMINATIONUSING VECTOR OBSERVATIONSDaniel Choukroun
% Appendix B

% TODO: see what weight we send to get_util_matrices
[B, ~, z, Sigma] = get_util_matrices(r, b, 1.0);

M = B * (B - Sigma * eye(3));
yx = M' - M;
y = [yx(3,2); yx(1,3); yx(2,1)];

Q11 = var * ((z' * z + Sigma^2 - trace(B * B')) * eye(3) ...
    + 2 * (B' * B - B^2 - B'^2));
Q12 = -var * (y + B' * z);
Q21 = Q12';
Q22 = var * (trace(B * B') + Sigma^2 + z' * z);

Q = [Q11, Q12; Q21, Q22] * dT^2;
end
