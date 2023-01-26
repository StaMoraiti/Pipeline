clear all;clc;
mouse=[1 2 3 4 5 6];
week=[18];
dl=[2.5];
N=[5:5:50];
%parpool(4);
for m=1:length(N)
    for k=1:size(dl,2)
        for i=1:size(mouse,2)
            for j=1:size(week,2)
         
            disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
            disp('Examined group: Mechanical Loading          Examined Section: 6th')
            disp(' ')
            fprintf('Fixed images: Virtually translated images of the mouse %3.1f, Age %d-weeks old\n',mouse(i), week(j))
            fprintf('              The translation applied to the images is %3.1f voxels\n',dl(k))
            fprintf('Moved images: Mouse %d, Age 18-weeks old\n',mouse(i))
            fprintf('Nodal Spacing: %d\n',N(m))
            disp('____________________________________________________________________________')
            
            disp(' --> C A L C U L A T E    T H E    S U R F A C E    D I S P L A C E M E N T S <-- ')
            disp(' ');
            
            [Vq_x,Vq_y,Vq_z]=surface_displace(mouse(i),week(j),dl(k),N(m));
            fprintf('The results are saved in the mat file: "NSens_surface_displ_ML%dW%d.mat"',mouse(i), week(j))
            disp(' ')
            
            end
            
        end   
   end
end 
function [Vq_x,Vq_y,Vq_z]=surface_displace(mouse,week,dl,N)

%% KEY PATH PARAMETERS

