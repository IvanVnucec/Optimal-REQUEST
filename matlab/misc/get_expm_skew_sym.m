% This script was used to get the method for simplifying matrix exponential
% of 4x4 skew-symetric matrix. 
% The conventional method for computing the matrix exponential is to use
% MATLAB formula expm(). But as we calculate the matrix exponential of
% a 4x4 skew-symetric matrix in optimal_request.m file there exist
% simplification in paper below.
% 
% The methods in this script are devised from the: 
% EXPONENTIALS OF REAL SKEW-SYMMETRIC MATRICES  IN TERMS OF THEIR EIGENVALUES 
% see the heading Case 4.4.1
% by Diego Gerardo Andree Avalos Galvez , 2018
% 
% For complete understanding user is advise to look into optimal_request.m
% file.
%
% Author:     Ivan Vnucec
% University: FER, Zagreb
% Date:       May, 2021
% License:    MIT

clear all
clc

dT = sym('dT', 'positive')   % time step
w  = sym('w', [3, 1], 'real') % angular velocity vector

wx = [0, -w(3), w(2); w(3), 0, -w(1); -w(2), w(1), 0]
Omega = 1.0 / 2 * [-wx, w; -w', 0]

S = Omega * dT % this is the matrix that we need to exponiate

% old way: Phi = expm(C)
% new way:
coeff = charpoly(S)
a = coeff(3)
theta = sqrt(a/2);
theta = simplify(theta);
fprintf('Theta = \n');
pretty(theta)

%                       2     2     2
%             dT sqrt(w1  + w2  + w3 )
% theta =     ------------------------
%                         2
%
% |w| = sqrt(w1^2 + w2^2 + w3^2)
%
%
% theta = dT * |w| / 2

% if we have 4x4 skew-symetrix matrix denoted S and S has two distinct
% nonzero eigenvalues +-Theta*i with Theta>0 each of multiplicity two then
% the matrix exponential of S is written:
%
% exp(S) = cos(theta) * eye(4) + sin(theta) / theta * S
%
% where theta was devised above with symbolic math toolbox.














            
