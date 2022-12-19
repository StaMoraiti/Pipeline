%% THIS FUNCTION BINARIZE AND PROCESS THE 3D IMAGE SET
% THE PROCESSING INCLUDES DILATION/EROSION TO FILL THE CORTICAL PORES
clear all;
key_param.mouse=1;
key_param.week=18;

key_param.Specspath=strcat(sprintf('ML%d',key_param.mouse),'\',sprintf('ML%dW%d',key_param.mouse,key_param.week),'\');
key_param.rootpath='C:\3.SHIRT\MAIN\ShIRTM\Data\Matina\Fixed_images\';
key_param.subpath='2.5voxelsGREY\Moved\withInterp\';
%C:\3.SHIRT\MAIN\ShIRTM\Data\Matina\Fixed_images\ML1\ML1W18\2.5voxelsGREY\RightSizeMoved\withLinterp\dicom
key_param.dir_codes=pwd;
cd(strcat(key_param.rootpath,key_param.Specspath,key_param.subpath));
dicomFields=dir('*.dcm');    % lists fields in the DICOM path
fileNames = {dicomFields.name}'; % extract the name of the files
nSlice = numel(fileNames);    % actual number of slices

I = dicomread(fileNames{1});     % First DICOM image is in the 3rd file
Iinfo=dicominfo(fileNames{1});


% Initialise 3D matrix of images as int16 to be same as I
arrGreyStack =zeros([size(I) nSlice],class(I)); 

for iSlice = 1:nSlice
    arrGreyStack(:,:,iSlice) = dicomread(fileNames{iSlice}); 
    dicominfoVolume{iSlice}  = dicominfo(fileNames{iSlice});
end


cd(strcat(key_param.dir_codes,'\TOOLS'));

%% Segmentation
[dblGreyThreshold, dblPVE] = segm_th2(arrGreyStack(:));

arrBoneMask = arrGreyStack > dblGreyThreshold; 
arrBoneMask=double(arrBoneMask);

cd(key_param.dir_codes)

%% Denoising
arrBoneMask=denoise_m(arrBoneMask,key_param);
figure();sliceViewer(arrBoneMask);title('Binarized')
figure();sliceViewer(arrGreyStack);title('Original')


%% Filling holes
for i=1:nSlice
    im=arrGreyStack(:,:,i);
    Bi=arrBoneMask(:,:,i);
    if ~isempty(find(ne(im,0)))
       B=bwboundaries(Bi);
       sz_i=[];
       for j=1:size(B,1)
          sz=size(B{j},1);
          sz_i=[sz_i;sz];
          [a,ind]=sort(sz_i(:,1),'descend');        
       end
       if size(B,1)>=3 
        
         disp(strcat('the slice ', num2str(i),'has porous'));
% %       ML6W24        
%       if i>=134 && size(B,1)>=3 && size(B{ind(3)},1)>=30 
%          ymin=min(B{ind(4)}(:,2)); ymax=max(B{ind(4)}(:,2));
%          xmin=min(B{ind(4)}(:,1)); xmax=max(B{ind(4)}(:,1));
%       else
         f=a(3:end)>60;
         if ~isempty(find(f,1))
             f=a>60;
             in=find(f==0,1);
             if isempty(in)
                 im_noholes(:,:,i)=Bi;
                 continue;
             end
         else 
           in=3; 
         end
         ymin=min(B{ind(in)}(:,2)); ymax=max(B{ind(in)}(:,2));
         xmin=min(B{ind(in)}(:,1)); xmax=max(B{ind(in)}(:,1));
       
         yhole_axis=ymax-ymin;
         xhole_axis=xmax-xmin;
         strel_axis=max([yhole_axis, xhole_axis]);
         se=strel('disk',round(strel_axis/2),0);
      
         im_dil=imdilate(Bi,se);
         Bi=imerode(im_dil,se);
         
      end 
    end
    
    im_noholes(:,:,i)=Bi;
end
%figure();sliceViewer(im_noholes);title(strcat('No holes: Slice',num2str(i)))
% ind=[129:135];
% for i=1:size(ind,2)
%    im=arrBoneMask(:,:,ind(i));
%    se=strel('disk',round(2),0); 
%    
%    im_dil=imdilate(im,se);
%    im=imerode(im_dil,se);
%    im_noholes(:,:,ind(i))=im; 
% end
% for i=100:111
%    im=arrGreyStack(:,:,i);
%    se=strel('disk',round(3),0); 
%    im_dil=imdilate(im,se);
%    im=imerode(im_dil,se);
%    im_noholes(:,:,i)=im;
% end

%% Writing the no hole-images DICOM images

%Create a new directory
cd('..\..\TOOLS')
mother_dir= strcat(key_param.rootpath,key_param.Specspath,key_param.subpath);

newSubPath='\FilledHoles';
newPath=strcat(mother_dir,newSubPath);
newdir(newPath,mother_dir);
cd(newPath)
for i=1:size(im_noholes,3)
    dicomwrite(im_noholes(:,:,i),fileNames{i},dicominfoVolume{i}) 
end

FILLED=dicomreadVolume(newPath);
figure();sliceViewer(squeeze(FILLED));title('Binarized Filled')
