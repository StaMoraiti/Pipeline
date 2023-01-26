clc
clear

%Figure = openfig(strcat(folder_locs, combinations(i).name,'\', 'Ref_seg_image.fig'));
Figure = openfig(strcat('Lambda5\', 'Ref_seg_image.fig'));
Image = Figure.UserData.Data(:,:,:,1);% this is label for Lin project
segmentations = Figure.UserData.Data(:,:,:,2); % this is MRI image for Lin project


num = size(segmentations,3);
mkdir MCn_00_005_17/MCn_00_005_17_MRI

for i = 1:num
    if i<10
        imwrite(segmentations(:,:,i),['MCn_00_005_17/MCn_00_005_17_MRI/MCn_00_005_17_00',num2str(i),'.png']);
    elseif (i>=10)&&(i<100)
        imwrite(segmentations(:,:,i),['MCn_00_005_17/MCn_00_005_17_MRI/MCn_00_005_17_0',num2str(i),'.png']);
    else
        imwrite(segmentations(:,:,i),['MCn_00_005_17/MCn_00_005_17_MRI/MCn_00_005_17_',num2str(i),'.png']);
    end
end



