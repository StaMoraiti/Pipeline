% Originally developed for automatic removal of the fibula
% Part of the original workflow
% Developed and extended further by CHEONG Vee San
% Changelog 25 July 2018 - Improvements to make it run faster
% Changelog 9 Sep 2020 - Code remains to remove remaining noise and
% remnants at the distal tibio-fibular joint
% Changedlog 3/12/2021 - add the midSlice information 
%    extracted from the "find_midSlice" fuction execution

function arrBoneMask=denoise_m(arrBoneMask,param)
    cd('..\1.IMAGE FUNCTIONS\OUTPUTS\MidSlice Information')
    mouse=param.mouse;
    week=param.week;
    load(strcat(sprintf('ML%dW%d',mouse,week),'_MIDSLICE'))
    flag=0;
    i=0;
    while flag==0 % finds the first non blank image. This is the bottom slice of stack
        i=i+1;
        im=arrBoneMask(:,:,i);
        flag=~isempty(find(ne(im,0)));
        
    end
    proxSliceID=i;
    midSliceID=midSlice.mid_ind+proxSliceID;
    
    %proxSlice=340;%closest to the knee(higher number slice)
    % compute connected components for binary images
    structConn = bwconncomp(arrBoneMask,6);
    arrLabelMatrix = labelmatrix(structConn);
    % compute region with the largest number of connected objects (tibia)
        % and update the Bone Mask
    [NumConnObjects, labelNum] = ...
        max(histc(arrLabelMatrix(:),1:structConn.NumObjects));
    arrBoneMask = double(arrLabelMatrix == labelNum);

    for iSlice=midSliceID-1:-1:proxSliceID
    structConn = bwconncomp(arrBoneMask(:,:,iSlice),4);
    arrLabelMatrix = labelmatrix(structConn);
    [NumConnObjects, labelNum] = ...
        max(histc(arrLabelMatrix(:),1:structConn.NumObjects));
    arrBoneMask(:,:,iSlice) = double(arrLabelMatrix == labelNum);
    end