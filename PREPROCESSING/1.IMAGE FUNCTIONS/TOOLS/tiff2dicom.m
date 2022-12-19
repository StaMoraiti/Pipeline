clear all
mouse=1;
week=18;
folderpath=strcat(sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\');
rootpath=' G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\DATA\ORIGINAL IMAGES\ML\ESB22_DATA\S6\';
subpath1='Z TRANSLATED';
rootpath1='C:\3.SHIRT\MAIN\ShIRTM\Data\Matina\Fixed_images\';
%C:\3.SHIRT\MAIN\ShIRTM\Data\Matina\Fixed_images\ML1\ML1W18\2.5voxelsGREY\RightSizeMoved\withLinterp
%subpath1='2.5voxelsGREY\Blank\Movedxy\dicom\';
subpath2='2.5voxelsGREY\RightSizeMoved\withLinterp';


% key_param.rootpath='F:\PhD\WORK\2nd_year\μCT2μFE pipeline\DATA\ML5\ML5W18\S6\';
% key_param.subpath1='SEGMENTED_NOholes_trab\test';
% key_param.subpath2='GREYSCALE\';


dir_codes=pwd;
%cd(strcat(key_param.rootpath,key_param.folderpath,key_param.subpath2));
cd(strcat(rootpath,folderpath,subpath1))
dicomFields=dir('*.dcm');    % lists fields in the DICOM path
dcmfileNames = {dicomFields.name}'; % extract the name of the files
nSlice = numel(dcmfileNames);    % actual number of slices


for iSlice = 1:nSlice
    dicominfoVolume{iSlice} = dicominfo(dcmfileNames{iSlice}); 
end



cd(strcat(rootpath1,folderpath,subpath2))

tifFields=dir('*.tif');    % lists fields in the DICOM path
fileNames = {tifFields.name}'; % extract the name of the files
nSlice = numel(fileNames);    % actual number of slices


cd(dir_codes)
%mother_dir=strcat(key_param.rootpath,key_param.folderpath,key_param.subpath1);
mother_dir=strcat(rootpath1,folderpath,subpath2);

newSubPath='\dicom';
newPath=strcat(mother_dir,newSubPath);
newdir(newPath,mother_dir);
cd(mother_dir)
for iSlice=1:nSlice
    cd(mother_dir)
    tifim=imread(fileNames{iSlice});
    cd(newPath)
    dicomim=dicomwrite(tifim,dcmfileNames{iSlice},dicominfoVolume{iSlice});
end


