
rootpath='E:\PhD\WORK\2nd year\Data\VEE\ML\ESB22_DATA\S6\';
subpath='Z TRANSLATED';
mouse=[1 2 3 4 5 6];
week=[18 24];
for i=1:size(mouse,2) 
    for j=1:size(week,2)
        folderpath=strcat(sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week(j)),'\');
        if mouse(i)==4&& week(j)==18
         subpath='META_IMAGES\CROPPED';
         
        end
        figure();
        sliceViewer(squeeze(dicomreadVolume(strcat(rootpath,folderpath,subpath))));
        title(strcat('SEGMENTED IMAGE: ML',num2str(mouse(i)),'W',num2str(week(j))))
        if mouse(i)==4&& week(j)==18
         subpath='Z TRANSLATED';
         
        end
    end
end