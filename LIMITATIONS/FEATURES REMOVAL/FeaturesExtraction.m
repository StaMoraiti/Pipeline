%% This function evaluates whether the trabeculae features or cortical pores are mechanically significant 
%This is accomplished by calculating the number of the Higly Deformend Locations
%that lay in the area arround the features. The steps are:
%1) Binarize the original greyscale images (Un)
%2) Load the processed (Pr)
%3) Image operations: Un-Pr or Pr-Un
%4) Create the shell S around the features
%5) Isolate the multiple shells. The next steps are done for all the separate shells individually
%6) Create the microFE model of the shell
%7) Create a bounding boxe of the microFE model, keeping the min and max of the coordinated
%8) Load the Highly Deformed Locations of the Un FE model saved in a mat file(Note: this is done in the "CommonIntPt" function)
%9) Check if the HDLs belong to the bounding box
%10)Number the times the condition is met- calculat the M4. The seperate analysis for each shell is no completed
%11)Keep the largest value over the multiple shells

clear all;
clc;
mouse=[1 2 3 4 5 6];
week=[18 24];
dir_codes=pwd;
i=1;j=1;

rootpath='G:\My Drive\PhD\WORK\2nd_year\μCT2μFE_pipeline\';
% UNPROCESSED
dicomPathU=strcat(rootpath,'DATA\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week(j)),'\S6\GREYSCALE');
abaqusPathU=strcat(rootpath,sprintf('abaqus-with_m%da2',mouse(i)));

% PROCESSED
dicomPathP=strcat(rootpath,'DATA\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week(j)),'\S6\SEGMENTED_NOholes_trab');
abaqusPathP=strcat(rootpath,sprintf('abaqus-without_m%da2',mouse(i)));


folderpath=sprintf('ML%dW%d',mouse(i),week(j)); %

IMAGE_RESOLUTION = 0.0104; 
writeflag = 1; %write output file 

%% U1. READ UNPROCESSED IMAGES
fprintf('U1. Reading the dicom files of the unprocessed images\n')
cd(strcat(dicomPathU));
dicomFields=dir('*.dcm');
fileNames = {dicomFields.name}'; % extract the name of the files
nSlice = numel(fileNames);    % actual number of slices

I = dicomread(fileNames{1});     % First DICOM image is in the 3rd file

% Initialise 3D matrix of images as int16 to be same as I
arrGreyStack =zeros([size(I) nSlice],class(I)); 
arrGreyStack(:,:,1) = I;         % Add image read to matrix
 
% Create image sequence array
for iSlice = 2:nSlice
    arrGreyStack(:,:,iSlice) = dicomread(fileNames{iSlice}); 
end

arrGreyStack=double(arrGreyStack); % convert to double for matrix operation

cd(rootpath)

 %% U2. SEGMENTATION
fprintf('U2. Segmenting the unprocessed images\n');
% creates binary bone mask

if (exist(sprintf('greythreshold-M%d.txt',mouse),'file'))
  
    dblGreyThreshold=BMDtoGV2(dblBMDThreshold,RescaleIntercept,...
                RescaleSlope,ScaleFactor,scanco_slope_a,scanco_intercept_b);  
    
else

    %Automatic segmentation
    [dblGreyThreshold, dblPVE] = segm_th2(arrGreyStack(:));
%     for iSlice=1:2
%         [dblPVE(iSlice),~]=getBMDCal2(dblPVE(iSlice),RescaleIntercept,...
%             RescaleSlope,ScaleFactor,scanco_slope_a,scanco_intercept_b);
%     end

    % Write greythreshold segmentation value to file for next iteration
    filename = sprintf('greythreshold-M%d.txt',mouse);
    fid1 = fopen(filename, 'w');
    fprintf(fid1,'%6.4E, %8.6E, %8.6E', dblGreyThreshold, dblPVE(1), dblPVE(2));
    fclose(fid1);
end
            
arrBoneMask = arrGreyStack > dblGreyThreshold; 
arrBoneMask=double(arrBoneMask); % convert from logical to double

%-------------------------------------------------------------------------%

%% U3. REMOVAL OF ANY REMAINING NOISE
fprintf('U3. Removing any remaining noise from the images\n');
arrBoneMaskU=denoise(arrBoneMask,folderpath,dicomPathU); 

cd(rootpath);

%% P1. READ PROCESSED IMAGES
fprintf('P1. Reading the dicom files of the processed images\n')
cd(strcat(dicomPathP));
dicomFields=dir('*.dcm');
fileNames = {dicomFields.name}'; % extract the name of the files
nSlice = numel(fileNames);    % actual number of slices

J = dicomread(fileNames{1});     % First DICOM image is in the 3rd file

% Initialise 3D matrix of images as int16 to be same as I
arrBoneMaskP =zeros([size(J) nSlice],class(J)); 
arrBoneMaskP(:,:,1) = J;         % Add image read to matrix
 
% Create image sequence array
for iSlice = 2:nSlice
    arrBoneMaskP(:,:,iSlice) = dicomread(fileNames{iSlice}); 
end

arrBoneMaskP=double(arrBoneMaskP); % convert to double for matrix operation
arrBoneMaskP(arrBoneMaskP>0)=1;

%% IMAGE OPERATIONS IN ORDER TO EXTRACT THE FEATURES I.E., TRABECULAE AND CORTICAL PORES
FeatIM=arrBoneMaskU-arrBoneMaskP;% (p-u): pores, (u-p):trab
FeatIM(FeatIM<0)=0;
figure();sliceViewer(FeatIM);
se = strel("disk",1);
C=imerode(FeatIM,se);
FeatIM=imdilate(C,se);% DELETE THE NOICE AROUND THE ENDOSTEUN AND PERIOSTEUM
figure();sliceViewer(FeatIM);
se = strel("disk",3);
S=imdilate(FeatIM,se);% CREATE THE SHELL
figure();sliceViewer(S);

surAr=S.*arrBoneMaskU;

%% BOUNDARIES TO ISOLATE EACH FEATURE

CC = bwconncomp(S);
numPixels = cellfun(@numel,CC.PixelIdxList);
[c,idx] = sort(numPixels);
for ii=1:CC.NumObjects
Si=S;    
idx_res= idx(setdiff(1:end,ii));
for k=1:length(idx_res)
Si(CC.PixelIdxList{idx_res(k)})=0;
end
surAri=Si.*arrBoneMaskU;

%figure();sliceViewer(Si);
%% GENERATION OF FE MESH
fprintf('Generating FE mesh of the feature and the surrounding area\n');
cd(rootpath)
Elems_index = find(surAri);     % returns indices array of nonzero arrElemConn
nElem = numel(find(surAri));   % find the size of nonzero matrix 
arrPixelMatrix = surAri;
arrPixelMatrix(Elems_index)=1:nElem; % 3D matrix labelling all bone elems

% Variables are sent to function FEGenerator.m to build the cartesian mesh,
% it will save the list of arrElemConn and arrNodeCord in 2 separate txt files
[arrNodeCord,arrElemConn,arrPixelMatrix]=...
    FEGeneratorAbaqus4(arrPixelMatrix,nElem,IMAGE_RESOLUTION,writeflag);

%% CREATING A BOUNDING BOX OF THE AREA
fprintf('Creating the bounding box of the area\n')
xbounds=[min(arrNodeCord(:,2)) max(arrNodeCord(:,2))];
ybounds=[min(arrNodeCord(:,3)) max(arrNodeCord(:,3))];
zbounds=[min(arrNodeCord(:,4)) max(arrNodeCord(:,4))];


cd(strcat(abaqusPathP))
load(sprintf('highlyDefLoc_ML%dW%d',mouse(i),week(j)));
IPcoordU=IntPs2(Iu,3:5);
IPcoordP=IntPs3(Ip,3:5);
flagUx=IPcoordU(:,1)>xbounds(1) & IPcoordU(:,1)<xbounds(2);
flagUy=IPcoordU(:,2)>ybounds(1) & IPcoordU(:,2)<ybounds(2);
flagUz=IPcoordU(:,3)>zbounds(1) & IPcoordU(:,3)<zbounds(2);

flag=flagUx.*flagUy.*flagUz;

f(ii)=size(find(flag==1),1)/size(flag,1);
end
f2=max(f);
