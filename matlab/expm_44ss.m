function [retval] = expm_44ss(S, w, dT)
%EXPM_44SS Calculate the matrix exponential of a 4x4 skew-symetric matrix 
% used by the Optimal-REQUEST algorithm in the time update step.
% 
% The conventional method for computing the matrix exponential is to use
% MATLAB formula expm(). But as we calculate the matrix exponential of
% a 4x4 skew-symetric matrix in optimal_request.m file there exist
% simplification in paper below.
% 
% The methods in this script are devised from the: 
% EXPONENTIALS OF REAL SKEW-SYMMETRIC MATRICES  IN TERMS OF THEIR EIGENVALUES 
% see the heading Case 4.4.1
% by Diego Gerardo Andre ́e Avalos G ́alvez , 2018
%
% Also, the mathematic identities written below are devised by using the
% script in the other/get_expm_skew_sym.m. User is advised to look into it.
%
% Author:     Ivan Vnucec
% University: FER, Zagreb
% Date:       Jul, 2021
% License:    MIT

Theta = dT / 2.0 * vecnorm(w);
retval = cos(Theta) * eye(4) + sin(Theta) / Theta * S;

end

