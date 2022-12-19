%% Nodal Spacing Sensitivity Analysis
% This function peforms a sensitivity analysis to optimize the Nodal
% spacing option.
% Mouse and week parameters define the target images.
% In this analysis,the images of the ML4W18 specimen are virtually translated 
% in each direction using the Amira software. the added displacement is
% equal to 2 voxels in one case and 4 voxels in the other. The baseline is
% the original images which are the ones that will be elastically
% registered to the translated images.
mouse=4;
week=18;
dl=4;% 2 voxels displacement
mouseTibia_Reg_NSensitivity(mouse,week, dl)
            
      