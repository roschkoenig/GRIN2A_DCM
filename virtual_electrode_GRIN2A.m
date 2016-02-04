%% Virtual Electrode for GRIN2A seizure data
%==========================================================================
% This routine loads a MEEG file containing EEG data for different
% conditions (seizure, awake) and from this calculates a single LFP-like as
% estimated for the location of the maximum beamformer source
% reconstruction (which needs to have been done separately before)
% (c) Richard Rosch 2016, adapted from Gerald Cooray

% Housekeeping
%--------------------------------------------------------------------------
clear all
Fbase       = 'X:\Clinical Epilepsy Data\GRIN2A_EEGs\';
Fanalysis   = [Fbase 'Matlab Files\'];
File        = {[Fanalysis 'ffjs_spont.mat'], [Fanalysis 'ffjs_seiz.mat']};
Beam_max    = [16.6 -99.1 -0.7];

for f = 1:length(File)
    load(File{f})

    S.D             = File{f};
    S.dipoles.pnt   = [16.6 -99.1 -0.7];
    S.dipoles.ori   = [-1 1 0];
    S.dipoles.label = 'Occ';

    sD              = spm_eeg_dipole_waveforms_rr(S);
end