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
