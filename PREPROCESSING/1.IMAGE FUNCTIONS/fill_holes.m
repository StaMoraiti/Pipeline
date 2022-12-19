%% THIS FUNCTION BINARIZE AND PROCESS THE 3D IMAGE SET
% THE PROCESSING INCLUDES DILATION/EROSION TO FILL THE CORTICAL PORES
clear all;
key_param.mouse=6;
key_param.week=24;

OrigPath='G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\DATA\ORIGINAL IMAGES\OVX\';
key_param.Specspath=strcat(sprintf('OVX%d',key_param.mouse),'\',sprintf('OVX%dW%d',key_param.mouse,key_param.week),'\');
subpath='Sections\S6\Z TRANSLATED\';

key_param.dir_codes=pwd;
%% -------------------------------------------------------------

cd(strcat(OrigPath,key_param.Specspath,subpath));
dicomFields=dir('*.dcm');    % lists fields in the DICOM path
fileNames = {dicomFields.name}'; % extract the name of the files
nSlice = numel(fileNames);    % actual number of slice
for iSlice=1:nSlice
    dicominfoVolume{iSlice}  = dicominfo(fileNames{iSlice});
    arrGreyStack(:,:,iSlice) = dicomread(fileNames{iSlice}); 
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
cd(strcat(key_param.dir_codes,'\TOOLS'))
mother_dir= strcat(OrigPath,key_param.Specspath,subpath);

newSubPath='\FilledHoles';
newPath=strcat(mother_dir,newSubPath);
newdir(newPath,mother_dir);
cd(newPath)
for i=1:size(im_noholes,3)
    dicomwrite(im_noholes(:,:,i),fileNames{i},dicominfoVolume{i}) 
end

FILLED=dicomreadVolume(newPath);
figure();sliceViewer(squeeze(FILLED));title('Binarized Filled')
