% CODEGEN_SCRIPT_C   Generate static library get_quat_from_K from
%  get_quat_from_K, optimal_request, optimal_request_init.
% 
% Script generated from project 'codegen.prj' on 09-Jul-2021.
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
cfg.IndentSize = 4;

%% Define argument types for entry-point 'get_quat_from_K'.
ARGS = cell(3,1);
ARGS{1} = cell(1,1);
ARGS{1}{1} = coder.typeof(single(0),[4 4]);

%% Define argument types for entry-point 'optimal_request'.
ARGS{2} = cell(1,1);
ARGS_2_1 = struct;
ARGS_2_1.w = coder.typeof(single(0),[3 1]);
ARGS_2_1.r = coder.typeof(single(0),[3 2]);
ARGS_2_1.b = coder.typeof(single(0),[3 2]);
ARGS_2_1.Mu_noise_var = coder.typeof(single(0));
ARGS_2_1.Eta_noise_var = coder.typeof(single(0));
ARGS_2_1.dT = coder.typeof(single(0));
ARGS_2_1.K = coder.typeof(single(0),[4 4]);
ARGS_2_1.P = coder.typeof(single(0),[4 4]);
ARGS_2_1.mk = coder.typeof(single(0));
ARGS_2_1.Rho = coder.typeof(single(0));
ARGS{2}{1} = coder.typeof(ARGS_2_1);

%% Define argument types for entry-point 'optimal_request_init'.
ARGS{3} = cell(1,1);
ARGS_3_1 = struct;
ARGS_3_1.w = coder.typeof(single(0),[3 1]);
ARGS_3_1.r = coder.typeof(single(0),[3 2]);
ARGS_3_1.b = coder.typeof(single(0),[3 2]);
ARGS_3_1.Mu_noise_var = coder.typeof(single(0));
ARGS_3_1.Eta_noise_var = coder.typeof(single(0));
ARGS_3_1.dT = coder.typeof(single(0));
ARGS_3_1.K = coder.typeof(single(0),[4 4]);
ARGS_3_1.P = coder.typeof(single(0),[4 4]);
ARGS_3_1.mk = coder.typeof(single(0));
ARGS_3_1.Rho = coder.typeof(single(0));
ARGS{3}{1} = coder.typeof(ARGS_3_1);

%% Invoke MATLAB Coder.
codegen -config cfg -singleC get_quat_from_K -args ARGS{1} -nargout 1 optimal_request -args ARGS{2} -nargout 1 optimal_request_init -args ARGS{3} -nargout 1

