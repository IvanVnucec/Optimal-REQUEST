% CODEGEN_SCRIPT_C   Generate static library optimal_request from
%  get_quat_from_K, optimal_request, optimal_request_init.
% 
% Script generated from project 'codegen.prj' on 08-Jul-2021.
% 
% See also CODER, CODER.CONFIG, CODER.TYPEOF, CODEGEN.

%% Add the utils directory to path
addpath('utils');

%% Create configuration object of class 'coder.EmbeddedCodeConfig'.
cfg = coder.config('lib','ecoder',true);
cfg.GenerateCodeMetricsReport = true;
cfg.GenerateCodeReplacementReport = true;
cfg.HighlightPotentialDataTypeIssues = true;
cfg.GenerateReport = true;
cfg.ReportPotentialDifferences = false;
cfg.EnableVariableSizing = false;
cfg.MATLABSourceComments = true;
cfg.GenCodeOnly = true;
cfg.Toolchain = 'GNU gcc/g++ | gmake (64-bit Linux)';
cfg.BuildConfiguration = 'Debug';
cfg.HardwareImplementation.ProdHWDeviceType = 'Generic->32-bit Embedded Processor';
cfg.HardwareImplementation.TargetHWDeviceType = 'Generic->32-bit Embedded Processor';

%% Define argument types for entry-point 'get_quat_from_K'.
ARGS = cell(3,1);
ARGS{1} = cell(1,1);
ARGS{1}{1} = coder.typeof(single(0),[4 4]);

%% Define argument types for entry-point 'optimal_request'.
ARGS{2} = cell(9,1);
ARGS{2}{1} = coder.typeof(single(0),[4 4]);
ARGS{2}{2} = coder.typeof(single(0),[4 4]);
ARGS{2}{3} = coder.typeof(single(0));
ARGS{2}{4} = coder.typeof(single(0),[3 1]);
ARGS{2}{5} = coder.typeof(single(0),[3 2]);
ARGS{2}{6} = coder.typeof(single(0),[3 2]);
ARGS{2}{7} = coder.typeof(single(0));
ARGS{2}{8} = coder.typeof(single(0));
ARGS{2}{9} = coder.typeof(single(0));

%% Define argument types for entry-point 'optimal_request_init'.
ARGS{3} = cell(3,1);
ARGS{3}{1} = coder.typeof(single(0),[3 2]);
ARGS{3}{2} = coder.typeof(single(0),[3 2]);
ARGS{3}{3} = coder.typeof(single(0));

%% Invoke MATLAB Coder.
codegen -config cfg -singleC -o optimal_request get_quat_from_K -args ARGS{1} -nargout 1 optimal_request -args ARGS{2} -nargout 4 optimal_request_init -args ARGS{3} -nargout 3

