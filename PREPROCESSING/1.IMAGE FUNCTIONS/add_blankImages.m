%% A code that adds blank images above and below THE REFERENCE image set 
% 
% order of operation:
%
%1) Loading the dicom images
%
%2) Creating the blank arrays
%
%3) Concatenate arrays along the z axis
DIR_CODES=pwd;
mouse=[2];week=18;
label0=[919];
res=0.0104;
for kk=1:length(mouse)
cd(DIR_CODES)
OriginalPath='G:\My Drive\PhD\WORK\2nd_year\Data\VEE\ML\ESB22_DATA\S6\';
SpecsPath=strcat(sprintf('ML%d',mouse(kk)),'\',sprintf('ML%dW%d',mouse(kk),week'),'\');



N=5; %Number of blank slices
%% Loading the dicom images
cd(strcat(OriginalPath,SpecsPath))
dicomFields=dir('*.dcm');    % lists fields in the DICOM path
fileNames = {dicomFields.name}';
W18_0=dicominfo(fileNames{1}); % the first slice
W18_Last=dicominfo(fileNames{end}); % the last one
W18_dicom=dicomreadVolume(strcat(OriginalPath,SpecsPath));
W18_dicom=squeeze(W18_dicom);


meta_W18=W18_0;% keep the info the same



%% CREATING BLANK IMAGES AND ALLOCATING THEM ABOVE AND BELOW THE ENDS
blankdata=zeros(size(W18_dicom,1),size(W18_dicom,2),N,'uint16'); % creates blank images in the same size as the image set
W18_metadicom=cat(3,blankdata,W18_dicom);% adds the blank images above
W18_metadicom=cat(3,W18_metadicom, blankdata);% final image array
for i=0:size(W18_metadicom,3)
    filename{i+1}=strcat('PTH_Loading.transformed',cell2mat(compose('%04d',i)));
end    
SliceZ_0=W18_0.ImagePositionPatient(3,1); % First slice
SliceZ_Last=W18_Last.ImagePositionPatient(3,1); %Last slice

mother_dir='C:\3.SHIRT\MAIN\ShIRTM\Data\Matina\Fixed_images\';
newSubPath='2.5voxelsGREY\Blank';
newPath=strcat(mother_dir,SpecsPath,newSubPath);
cd(strcat(DIR_CODES,'\TOOLS'))
newdir(newPath,mother_dir);




l=0;
for i=1:size(W18_metadicom,3)
 
    if i<=size(blankdata,3) % create the dicom blank images, i:(1-100)
        % define the z posistion (z_0-n*resolution)
        meta_W18.ImagePositionPatient(3,1)=SliceZ_0-(size(blankdata,3)-i+1)*W18_0.SpacingBetweenSlices;
            
    end
    
    if i>size(blankdata,3)&&i<=size(blankdata,3)+size(W18_dicom,3)
       % znew=zbone
       z0=W18_0.ImagePositionPatient(3,1);
       z_i1=z0+l*res;
       %z_i=dicominfo(strcat(strcat(OriginalPath,SpecsPath),'PTH_Loading.transformed',cell2mat(compose('%04d',i-size(blankdata,3)+label0(kk))))).ImagePositionPatient(3,1);
       meta_W18.ImagePositionPatient(3,1)=z_i1;
       l=l+1;    
    end
    
    
    if i>size(blankdata,3)+size(W18_dicom,3)
        % define the z position (z_last+n*resolution)
        meta_W18.ImagePositionPatient(3,1)=SliceZ_Last+(i-size(blankdata,3)-size(W18_dicom,3))*W18_0.SpacingBetweenSlices;
          
    end 
    
    
     sl(i)=meta_W18.ImagePositionPatient(3,1);
     meta_W18.Filename=strcat(newPath,'\',filename{i},'.dcm');
     dicomwrite(W18_metadicom(:,:,i),meta_W18.Filename,meta_W18)
        
    
end
end
    





