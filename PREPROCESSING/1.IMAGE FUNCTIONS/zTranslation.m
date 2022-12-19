%% This function calls the function "find_midSlice", which finds the midslice and its Z
%% and then it calculates the z translation to be applied in the data images to alliGN
%% the z centers with the reference(ML4W18)

%Data
key_param.dir_codes=pwd;
key_param.rootpath='G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\DATA\ORIGINAL IMAGES\OVX\';

population=[1 2 3 5 6];
weeks=[18 24];
%Results
mother_dir=strcat(key_param.dir_codes,'\OUTPUTS');
key_param.newSubPath='\OVXMidSlice Information\';
newPath=strcat(mother_dir,key_param.newSubPath);
cd('./TOOLS')
newdir(newPath,mother_dir);
%Reference
mouse=4;wk=1;
key_param.mouse= mouse ;
key_param.week= weeks(wk);
cd(key_param.dir_codes)
key_param.rootpathR='G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\DATA\ORIGINAL IMAGES\ML\ESB22_DATA\S6\';
folderpathR=strcat(sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,weeks(wk)),'\META_IMAGES\CROPPED\');
[store_filename]=find_midSlice(key_param,key_param.rootpathR,folderpathR);
cd(newPath)
load(strcat(store_filename,'.mat'))
Zref=midSlice.ImagePositionZ;
for i=1:size(population,2)
        
        for j=1:size(weeks,2)
        key_param.mouse= population(i) ;
        key_param.week= weeks(j);
        cd(key_param.dir_codes)
        folderpath=strcat(sprintf('OVX%d',population(i)),'\',sprintf('OVX%dW%d',population(i),weeks(j)),'\Sections\S6');
        store_filename=find_midSlice(key_param,key_param.rootpath,folderpath);
        cd(newPath)
        load(strcat(store_filename,'.mat'))
        Zm=midSlice.ImagePositionZ;
        dZ(i,j)= Zref-Zm;
        end
    
end
TranslationMatrix=[population' dZ];
TranslationMatrix=[NaN weeks;TranslationMatrix];