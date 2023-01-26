
week= 18;mouse=[4 5 6];
res=0.0104;
dir_code=pwd;
rootpath = 'G:\Shared drives\Matina_Emily\Emily_folder\Code\ShIRTM\';
pathdata = 'Data\Matina\';

for kk=1:length(mouse)
pathIMAGES_M = strcat('Fixed_images\',sprintf('ML%d',mouse(kk)),'\',sprintf('ML%dW%d',mouse(kk),week),'\Virtually translated\2.5voxelsGREY\Blank\');
%C:\3.SHIRT\MAIN\ShIRTM\Data\Matina\Fixed_images\ML1\ML1W18\2.5voxelsGREY\Blank\
cd(strcat(rootpath,pathdata,pathIMAGES_M));
dicomFields = dir('*.dcm');    % lists fields in the DICOM path
fileNames = {dicomFields.name}';
Nslices=numel(fileNames);
ImPosition = dicominfo(fileNames{1}).ImagePositionPatient; %finds position

M_ims = dicomreadVolume(strcat(rootpath,pathdata,pathIMAGES_M));M_ims=squeeze(M_ims);

z=ImPosition(3,1);
y=ImPosition(2,1);
x=ImPosition(1,1);   %x is 1st column
p1=zeros(size(M_ims,3)*size(M_ims,2)*size(M_ims,1),3);
%p1=zeros(174*315*325,3);
%p1=zeros(17813250,3);

i=0;  %edited from i=1
              %define origin (1st elememt) 
%p1(1,:)=[x y z];
for k= 0:size(M_ims,3)
    z=ImPosition(3,1)+k*res; %edited from k=1:size(M_ims,3)
    for l= 0:size(M_ims,1)
        y=ImPosition(2,1)+l*res; %edited from l=1:size(M_ims,3)
        for m= 0:size(M_ims,2)   %edited from m=1:size(M_ims,3)
            i=i+1;  %goes to second element
            x=ImPosition(1,1)+m*res;
            p1(i,:)=[x y z];
        end
    end %k for z, l for y, m for x
end    
% NewLocation = strcat('C:\Users\emily\OneDrive\Documents\insigneo\Code\ShIRTMResults\ImagePoints\',sprintf('ML%d',mouse));
% cd(strcat(NewLocation))
% save(filename, 'p1')

filename = 'PointsImage';
NS=[5:5:50];

for i=1:length(NS)
        pathres="G:\Shared drives\Matina_Emily\Emily_folder\Code\ShIRTM\Results\"; % EMILY
        pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(kk)),'\',sprintf('ML%dW%d',mouse(kk),week),'\');
        pathNS=strcat('2.5voxelsGREY\','NodeSpacing',sprintf('%d',NS(i)),'\');
        cd(strcat(pathres,pathSpec,pathNS));
        save(filename, 'p1')
end
end
