function [B, S, z, Sigma] = get_util_matrices(r, b, a)
%GET_UTIL_MATRICES Summary of this function goes here
%   Detailed explanation goes here
[~, ncols] = size(r);

B = zeros(3, 3);
z = zeros(3, 1);
for k = 1 : ncols
    B = B + a(k) * b(:,k) * r(:,k)';
    z = z + a(k) * cross(b(:,k), r(:,k));
end

S = B + B';
Sigma = trace(B);

end
