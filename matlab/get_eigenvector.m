function [vk] = get_eigenvector(A, v0, iter)
%GET_EIGENVECTOR Iteratively compute eigenvector with a maximal eigenvalue.
%     Given a symetric matrix A, the function iteratively computes
%     eigenvector corresponding to the eigenvalue of largest magnitude.
    
    % use MATLAB functions
    [V, D] = eig(A);
    vk = V(1);  % TODO: return eigenvector with the largest eigenvalue
    return
    
    % if ||v0|| != 1 exit with failure
    EPS = 1e-6;
    if (abs(norm(v0) - 1.0)) > EPS
        error('Initial eigenvector magnitude is not 1.0')
    end
    
    vk = v0;
    
    for k = 1 : iter
        w = A * vk;
        vk = w / norm(w);
    end
    
end

