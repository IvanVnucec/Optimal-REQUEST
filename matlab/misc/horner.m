% Compute Horner nested polynomial representation used in get_quat_from_K
% function to improve computation speed.
%
% Author:     Ivan Vnucec
% University: FER, Zagreb
% Date:       Jul, 2021
% License:    MIT

syms Lambda a b c d Sigma

f  = Lambda^4 - (a + b)*Lambda^2 - c*Lambda + (a*b + c*Sigma - d);
f_h = horner(f, Lambda)

df = 4*Lambda^3 - 2*(a + b)*Lambda - c;
df_h = horner(df, Lambda)

% Output: 
% f_h = Sigma*c - d + a*b - Lambda*(c + Lambda*(- Lambda^2 + a + b))
% df_h = - c - Lambda*(- 4*Lambda^2 + 2*a + 2*b)