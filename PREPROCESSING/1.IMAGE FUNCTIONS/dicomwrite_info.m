key_param.mouse=6;
key_param.week=24;
key_param.folderpath=strcat(sprintf('ML%d',key_param.mouse),'\',sprintf('ML%dW%d',key_param.mouse,key_param.week),'\');
key_param.rootpath='E:\PhD\WORK\2nd year\Data\VEE\ML\ESB22_DATA\S6\';
key_param.subpath1='Z TRANSLATED\FILLED HOLES';
key_param.subpath2='Z TRANSLATED\FILLED HOLES\SEGMENTED';

key_param.dir_codes=pwd;
cd(strcat(key_param.rootpath,key_param.folderpath,key_param.subpath1));
dicomFields=dir('*.dcm');    % lists fields in the DICOM path
dcmfileNames = {dicomFields.name}'; % extract the name of the files
nSlice = numel(dcmfileNames);    % actual number of slices 

for iSlice = 1:nSlice
    dicominfoVolume{iSlice} = dicominfo(dcmfileNames{iSlice}); 
end


cd(strcat(key_param.rootpath,key_param.folderpath,key_param.subpath2))
dicomFields=dir('*.dcm');    % lists fields in the DICOM path
fileNames = {dicomFields.name}'; % extract the name of the files
nSlice = numel(fileNames);    % actual number of slices



mother_dir=strcat(key_param.rootpath,key_param.folderpath,key_param.subpath2);
newPath=strcat(key_param.rootpath,key_param.folderpath,key_param.subpath2);
for iSlice=1:nSlice
    cd(mother_dir)
    im=dicomread(fileNames{iSlice});
    cd(newPath)
    dicomwrite(im,dcmfileNames{iSlice},dicominfoVolume{iSlice});
end


