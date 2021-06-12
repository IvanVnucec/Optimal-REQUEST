function [dK] = calculate_dK(r, b, a)
%CALCULATE_DK Calculate 'dK'.
%   Calculate 'dK' incremental matrice with reference matrice 'r', body 
%   matrice 'b' and weights assigned to each column vector in body matrice 
%   'a'.
%
%   Ref. A eq. 11b - 11f, (for references list see main.m file under reference 
%   comment section).
%
% Author:     Ivan Vnucec
% University: FER, Zagreb
% Date:       May, 2021
% License:    MIT

[~, ncols] = size(r);

% eqs. 3.7
dB = zeros(3, 3);
dz = zeros(3, 1);
dSigma = 0.0;
for i = 1:ncols
    ai = a(i);
    bi = b(:,i);
    ri = r(:,i);
    
    dB = dB + ai .* bi * ri';
    dz = dz + ai .* cross(bi, ri);
    dSigma = dSigma + ai * bi' * ri;
end
dS = dB + dB';

dK = [dS - dSigma * eye(3), dz; dz', dSigma];

end
