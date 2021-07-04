% This script was used to calculate Kappa parameter defined as Kappa = trace(adjoint(S))
% The problem is that the GNU Octave in which we are testing Matlab functions doesn't have
% that function implemented so we are implementing by ourselves.
% 
%   ===== References ======
%   - Three-Axis Attitude Determination from Vector Observations,
%     M. D. Shuster* and S.D.  OhtComputer Sciences Corporation,  
%     Silver Spring,  Md.
%     J. GUIDANCE  AND CONTROL
%
% Author:     Ivan Vnucec
% University: FER, Zagreb
% Date:       Jul, 2021
% License:    MIT

clear all
clc

S = sym('s', [3, 3], 'real')
Kappa = trace(adjoint(S))