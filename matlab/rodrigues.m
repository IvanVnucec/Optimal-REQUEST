function [vrot] = rodrigues(v, k, Theta)
%RODRIGUES Rotate column vectors 'v' around column vector 'k' by 'Theta'
%degrees in radians.
%   With the so called Rodrigues formula this function rotates vectors.
%   Vector 'k' doesn't need to be normalized because it is being normalized 
%   in function.

k = k / norm(k);

[~, ncols] = size(v);

vrot = zeros(size(v));

for i = 1 : ncols
    vrot(:,i) = v(:,i) * cos(Theta) + cross(k, v(:,i)) * sin(Theta) + ...
        k * dot(k, v(:,i)) * (1.0 - cos(Theta));
end
end

