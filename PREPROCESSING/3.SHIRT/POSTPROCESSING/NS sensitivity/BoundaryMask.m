%% Further masking only on the boundaries
clear all;clc;

%% key parameters
mouse=[1 2 3 4 5 6];week=18;

for kk=1:size(mouse,2)
%1) Loading the limited area: ind=[index_y index_x index_z].
% The current limited area consists of the image points with pixel
% intensity of the bone tissue.
pathres="G:\Shared drives\Matina_Emily\Emily_folder\Emilycode\ShIRTMResults\"; % EMILY
pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(kk)),'\',sprintf('ML%dW%d',mouse(kk),week),'\');
pathNS1='2voxels\NodeSpacing5';

cd(strcat(pathres,pathSpec,pathNS1))
filename=sprintf('LimitedArea_ML%dW%d',mouse(kk),week);
load(filename,'ind');
%Loads the Image Points
filename2='PointsImage';
load(filename2,'p1');

ImagePath='C:\3.SHIRT\MAIN\ShIRTM\Data\Matina\Moved_images\';
Spec= strcat(sprintf('ML%d',mouse(kk)),'\',sprintf('ML%dW%d',mouse(kk),week),'\');

% pixel intensity information
Ip = squeeze(dicomreadVolume(strcat(ImagePath,Spec)));

%% Image Points information
Xco=repmat(p1(1:316,1)',[326,1]); % separate the coordinates
Yco=repmat(unique(p1(:,2)),[1,316]);
Zco=unique(p1(:,3));
% ind=[j i k]
p1_b=[];ind_b=[];
for k=1:size(ind,1)-1%z
          pp=[Xco(ind(k,1),ind(k,2)) Yco(ind(k,1),ind(k,2)) Zco(ind(k,3))];
          %d_slice=d_3Df(:,:,kf)';
          ii=[Ip(ind(k,1)-1,ind(k,2)-1,ind(k,3)) Ip(ind(k,1),ind(k,2)-1,ind(k,3)) Ip(ind(k,1)-1,ind(k,2),ind(k,3)) Ip(ind(k,1),ind(k,2),ind(k,3))];
          if ~isempty(find((ii~=0)==1)) && numel(find((ii~=0)==1))<4 
             p1_b=[p1_b;pp];
             ind_b=[ind_b;ind(k,1) ind(k,2) ind(k,3)];
             %d1_s=[d1_s;d_slice(j,i)];
          else
             continue
          end
end

filenamef=sprintf('BoundaryArea_ML%dW%d.mat',mouse(kk),week);
save(filenamef,'p1_b','ind_b');
end   


