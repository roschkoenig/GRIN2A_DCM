% Not working

% Housekeeping
%--------------------------------------------------------------------------
clear all
Fbase     	= 'X:\Clinical Epilepsy Data\GRIN2A_EEGs\';
Fanalysis  	= [Fbase 'Matlab Files\'];
Fdcm        = [Fbase 'DCM\'];

File      	= {[Fdcm 'dcm_spont.mat'], [Fdcm 'dcm_seiz.mat']};
cond        = {['spont'], ['seiz']};


for f = 1:length(File)
    load(File{f});
    DCMs{f} = DCM;
end

%%
    
M.hE  = 0;
M.hC  = 1/16;
M.bE  =      spm_vec(DCMs{1}.M.pE);
M.bC  = diag(spm_vec(DCMs{1}.M.pC));

%  Define model space in terms of parameters allowed to vary
%--------------------------------------------------------------------------
field = {'T(1)','T(2)','T(3)','G(1)','G(2)','G(3)'};
beta  = 32;

for i = 1:length(field)
    
    % restrict between trial precision (beta)
    %----------------------------------------------------------------------
    j         = spm_find_pC(DCMs{1},field{i});
    M.pC      = M.bC/beta;
    M.pC(j,j) = M.bC(j,j);
    
    % invert and record free energy
    %----------------------------------------------------------------------
    PEB    = spm_dcm_peb(DCMs,M,'none');
    F(i,1) = PEB.F;
    
end