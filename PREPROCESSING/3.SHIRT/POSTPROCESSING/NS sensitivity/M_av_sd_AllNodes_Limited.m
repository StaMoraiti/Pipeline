%% All nodal spacing

function  M_av_sd_AllNodes_Limited(mouse, week, dl, NS)
%% Error


pathres="G:\Shared drives\Matina_Emily\Emily_folder\Emilycode\ShIRTMResults\"; % EMILY
pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\');
pathNS=strcat('2.5voxelsGREY\','NodeSpacing',sprintf('%d',NS),'\');
%pathNS=strcat('2voxels\','NodeSpacing',sprintf('%d',NS),'\');
cd(strcat(pathres,pathSpec,pathNS));

% Loads the ShIRT outpout (interpolated to the Image Points) 
filename1=strcat('NSens_surface_displ_ML',num2str(mouse),'W',num2str(week));
load(filename1);
d1 = [Vq_x Vq_y Vq_z];
% Loads the Image Points
% filename2='PointsImage';
% load(filename2,'p1');

% Measured Displacement around and in the bone tissue
%[ind,~]=arroundBone(d1,p1,mouse,week);
pathNS1='2voxels\NodeSpacing5';
cd(strcat(pathres,pathSpec,pathNS1))
filename=sprintf('LimitedArea_ML%dW%d',mouse,week);
load(filename,'ind');
len = length(ind);

dd= sqrt(d1(:,1).^2 + d1(:,2).^2 + d1(:,3).^2);% magnitude
d_xorder=reshape(dd,[316,326*175]);
d_3D=reshape(d_xorder,[316,326,175]);% REMEMBER TO TRANSPOSE EACH SLICE- SOS!!!
%ind=[y x z]=[j i k]
d1_s1=[];
for m=1:size(ind,1)
    d_slice=d_3D(:,:,ind(m,3))';
    d1_s1=[d1_s1;d_slice(ind(m,1),ind(m,2))];
end

% Imposed Displacement
% cd(strcat(pathres,pathSpec,pathNS));
% cd("..\..\")
% load('ImposedLocal_85.mat','d_hat');
% d_hat3D=repmat(d_hat,[1,1,175]);
% dhat_s1=[];
% for m=1:size(ind,1)
%     d_slice=d_hat3D(:,:,ind(m,3));
%     dhat_s1=[dhat_s1;d_slice(ind(m,1),ind(m,2))];
% end
dl=2.5;
dlz=2;
dl_xy = dl;
dl_z=dlz;
vs = sqrt((dl_xy*0.0104)^2+(dl_xy*0.0104)^2+(dl_z*0.0104)^2);
dhat_s1 = repmat(vs,len,1);

%Error calculation- accuracy & precision
ErrorS = 1000*(d1_s1- dhat_s1);
ErrorS_avL=mean(ErrorS);
ErrorS_stdL=std(ErrorS);

%% save values

%filename=strcat('ErrorsS',sprintf('ML%dW%dV%d%NS%d',mouse,week,dl,NS));
filename=strcat('ErrorsS_Lim',sprintf('ML%dW%dV%d%NS%d',mouse,week,dl,NS));
cd(strcat(pathres,pathSpec,pathNS));
save(filename, 'ErrorS_avL','ErrorS_stdL')
end

%% Creates mask around the bone tissue and keeps only these values for the displacement
function [ind,p1_s]=arroundBone(d1_B,p1_B,mouse,week)
%% Initiates the output parameters
p1_s=[];% Image points around the bone tissue
%d1_s=[];% Displacement coefficients in the points around the bone tissue
ind =[];
%% Loads the Pixel Intensity of the Original image where the Image Points are extracted from
ImagePath='C:\3.SHIRT\MAIN\ShIRTM\Data\Matina\Moved_images\';
Spec= strcat(sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\');

% pixel intensity information
Ip = squeeze(dicomreadVolume(strcat(ImagePath,Spec)));

%% Image Points information
Xco=repmat(p1_B(1:316,1)',[326,1]); % separate the coordinates
Yco=repmat(unique(p1_B(:,2)),[1,316]);
Zco=unique(p1_B(:,3));
ddf= sqrt(d1_B(:,1).^2 + d1_B(:,2).^2 + d1_B(:,3).^2);% magnitude
d_xorderf=reshape(ddf,[316,326*175]);
d_3Df=reshape(d_xorderf,[316,326,175]);% REMEMBER TO TRANSPOSE EACH SLICE- SOS!!!


%% Keeps only the points where at least one of the neighboor pixels has a non-zero intensity
tic;
for kf=1:size(Zco,1)-1%z
    for j=2:size(Xco,1)-1%y:rows
        for i=2:size(Xco,2)-1%x:columns
          pp=[Xco(j,i) Yco(j,i) Zco(kf)];
          %d_slice=d_3Df(:,:,kf)';
              ii=[Ip(j-1,i-1,kf) Ip(j,i-1,kf) Ip(j-1,i,kf) Ip(j,i,kf)];
              if ~isempty(find((ii~=0)==1))
              p1_s=[p1_s;pp];
              ind=[ind;j i kf];
              %d1_s=[d1_s;d_slice(j,i)];
              else
              continue
              end
        end
    end
end   
toc;
filenamef=sprintf('LimitedArea_ML%dW%d.mat',mouse,week);
save(filenamef,'p1_s','ind');
end




