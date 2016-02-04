%% DCM for GRIN2A Seizure Data
%==========================================================================
% This routine loads virtual electrode trace for spontaneous EEG and
% seizure data and fits a single DCM to each trace, saving them in a
% specified DCM folder

% Housekeeping
%--------------------------------------------------------------------------
clear all
Fbase     	= 'X:\Clinical Epilepsy Data\GRIN2A_EEGs\';
Fanalysis  	= [Fbase 'Matlab Files\'];
File      	= {[Fanalysis 'Mffjs_spont.mat'], [Fanalysis 'Mffjs_seiz.mat']};
Fdcm        = [Fbase 'DCM\'];
cond        = {['spont'], ['seiz']};

spm('defaults', 'EEG');

for f = 1:length(File)
clear DCM M

% Specify model
%==========================================================================
% Data filename
%--------------------------------------------------------------------------
rG  = [-0.5,0.5];                         	% range of parameter
Nc  = 1;                                    % number of channels
Ns  = 1;                                    % number of sources

DCM.xY.Dfile            = File{f};

DCM.options.spatial     = 'LFP';
DCM.options.model       = 'ERP';
DCM.options.analysis    = 'CSD';
DCM.options.Nmodes      = 8;
DCM.options.Fdcm        = [1 40];
DCM.options.Tdcm        = [0 100000]; 
DCM.options.DATA        = 0;
DCM.options.trials      = [1];

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
Nareas    = 1;

DCM.A{1} = zeros(Nareas, Nareas);   % forward connections
DCM.A{2} = zeros(Nareas,Nareas);    % backward connections
DCM.A{3} = ones(Nareas,Nareas);     % modulatory connections
DCM.B    = {};
DCM.C    = 1;

DCM.name            = [Fdcm 'dcm_' cond{f}];
DCM                 = spm_dcm_csd(DCM);

end

