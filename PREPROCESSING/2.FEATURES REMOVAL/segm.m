
%% This function reads the dicom images and it creates the binary bone mask
%
% _
% Key parameteres_
key_param.mouse=4;
key_param.week=24;
key_param.folderpath=strcat(sprintf('ML%d',key_param.mouse),'\',sprintf('ML%dW%d',key_param.mouse,key_param.week),'\');
key_param.rootpath='F:\PhD\WORK\2nd_year\PCA_PIPELINE\DATA\ML\ESB22_DATA\S6\';
key_param.subpath='Z TRANSLATED\FILLED HOLES_TEST';
key_param.dir_codes=pwd;
%% Reading in the DICOM images
%

cd(strcat(key_param.rootpath,key_param.folderpath,key_param.subpath))
dicomFields=dir('*.dcm');    % lists fields in the DICOM path
fileNames = {dicomFields.name}'; % extract the name of the files
nSlice = numel(fileNames);    % actual number of slices
I = dicomread(fileNames{1});     % First DICOM image is in the 3rd file
Iinfo=dicominfo(fileNames{1});


% Initialise 3D matrix of images as int16 to be same as I
arrGreyStack =zeros([size(I) nSlice],class(I)); 
arrGreyStack(:,:,1) = I;         % Add image read to matrix
 
% Create image sequence array
for iSlice = 2:nSlice
    arrGreyStack(:,:,iSlice) = dicomread(fileNames{iSlice}); 
    dicominfoVolume{iSlice}  = dicominfo(fileNames{iSlice});

end

arrGreyStack=double(arrGreyStack); % convert to double for matrix operation

cd(key_param.dir_codes);

%% Segmentation
%
[dblGreyThreshold, dblPVE] = segm_th2(arrGreyStack(:));

arrBoneMask = arrGreyStack > dblGreyThreshold; 
arrBoneMask=double(arrBoneMask);

%% Denoising
arrBoneMask=denoise_m(arrBoneMask,key_param);

cd(key_param.dir_codes);
figure();sliceViewer(arrBoneMask)
%% Writing the segmented DICOM images
%
meta_Iinfo=Iinfo;

%Create a new directory

mother_dir=strcat(key_param.rootpath,key_param.folderpath,key_param.subpath);
newSubPath='\SEGMENTED_TEST';
newPath=strcat(mother_dir,newSubPath);
newdir(newPath,mother_dir);
cd(newPath)
for i=1:size(arrBoneMask,3)
    dicomwrite(arrBoneMask(:,:,i),fileNames{i},dicominfoVolume{i})
end

SEGM=dicomreadVolume(strcat(key_param.rootpath,key_param.folderpath,key_param.subpath,'\SEGMENTED_TEST'));
figure();sliceViewer(squeeze(SEGM))



