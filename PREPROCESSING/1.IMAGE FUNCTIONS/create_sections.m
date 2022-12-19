%% THIS FUCTION CREATES THE SECTIONS OF INTEREST BY EQUALLY DIVIDING THE WHOLE BONE LENGTH INTO 10 SUBSECTIONS
% THE INPUT IS THE 3D GREYSCALE IMAGE SET OF THE BONE WITHOUT ANY BLANK SPACE ABOVE
% AND BELOW THAT


clear all; clc;
mouse=3;week=18;
dir_codes=pwd;
rootpath='G:\My Drive\PhD\WORK\2nd_year\Data\VEE\OVX\';% PATH WHERE THE 3D IMAGE SET OF THE WHOLE BONE LENGTH IS STORED
path=strcat(sprintf('OVX%d',mouse),'\',sprintf('OVX%dW%d',mouse,week),'\');


cd(strcat(rootpath,path))
dicomFields=dir('*.dcm');
fileNames = {dicomFields.name}'; % extract the name of the files
NSlice = numel(fileNames);    % actual number of slices
M=10; %number of sections
%Ntot=size(listing,1); %total number of slices
Nsec=floor(NSlice/M);Nrem=mod(NSlice,M);% number of slices per section, remaining slices


% information about the first and last slice: name of the file and number
slices.first.name=fileNames{1}; 
slices.last.name=fileNames{end};

k=strfind(slices.first.name,'red_');
slices.first.number=slices.first.name(k+4:k+7);
k=strfind(slices.last.name,'red_');
slices.last.number=slices.last.name(k+4:k+7);
Slice0Label=str2num(slices.first.number); % NUMBER OF SLICES , NOT VERY ELLABORATE, NEEDS CHANGE

%create paths to save the images per section
mother_dir='G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\DATA\ORIGINAL IMAGES\OVX\';
newSubPath='Sections\';
newPath=strcat(mother_dir,path,newSubPath);

cd(strcat(dir_codes,'\TOOLS'))
newdir(newPath,mother_dir)


%copy the images in the folders
filename="OVX3W18_registered_";
for i=1:M
  newSubPath=strcat(newPath,'S',num2str(i));
  cd(strcat(dir_codes,'\TOOLS'))
  newdir(newSubPath,newPath)
  cd(newSubPath)
  if i==1
      Slice0Label=Slice0Label+1; % IN THIS LINE THE ACTUAL NUMBER OF SLICES ARE REDUSED AS THE REMAINING SLICES
      % I.E., Nrem= 5: 3 form the top and 2 from the bottom should be
      % disregarded. So Slice0Label=Slice0Label-2;
      
  end
   if i==M
      Nsec=Nsec
  end
  for j=Slice0Label:Slice0Label+Nsec-1
      ending=strcat(cell2mat(compose('%04d',j)),'.dcm');
      imagefile=strcat(rootpath,path,filename,ending);
      copyfile(imagefile, newSubPath);
      Slice0Label=j+1;
  end
end




