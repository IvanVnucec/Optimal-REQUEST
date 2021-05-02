function [dK, B, S, z, Sigma] = calculate_dK(r, b, a)
%CALCULATE_DK Summary of this function goes here
%   Detailed explanation goes here

[~, ncols] = size(r);

% eqs. 3.7
B = zeros(3, 3);
z = zeros(3, 1);
Sigma = 0.0;
for i = 1:ncols
    ai = a(i);
    bi = b(:,i);
    ri = r(:,i);
    
    B = B + ai * bi * ri';
    z = z + ai * cross(bi, ri);
    Sigma = Sigma + ai * bi' * ri;
end
S = B + B';

dK = [S - Sigma * eye(3), z; z', Sigma];

end
