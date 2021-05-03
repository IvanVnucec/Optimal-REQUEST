function [B, S, z, Sigma] = get_util_matrices(K)
%GET_UTIL_MATRICES Summary of this function goes here
%   Detailed explanation goes here

Sigma = K(4,4);
S = K(1:3,1:3) + Sigma * eye(3);
B = S/2; % TODO: Calculate B. This is not the correct way.
z = K(1:3,4);

end
