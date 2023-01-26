%% All nodal spacing

function  E_av_sd_AllNodes(mouse, week, dl, NS)
%% Error

dlz=2;
pathres="G:\Shared drives\Matina_Emily\Emily_folder\Emily's code\ShIRTMResults\"; % EMILY
pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\');
%pathNS=strcat(sprintf('%d',dl),'voxels\','NodeSpacing',sprintf('%d',NS),'\');
pathNS=strcat('2.5voxelsRULE\','NodeSpacing',sprintf('%d',NS),'\');
cd(strcat(pathres,pathSpec,pathNS));

filename1=strcat('NSens_surface_displ_ML',num2str(mouse),'W',num2str(week));
load(filename1);
d1 = [Vq_x Vq_y Vq_z];
filename2='PointsImage';
load(filename2,'p1');

d1_small=arroundBone(d1,p1);

dxyz_1=sqrt(Vq_x.^2 + Vq_y.^2 + Vq_z.^2);

len = length(dxyz_1);
dl_xy = dl;
dl_z=dlz;
vs = sqrt((dl_xy*0.0104)^2+(dl_xy*0.0104)^2+(dl_z*0.0104)^2);
d_hat = repmat(vs,len,1);
ErrorS = 1000*(dxyz_1 - d_hat);
ErrorS_av=mean(ErrorS);
ErrorS_std=std(ErrorS);

%% save values

%filename=strcat('ErrorsS',sprintf('ML%dW%dV%d%NS%d',mouse,week,dl,NS));
filename=strcat('ErrorsS',sprintf('ML%dW%d',mouse,week),'2_5',sprintf('NS%d',NS));
cd(strcat(pathres,pathSpec,pathNS));
save(filename, 'ErrorS_av','ErrorS_std')

%% Creates mask around the bone tissue and keeps only these values for the displacement
function [d1_s,p1_s]=arroundBone(d1_B,p1_B)
%% Initiates the output parameters
p1_s=[];% Image points around the bone tissue
d1_s=[];% Displacement coefficients in the points around the bone tissue

%% Loads the Pixel Intensity of the Original image where the Image Points are extracted from
ImagePath='C:\3.SHIRT\MAIN\ShIRTM\Data\Matina\Fixed_images\ML1\ML1W18\2.5voxelsGREY\Moved\FilledHoles';
cd(ImagePath);
dicomFields = dir('*.dcm');    % lists fields in the DICOM path
fileNames = {dicomFields.name}';
Nslices=numel(fileNames);
% pixel intensity information
Ip = squeeze(dicomreadVolume(ImagePath));

%% Image Points information
Xco=repmat(p1_B(1:316,1)',[326,1]); % separate the coordinates
Yco=repmat(unique(p1_B(:,2)),[1,316]);
Zco=unique(p1_B(:,3));

%% Keeps only the points where at least one of the neighboor pixels has a non-zero intensity
for k=1:size(Zco,1)%z
    for j=1:size(Xco,1)%y:rows
        for i=1:size(Xco,2)%x:columns
          pp=[Xco(j,i) Yco(j,i) Zco(k)];
          ii=[Ip(j-1,i-1,k) Ip(j,i-1,k) Ip(j-1,i,k) Ip(j,i,k)];
          if ~isempty(find((ii~=0)==1))
              p1_s=[p1_s;pp];
              [Rx,C]=find(p1_B==PP(1));
              px=p1_B(R,:);
              [Ry,C]=find(px(:,2)==PP(2));
              pxy=px(R,:);
              [Rz,C]=find(pxy(:,3)==PP(3));
              d1_s=[d1_s;d1_B(Rx(Ry(Rz)),:)]
          else
              continue
          end
        end
    end
end   
end


end











