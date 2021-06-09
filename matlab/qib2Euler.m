function [euler] = qib2Euler(qib)

psi = atan2(2*(qib(2)*qib(3)+qib(1)*qib(4)), qib(1)^2+qib(2)^2-qib(3)^2-qib(4)^2);
theta = asin(-2*(qib(2)*qib(4)-qib(1)*qib(3)));
phi = atan2(2*(qib(3)*qib(4)+qib(1)*qib(2)), qib(1)^2-qib(2)^2-qib(3)^2+qib(4)^2);

euler = [psi, theta, phi]';
end

