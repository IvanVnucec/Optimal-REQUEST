function [Q] = calculate_Q(B, z, Sigma, var, dT)
%CALCULATE_Q Compute matrice 'Q'.
%   Compute matrice 'Q' with submatrices 'B', 'z', 'Sigma', noise variance 
%   variance 'var' and time difference 'dT'. 'B', 'z' and 'Sigma' 
%   submatrices can be calculated via the 'get_util_matrices' function.
%   
%   Ref. C eq. B.2.1.4a - B.2.1.4d, (for references list see main.m file under reference 
%   comment section).
%
% Author: Ivan Vnucec, FER, Zagreb, 2021
% License: MIT

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
