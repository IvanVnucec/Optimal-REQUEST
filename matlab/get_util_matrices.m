function [B, S, z, Sigma] = get_util_matrices(r, b, weight)
%GET_UTIL_MATRICES Summary of this function goes here
%   Detailed explanation goes here

B = weight * b * r';
S = B + B';
z = weight * cross(b, r);
Sigma = trace(B);
end
