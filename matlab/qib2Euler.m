% =========================== Info ==============================
% About: Convert the quaternion into Euler angles.
%        Quaternion is defined as q = q(1) + q(2) * i + q(3) * j + q(4) * k
%
% Author:     Josip Loncar
% University: FER, Zagreb
% Date:       May, 2021
% License:    MIT

function [euler] = qib2Euler(q)
    psi = atan2(2 * (q(2) * q(3) + q(1) * q(4)), ...
        q(1)^2 + q(2)^2 - q(3)^2 - q(4)^2);
    
    theta = asin(2 * (q(1) * q(3) - q(2) * q(4)));
    
    phi = atan2(2 * (q(3) * q(4) + q(1) * q(2)), ...
        q(1)^2 - q(2)^2 - q(3)^2 + q(4)^2);

    euler = [psi, theta, phi]';
end
