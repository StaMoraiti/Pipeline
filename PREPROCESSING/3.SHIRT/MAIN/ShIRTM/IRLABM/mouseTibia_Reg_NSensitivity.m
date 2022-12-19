function mouseTibia_Reg_NSensitivity(mouse,week,dl)
%-------------------------------------------------
%-KEY PARAMETERES
% G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\LIMITATIONS\NODAL SPACING\DISPLACEMENT SENSITIVITY\DATA_VIRTtranslated\ML4W18\2voxels
rootpath = 'G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\PREPROCESSING\3.SHIRT\MAIN\ShIRTM\';
pathdata = 'Data\Matina\';

pathIMAGES_F = strcat('Fixed_images\',sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\',sprintf('%d',dl),'voxels\');
pathIMAGES_M = 'Moved_images\';
pathdataF = strcat('Fixed_3Ddicom\',sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\',sprintf('%d',dl),'voxels\');
pathdataM = 'Moved_3Ddicom\';
pathdataMask = strcat('Mask_3Ddicom\',sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\',sprintf('%d',dl),'voxels\');
pathres = strcat('Results\',sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\milimeters');

dir_codes=pwd;
%% 1)  Loading the dimom images, fixed and moved

F_ims = dicomreadVolume(strcat(rootpath,pathdata,pathIMAGES_F));F_ims=squeeze(F_ims);
M_ims = dicomreadVolume(strcat(rootpath,pathdata,pathIMAGES_M));M_ims=squeeze(M_ims);


%% 2) Creating one 3D dicom file, fixed, moved and mask
Mask_ims = F_ims;

cd(strcat(rootpath,pathdata,pathIMAGES_F));
dicomFields = dir('*.dcm');    % lists fields in the DICOM path
fileNames = {dicomFields.name}';
Iinfo = dicominfo(fileNames{1});
meta_F = Iinfo; % Initialize the dicom information of the new image files
meta_F.MediaStorageSOPClassUID=meta_F.SOPClassUID;
meta_Mask = meta_F;

cd(strcat(rootpath,pathdata,pathIMAGES_M));
dicomFields = dir('*.dcm');    % lists fields in the DICOM path
fileNames = {dicomFields.name}';
Iinfo=dicominfo(fileNames{1});
meta_M = Iinfo; % Initialize the dicom information of the new image files

dicomwrite(reshape(F_ims,[size(F_ims,1), size(F_ims,2), 1, size(F_ims,3)]), strcat(rootpath,pathdata,pathdataF, 'Im_Fixed'), meta_F, 'CreateMode', 'Copy', 'MultiframeSingleFile', 'true');
dicomwrite(reshape(M_ims,[size(M_ims,1), size(M_ims,2), 1, size(M_ims,3)]), strcat(rootpath,pathdata,pathdataM, 'Im_Moved'), meta_M, 'CreateMode', 'Copy', 'MultiframeSingleFile', 'true');
dicomwrite(reshape(Mask_ims,[size(Mask_ims,1), size(Mask_ims,2), 1, size(Mask_ims,3)]), strcat(rootpath,pathdata,pathdataMask, 'Im_Mask'), meta_Mask, 'CreateMode', 'Copy', 'MultiframeSingleFile', 'true');

%% Outlining registration parameters
NS = [5];%
Lambdainput = 'n';
Iter   = 100;%100
vdim   = [0.0104, 0.0104, 0.0104];%milimeters %10.4, 10.4, 10.4micrometers
Thresh = -1;
pathdataM_input = strcat(rootpath,pathdata,pathdataM);
pathdataF_input = strcat(rootpath,pathdata,pathdataF);
pathdataMask_input = strcat(rootpath,pathdata,pathdataMask);
pathres_input = strcat(rootpath,pathres);
filefixed_input = 'Im_Fixed';
filemoved_input = 'Im_Moved';
filemask_input = 'Im_Mask';

%% Performing registration using regrun function

cd(dir_codes)

tic
for i=1:numel(NS)
    NSinput = NS(i);
    regrun_NS_Lambda(Iter, NSinput, Lambdainput, vdim, pathdataF_input, pathdataM_input,pathdataMask_input, pathres_input, filefixed_input, filemoved_input, filemask_input, Thresh,mouse,week)

end
toc