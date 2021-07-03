% =========================== Notes =============================
% Calculate one step of Optimal-REQUEST algorithm.
% 
% Almost all of the algorithm equations have references to some
% paper. The reference equations are written in the form for ex.
% Ref A eq. 25 where letter 'A' denotes reference to the paper
% and the number '25' the equation number it that paper. The 
% references are listed under Reference section below.
% 
% Indexes with k+1 are written without indexes and indexes with 
% k are written with _k. For example dm_k+1 is written as dm and
% dm_k is written as dmk.
%
% ========================= References ==========================
% Ref A: 
%   REQUEST: A Recursive QUEST Algorithmfor Sequential Attitude Determination
%   Itzhack Y. Bar-Itzhack, 
%   https://sci-hub.se/https://doi.org/10.2514/3.21742
%
% Ref B: 
%   Optimal-REQUEST Algorithm for Attitude Determination,
%   D. Choukroun,I. Y. Bar-Itzhack, and Y. Oshman,
%   https://sci-hub.se/10.2514/1.10337
%
% Ref. C: 
%   Appendix B, Novel Methods for Attitude Determination Using Vector Observations,
%   Daniel Choukroun,
%   Page 233
%   https://www.researchgate.net/profile/Daniel-Choukroun/publication/265455600_Novel_Methods_for_Attitude_Determination_Using_Vector_Observations/links/5509c02b0cf26198a639a83c/Novel-Methods-for-Attitude-Determination-Using-Vector-Observations.pdf#page=253
%
% Ref. D: 
%   Appendixes, Attitude Determination Using Vector Observations and
%   the Singular Value Decomposition
%   Markley, F. L.,
%   http://malcolmdshuster.com/FC_Markley_1988_J_SVD_JAS_MDSscan.pdf
%
% =========================== Licence ============================
% Author:     Ivan Vnucec
% University: FER, Zagreb
% Date:       May, 2021
% License:    MIT

function [K, P, mk, Rho] = optimal_request(K, P, mk, w, r, b, ...
    Mu_noise_var, Eta_noise_var, dT)

% Calculate one step of Optimal-REQUEST algorithm.

% =================== time update ===================

Phi = calculate_Phi(w, dT); 

[B, ~, z, Sigma] = get_util_matrices(K);
Q = calculate_Q(B, z, Sigma, Eta_noise_var, dT);

% Ref. B eq. 11
K = Phi * K * Phi';

% Ref. B eq. 69
P = Phi * P * Phi' + Q;

% ================ measurement update ===============
% calc. meas. weights
[~, ncols] = size(b); 
a = ones(1, ncols) ./ ncols; % equal weights 

dm = sum(a);

R = calculate_R(r, b, Mu_noise_var);

% Ref. B eq. 70
Rho = (mk^2 * trace(P)) / (mk^2 * trace(P) + dm^2 * trace(R));

% Ref. B eq. 71
m = (1.0 - Rho) * mk + Rho * dm;

dK = calculate_dK(r, b, a);

% Ref. B eq. 72
K = (1.0 - Rho) * mk / m * K + Rho * dm / m * dK;

% Ref. B eq. 73
P = ((1.0 - Rho) * mk / m)^2 * P + (Rho * dm / m)^2 * R;

% for the next iteration m_k = m_k+1
mk = m;

end


% ======================= Private functions =========================

function [B, S, z, Sigma] = get_util_matrices(K)
%GET_UTIL_MATRICES Returns submatrices 'B', 'S', 'z' and 'Sigma' of 'K' 
%   matrice.
%   The submatrices are used for the calculation of Q matrice.
%
%   Ref. B eq. 6 and 7, (for references list see main.m file under reference 
%   comment section).

Sigma = K(4,4);
S = K(1:3,1:3) + Sigma * eye(3);
B = 0.5 * S;
z = K(1:3,4);
end
