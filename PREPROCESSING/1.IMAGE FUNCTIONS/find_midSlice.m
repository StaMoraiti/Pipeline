function [store_filename]=find_midSlice(key_param,rootpath,folderpath)

%% This function finds the midslice of the S6 section of the mouse tibia
% Key parameteres_
mouse=key_param.mouse;
week=key_param.week;


newSubPath=key_param.newSubPath;

dir_codes=key_param.dir_codes;

%% Reading in the DICOM images
% 
cd(strcat(rootpath,folderpath))
dicomFields=dir('*.dcm');    % lists fields in the DICOM path
fileNames = {dicomFields.name}'; % extract the name of the files
nSlice = numel(fileNames);    % actual number of slices

%% Finding the middle slice and save the info in the "midSlice" structure 
%% and in a file
% 
midSlice.mouse=mouse;
midSlice.week=week;
midSlice.All_images=dicomFields;
midSlice.mid_ind=ceil(nSlice/2);% NO BLANK IMAGES ABOVE AND BELOW
midSlice.fileName=fileNames{midSlice.mid_ind};
midSlice.ImagePositionZ=dicominfo(midSlice.fileName).ImagePositionPatient(3);


cd(strcat(dir_codes,'\OUTPUTS',newSubPath))
store_filename=strcat(sprintf('ML%dW%d',mouse,week),'_MIDSLICE');
save(store_filename,'midSlice')

cd(dir_codes)
