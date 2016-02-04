 
% Housekeeping
%--------------------------------------------------------------------------
clear all
Fbase     	= 'X:\Clinical Epilepsy Data\GRIN2A_EEGs\';
Fanalysis  	= [Fbase 'Matlab Files\'];
File      	= [Fanalysis 'MffJS_telemetry.mat'];
cond{1}     = 'JS_spont';
cond{2}     = 'JS_seiz';

spm('defaults', 'EEG');

for c = 1:length(cond)
clear DCM M

% specify model
%==========================================================================
% Data filename
%--------------------------------------------------------------------------
rG  = [-0.5,0.5];                         	% range of parameter
Nc  = 1;                                    % number of channels
Ns  = 1;                                    % number of sources

DCM.xY.Dfile            = File;

DCM.options.spatial     = 'LFP';
DCM.options.model       = 'CMC';
DCM.options.analysis    = 'CSD';
DCM.options.Nmodes      = 8;
DCM.options.Fdcm        = [1 40];
DCM.options.Tdcm        = [0 100000]; 
DCM.options.DATA        = 0;

M.dipfit.model          = DCM.options.model;
M.dipfit.type           = DCM.options.spatial;
M.dipfit.Nc             = Nc;
M.dipfit.Ns             = Ns;
M.dipfit.Nm             = 8;
M.dipfit.silent_source  = {};
M.Hz                    = 1:40;

DCM.M            = M;
DCM              = spm_dcm_csd_data(DCM);

% Location priors for dipoles
%--------------------------------------------------------------------------
Nareas    = 1

DCM.A{1} = zeros(Nareas, Nareas);   % forward connections
DCM.A{2} = zeros(Nareas,Nareas);    % backward connections
DCM.A{3} = ones(Nareas,Nareas);     % modulatory connections
DCM.B    = {};
DCM.C    = 1;

DCM.options.trials  = [c]
DCM.name            = cond{c};
DCM                 = spm_dcm_csd(DCM);

end

