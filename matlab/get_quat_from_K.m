function [q] = get_quat_from_K(K)
%GET_QUAT_FROM_K Function returns the eigenvector of the matrix 'K' with the 
%   largest eigenvalue. 
%   The returned vector is quaternion rotation.
%
%   ===== References ======
%   - Three-Axis Attitude Determination from Vector Observations,
%     M. D. Shuster* and S.D.  OhtComputer Sciences Corporation,  
%     Silver Spring,  Md.
%     J. GUIDANCE  AND CONTROL
%
%   ===== Changelog =====
%   - July, 2021 - Replaced Matlab eig() function for finding eigenvalues
%   of matrix K with different method used in the Reference above. This
%   change might improove execution speed and also improve code generation
%   with the Matlab Coder.
%
% Author:     Ivan Vnucec
% University: FER, Zagreb
% Date:       May, 2021
% License:    MIT

[~, S, z, ~] = get_util_matrices(K);

s1_1 = S(1,1);
s2_2 = S(2,2);
s1_2 = S(1,2);
s2_1 = S(2,1);
s3_3 = S(3,3);
s1_3 = S(1,3);
s3_1 = S(3,1);
s2_3 = S(2,3);
s3_2 = S(3,2);

Sigma = 1/2 * trace(S);
% Kappa = trace(adjoint(S)), do explicitly because GNU Octave doesn't have
% ajdoint function yet
Kappa = s1_1*s2_2 - s1_2*s2_1 + s1_1*s3_3 - s1_3*s3_1 + s2_2*s3_3 - s2_3*s3_2;
Delta = det(S);

a = Sigma^2 - Kappa;
b = Sigma^2 + z' * z;
c = Delta + z' * S * z;
d = z' * S^2 * z;

% TODO: Check method in eq. 72 in the reference above where we have
% explicit equation for Lambda_max and we don't need to estimate it with
% the Newton-Raphson method

% Newton-Raphon method, 2 pass is enough
% f(x)  = x^4 - (a + b)*x^2 - c*x + (a*b + c*Sigma - d)
% f'(x) = 4*x^3 - 2*(a + b)*x - c
Lambda = 1.0; % initial guess
for i = 1:2
    % Horner nested polynomial representation
    f = Sigma*c - d + a*b - Lambda*(c + Lambda*(- Lambda^2 + a + b));
    df = - c - Lambda*(- 4*Lambda^2 + 2*a + 2*b);
    Lambda = Lambda - f/df;
end

Alpha = Lambda^2 - Sigma^2 + Kappa;
Beta  = Lambda - Sigma;
Gamma = (Lambda + Sigma) * Alpha - Delta;

X = (Alpha * eye(3) + Beta * S + S^2) * z;

s = 1 / sqrt(Gamma^2 + vecnorm(X)^2);
q = s * [X; Gamma];

% because of Euler angles computation where we assume different quaternion
% representation
q = [q(4); q(1:3)];

end
