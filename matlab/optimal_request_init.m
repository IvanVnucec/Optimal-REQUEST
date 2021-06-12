function [K, P, mk] = optimal_request_init(r0, b0, Mu_noise_var)
%OPTIMAL_REQUEST_INIT Initialize the Optimal-REQUEST algorithm.
%   Using first measurements r0 and b0, function sets the initial K, P and 
%   mk values used in the first iteration of the algorithm. 
%
% Ref B: 
%   Optimal-REQUEST Algorithm for Attitude Determination,
%   D. Choukroun,I. Y. Bar-Itzhack, and Y. Oshman,
%   https://sci-hub.se/10.2514/1.10337
%
% Author: Ivan Vnucec, FER, Zagreb, 2021
% License: MIT

[~, ncols] = size(b0); 
a0 = ones(1, ncols) ./ ncols; % equal weights

dm0 = sum(a0); % Ref. A eq. 11a
dK0 = calculate_dK(r0, b0, a0);
R0 = calculate_R(r0, b0, Mu_noise_var);

K = dK0;    % Ref. B eq. 65
P = R0;     % Ref. B eq. 66
mk = dm0;   % Ref. B eq. 67, mk = m_k
end