pathMother='G:\Shared drives\Matina_Emily\Emily_folder\';
pathRes="G:\Shared drives\Matina_Emily\Emily_folder\Emilycode\ShIRTMResults\NSensitivity\"; % EMILY
pathSpec= strcat(sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\');
pathNS=strcat('\LocalDeform_2.5\Mode_Deformation\',sprintf('NodeSpacing%d',N),'\');

%% GRID INFORMATION: NODES AND DISPLACEMENTS
cd(strcat(pathRes,pathSpec,pathNS));
filename=strcat('ML',num2str(mouse),'W',num2str(week),'_ShIRToutputmap.mat'); % EMILY

load(filename)

%nods_ID=grid_dxdydz(:,1);
xgrid=grid_dxdydz(:,2); %EMILY
[x,~]=unique(xgrid);
Nx=size(x,1);
ygrid=grid_dxdydz(:,3); %EMILY
[y,~]=unique(ygrid);
Ny=size(y,1);
zgrid=grid_dxdydz(:,4); %EMILY
[z,~]=unique(zgrid);
Nz=size(z,1);

vx=grid_dxdydz(:,5); %EMILY
vy=grid_dxdydz(:,6); %EMILY
vz=grid_dxdydz(:,7); %EMILY

Vx=zeros(Ny,Nx,Nz);
Vy=zeros(Ny,Nx,Nz);
Vz=zeros(Ny,Nx,Nz);
start=1;
for k=1:Nz
   for l=1:Nx
       endfor=start+Ny-1;
       Vx(:,l,k)= vx(start:endfor)';
       Vy(:,l,k)= vy(start:endfor)';
       Vz(:,l,k)= vz(start:endfor)';
       start=endfor+1;
   end
end


%% REFERENCE SURFACE MESH
%--- SURFACE POINTS ---
% MeshPath='G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\LIMITATIONS\NODAL SPACING\DISPLACEMENT SENSITIVITY\MOUSE Differences_surfaces\DATA\';
% cd(MeshPath);
% surfR=ml4w18;
% xq=surfR.vertices(:,1);
% yq=surfR.vertices(:,2);
% zq=surfR.vertices(:,3);
% ExtractedSurface2;
% hold on;
% xq=surface.vertices(:,1);
% yq=surface.vertices(:,2);
% zq=surface.vertices(:,3);

%--- IMAGE POINTS ---  %EMILY
cd(strcat(pathRes,pathSpec,pathNS));

filename= strcat('PointsImage'); % EMILY
load(filename)
xq=p1(:,1);
yq=p1(:,2);
zq=p1(:,3);

%% SPATIAL REALOCATION OF THE GRIG
% 1)bounding box
% pathImage='C:\3.SHIRT\MAIN\ShIRTM\Data\Matina\Fixed_images\';
% path1='2.5voxelsGREY\Blank\';
% cd(strcat(pathImage,pathSpec,path1))
% %EMILY
% dicomFields = dir('*.dcm');    % lists fields in the DICOM path
% fileNames = {dicomFields.name}';
% Nslices=numel(fileNames);
% ImPosition = dicominfo(fileNames{1}).ImagePositionPatient;
% Npix_x     = double(dicominfo(fileNames{1}).Columns);
% Npix_y     = double(dicominfo(fileNames{1}).Rows);
% res = 0.0104; %(milimeters)

ImPosition=p1(1,:);
% SPATIAL TRANSLATION OF THE images
xq=xq-ImPosition(1,1);
yq=yq-ImPosition(1,2);
zq=zq-ImPosition(1,3);


%% TRILINEAR INTERPOLATION

Vq_x = interp3(x,y',z,Vx,xq,yq,zq);%;Vq_x(isnan(Vq_x)) = [];
Vq_y = interp3(x,y',z,Vy,xq,yq,zq);%Vq_y(isnan(Vq_y)) = [];
Vq_z = interp3(x,y',z,Vz,xq,yq,zq);%Vq_z(isnan(Vq_z)) = [];


%Final positions(- because the displacement is the dinstance vector from the fixed to the moved)
% xq_t=xq-Vq_x;
% yq_t=yq-Vq_y;
% zq_t=zq-Vq_z;

% ptCloud  = pointCloud([xq yq zq],'Color',repmat([0 1 1],size(xq,1),1));
% ptCloud_t= pointCloud([xq_t yq_t zq_t],'Color',repmat(	[1 0 0],size(xq,1),1));
% figure();pcshow(ptCloud);hold on;pcshow(ptCloud_t)
% xlabel('x');ylabel('y');zlabel('z');
% legend('Reference mesh','Registered reference mesh')
% ax = gca;
% ax.Color='k';
% hold off;

%ind=main(ptCloud_t);

%% SAVING RESULTS INTO MAT FILES
cd(strcat(pathRes,pathSpec,pathNS))
filename=strcat('NSens_surface_displ_ML',num2str(mouse),'W',num2str(week));
save(filename,'Vq_x','Vq_y','Vq_z')

%% VERIFICATION
% K=8;
% ptCloud= pointCloud([grid_dxdydz(:,2)+dif_x grid_dxdydz(:,3)+dif_y grid_dxdydz(:,4)+dif_z]);
% for i=1:1
%     point=[xq(i,1), yq(i,1), zq(i,1)];
% [indices,dists] = findNearestNeighbors(ptCloud,point,K);
% neighbors.points=[ptCloud.Location(indices,1) ptCloud.Location(indices,2) ptCloud.Location(indices,3)];
% roi=[2.78281 2.78282,1.70625 1.70626, 10.3243 10.3244];
% indices1 = findPointsInROI(ptCloud,roi);
% neighbors.points(7,:)=[ptCloud.Location(indices1,1) ptCloud.Location(indices1,2) ptCloud.Location(indices1,3)];
% indices(7,1)=indices1;
% plot3(point(1),point(2),point(3),'*r');hold on;
% plot3(point(1)+Vq_x(1,1),point(2)+Vq_y(1,1),point(3)+Vq_z(1,1),'*','Color', '#A2142F');hold on;
% plot3([point(1) point(1)+Vq_x(1,1)],[point(2) point(2)+Vq_y(1,1)],[point(3) point(3)+Vq_z(1,1)],'--','Color','#00FFFF' );hold on;
% neighbors.bounds.x=[min(neighbors.points(:,1)) max(neighbors.points(:,1))];
% neighbors.bounds.y=[min(neighbors.points(:,2)) max(neighbors.points(:,2))];
% neighbors.bounds.z=[min(neighbors.points(:,3)) max(neighbors.points(:,3))];
% col='#FF00FF';
% boundingBox_plot(neighbors.bounds,lstyle,col);hold on;
% neighbors.displacements.x=vx(indices,1);
% neighbors.displacements.y=vy(indices,1);
% neighbors.displacements.z=vz(indices,1);
% displaced_nghbrs.points(:,1)=neighbors.points(:,1)+neighbors.displacements.x;
% displaced_nghbrs.points(:,2)=neighbors.points(:,2)+neighbors.displacements.y;
% displaced_nghbrs.points(:,3)=neighbors.points(:,3)+neighbors.displacements.z;
% col='#7E2F8E';
% labels={'1','2','3','4','5','6','7','8'};
% plot3(displaced_nghbrs.points(:,1),displaced_nghbrs.points(:,2),displaced_nghbrs.points(:,3),'o','Color','#7E2F8E')
% text(displaced_nghbrs.points(:,1),displaced_nghbrs.points(:,2),displaced_nghbrs.points(:,3),labels,'VerticalAlignment','bottom','HorizontalAlignment','right')
% for i=1:size(neighbors.points,1)
% plot3([neighbors.points(i,1) displaced_nghbrs.points(i,1)],[neighbors.points(i,2) displaced_nghbrs.points(i,2)],[neighbors.points(i,3) displaced_nghbrs.points(i,3)],...
%     '--','Color','#00FFFF');hold on
% end
% 
% end


end