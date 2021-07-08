function [Phi] = calculate_Phi(w, dT)
%CALCULATE_PHI Calculate matrix Phi (see Ref B eq. 9) matrix used by the 
% Optimal-REQUEST algorithm in the time update step.
% 
% =========================== About =============================
% The conventional method for computing the matrix exponential is to use
% MATLAB formula expm(). But as we calculate the matrix exponential of
% a 4x4 skew-symetric matrix in optimal_request.m file there exist
% simplification in paper below.
% The mathematic identities written below are devised by using the
% script in the misc/get_expm_skew_sym.m. User is advised to look into it.
%
% ========================= References ==========================
% Ref B: 
%   Optimal-REQUEST Algorithm for Attitude Determination,
%   D. Choukroun,I. Y. Bar-Itzhack, and Y. Oshman,
%   https://sci-hub.se/10.2514/1.10337
%
% Matrix exponential: 
% EXPONENTIALS OF REAL SKEW-SYMMETRIC MATRICES  IN TERMS OF THEIR EIGENVALUES 
% by Diego Gerardo Andree Avalos Galvez , 2018
% see heading Case 4.4.1
%
% =========================== Licence ============================
% Author:     Ivan Vnucec
% University: FER, Zagreb
% Date:       Jul, 2021
% License:    MIT

% Ref. B eq. 4
wx = [0, -w(3), w(2); w(3), 0, -w(1); -w(2), w(1), 0];

% Ref. B eq. 10
Omega = 1.0 / 2 * [-wx, w; -w', 0];

% calculate Phi
% Ref B eq. 9 with speed improvment over expm() function
S = Omega * dT;
Theta = dT / 2.0 * vecnorm(w);
Phi = cos(Theta) * eye(4) + sin(Theta) / Theta * S;

end

