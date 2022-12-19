%% THIS FUNCTION IS THE SOURCE CODE TO BE EXECUTED FOR APPLYING DEFORMABLE REGISTRATION
%The images are 3D
%Fixed: is the target image
%Moved: is the image to be registered
%ALgorithm: ShIRT

%  Order of operation:
%
%1) Loading the dimom images, fixed and moved
%
%2) Creating one 3D dicom file, fixed and moved
%
%3) Applying ShIRT
%-------------------------------------------------

function mouseTibia_Reg(mouse,week)
%-------------------------------------------------
%-KEY PARAMETERES
rootpath = 'F:\PhD\WORK\2nd_year\PCA_PIPELINE\DATA\SHIRT\';
pathdata = 'Data\Matina\';
% mouse = 1;
% week=18;
pathIMAGES_F = strcat('Fixed_images\',sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\');
pathIMAGES_M = 'Moved_images\';
pathdataF = strcat('Fixed_3Ddicom\',sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\');
pathdataM = 'Moved_3Ddicom\';
pathdataMask = strcat('Mask_3Ddicom\',sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\');
pathres = strcat('Results\',sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\milimeters');

dir_codes=pwd;
%% 1)  Loading the dimom images, fixed and moved

F_ims = dicomreadVolume(strcat(rootpath,pathdata,pathIMAGES_F));F_ims=squeeze(F_ims);
M_ims = dicomreadVolume(strcat(rootpath,pathdata,pathIMAGES_M));M_ims=squeeze(M_ims);

%% 2) Creating one 3D dicom file, fixed, moved and mask
Mask_ims = F_ims;

cd(strcat(rootpath,pathdata,pathIMAGES_F));
dicomFields = dir;    % lists fields in the DICOM path
fileNames = {dicomFields.name}';
Iinfo = dicominfo(fileNames{5});
meta_F = Iinfo; % Initialize the dicom information of the new image files

meta_Mask = Iinfo;

cd(strcat(rootpath,pathdata,pathIMAGES_M));
dicomFields = dir;    % lists fields in the DICOM path
fileNames = {dicomFields.name}';
Iinfo=dicominfo(fileNames{5});
meta_M = Iinfo; % Initialize the dicom information of the new image files

dicomwrite(reshape(F_ims,[size(F_ims,1), size(F_ims,2), 1, size(F_ims,3)]), strcat(rootpath,pathdata,pathdataF, 'Im_Fixed'), meta_F, 'CreateMode', 'Copy', 'MultiframeSingleFile', 'true');
dicomwrite(reshape(M_ims,[size(M_ims,1), size(M_ims,2), 1, size(M_ims,3)]), strcat(rootpath,pathdata,pathdataM, 'Im_Moved'), meta_M, 'CreateMode', 'Copy', 'MultiframeSingleFile', 'true');
dicomwrite(reshape(Mask_ims,[size(Mask_ims,1), size(Mask_ims,2), 1, size(Mask_ims,3)]), strcat(rootpath,pathdata,pathdataMask, 'Im_Mask'), meta_Mask, 'CreateMode', 'Copy', 'MultiframeSingleFile', 'true');

%% Outlining registration parameters
NS = [10];%
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


