function [dK, dB, dS, dz, dSigma] = calculate_dK(r, b, a)
%CALCULATE_DK Summary of this function goes here
%   Detailed explanation goes here

[~, ncols] = size(r);

% eqs. 3.7
dB = zeros(3, 3);
dz = zeros(3, 1);
dSigma = 0.0;
for i = 1:ncols
    ai = a(i);
    bi = b(:,i);
    ri = r(:,i);
    
    dB = dB + ai * bi * ri';
    dz = dz + ai * cross(bi, ri);
    dSigma = dSigma + ai * bi' * ri;
end
dS = dB + dB';

dK = [dS - dSigma * eye(3), dz; dz', dSigma];

end
