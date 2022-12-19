function show_regSurf(ptCloud, ptCloud_t)
% This function plots the midslice of the reference before and AFTER THE
% REGISTRATION

%% 1.LOAD THE FIXED IMAGES AND FIND THE MIDSLICE
cd('C:\ShIRTM\Data\Matina\Fixed_images\ML1\ML1W24')
dicomFields = dir('*.dcm');    % lists fields in the DICOM path
fileNames   = {dicomFields.name}';
Nslices     = numel(fileNames);
MidPosition = dicominfo(fileNames{Nslices/2}).ImagePositionPatient;
f1 = dicomread(fileNames{Nslices/2});
f1_z = MidPosition(3,1);
imshow(f1)

%% TRILINEAR INTERPOLATION TO FIND THE SURFACE POINTS LAID ON THE PLANE OF THE IMAGE


