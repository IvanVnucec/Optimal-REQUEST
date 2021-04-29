function [R] = calculate_R(r, b, var)
%CALCULATE_Q Summary of this function goes here
%   Detailed explanation goes here
% see NOVEL METHODSFORATTITUDE DETERMINATIONUSING VECTOR OBSERVATIONSDaniel Choukroun
% Appendix B

rx = [0, -r(3), r(2); r(3), 0, -r(1); -r(2), r(1), 0];

R11 = var * ((3.0 - (r' * b)^2) * eye(3) + (b' * r) * (b * r' + r * b') ...
    + rx * (b * b') * rx');
R12 = zeros(3, 1);
R21 = R12';
R22 = 2.0 * var;

R = [R11, R12; R21, R22];
end

