function [q] = get_quat_from_K(K)
    % with MATLAB functions
    % get eigenvec
    [V, D] = eig(K);
    
    % sort eigenvectors by eigenvalues
    [~, ind] = sort(diag(D));
    Vs = V(:,ind);
    
    % pick the one with the largest eigenvalue
    q = Vs(:,end);
    return
    
    %{
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
    %}
    
end

