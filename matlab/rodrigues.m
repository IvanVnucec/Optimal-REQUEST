function [vrot] = rodrigues(v, k, Theta)
%RODRIGUES Summary of this function goes here
%   Detailed explanation goes here

k = k / norm(k);

[~, ncols] = size(v);

vrot = zeros(size(v));

for i = 1 : ncols
    vrot(:,i) = v(:,i) * cos(Theta) + cross(k, v(:,i)) * sin(Theta) + ...
        k * dot(k, v(:,i)) * (1.0 - cos(Theta));
end
end

