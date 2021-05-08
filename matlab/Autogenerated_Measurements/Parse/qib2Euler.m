function [psi, theta, phi] = qib2Euler(qib)

psi = atan2(2*(qib(2)*qib(3)+qib(1)*qib(4)), qib(1)^2+qib(2)^2-qib(3)^2-qib(4)^2);
theta = asin(-2*(qib(2)*qib(4)-qib(1)*qib(3)));
phi = atan2(2*(qib(3)*qib(4)+qib(1)*qib(2)), qib(1)^2-qib(2)^2-qib(3)^2+qib(4)^2);

psi = rad2deg(psi);
theta = rad2deg(theta);
phi = rad2deg(phi);
end

