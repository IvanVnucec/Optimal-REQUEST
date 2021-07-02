function [q] = get_quat_from_K(K)
%GET_QUAT_FROM_K Function returns the eigenvector of the matrix 'K' with the 
%   largest eigenvalue. 
%   The returned vector is quaternion rotation.
%
%   Ref. B states:
%   The optimal quaternionË†qk+1/k+1is the eigenvector ofKk+1/k+1,which belongs to its maximal eigenvalue.
%
% Author:     Ivan Vnucec
% University: FER, Zagreb
% Date:       May, 2021
% License:    MIT

% get eigenvector
[V, D] = eig(K);

% sort eigenvectors by eigenvalues
[~, ind] = sort(diag(D));
Vs = V(:,ind);

% pick the one with the largest eigenvalue which is at the end
q = Vs(:,end);

% Ref. B eq. 3 (text under), we are using different quaternion representation
q = [q(4); q(1:3)];

end
