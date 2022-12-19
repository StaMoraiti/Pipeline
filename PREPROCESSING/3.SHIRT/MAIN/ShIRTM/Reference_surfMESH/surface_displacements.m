mouse=[1 2 3 4 5 6];
week=[18 24];

for i=1:size(mouse,2)
     for j=1:size(week,2)
         if not(mouse(i)==4 && week(j)==18)
            disp('----------------------------------------------------------------------------')
            disp('Examined group: Mechanical Loading          Examined Section: 6th')
            disp(' ')
            fprintf('Fixed images: Mouse %d, Age %d-weeks old\n',mouse(i), week(j))
            disp('Moved images: Mouse 4, Age 18-weeks old')
            disp('____________________________________________________________________________')
            
            disp(' -> C A L C U L A T E    T H E    S U R F A C E    D I S P L A C E M E N T S <- ')
            disp(' ');
            
            [Vq_x,Vq_y,Vq_z,ptCloud_t]=surface_displace(mouse(i),week(j));
            fprintf('The results are saved in the mat file: "surface_displ_ML%dW%d.mat"',mouse(i), week(j))
            disp(' ')
            filename=strcat('surface_displ_ML',num2str(mouse(i)),'W',num2str(week(j)));
            save(filename,'Vq_x','Vq_y','Vq_z','ptCloud_t')
            
            
         end
     end
 end
 
function [Vq_x,Vq_y,Vq_z,ptCloud_t]=surface_displace(mouse,week)

%% KEY PARAMETERS
col='b';
lstyle='-';
dir_code=pwd;
pathres='G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\PREPROCESSING\3.SHIRT\MAIN\ShIRTM\Results\';
pathSpec= strcat(sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\');
pathNS='milimetersNodeSpacing10\';

%% GRID INFORMATION: NODES AND DISPLACEMENTS
cd(strcat(pathres,pathSpec,pathNS));
filename=strcat('ML',num2str(mouse),'W',num2str(week),'_ShIRToutputmap.mat');

load(filename)

nods_ID=grid_dxdydz(:,1);
xgrid=grid_dxdydz(:,2);
[x,ind_x]=unique(xgrid);
Nx=size(x,1);
ygrid=grid_dxdydz(:,3);
[y,ind_y]=unique(ygrid);
Ny=size(y,1);
zgrid=grid_dxdydz(:,4);
[z,ind_z]=unique(zgrid);
Nz=size(z,1);

vx=grid_dxdydz(:,5);
vy=grid_dxdydz(:,6);
vz=grid_dxdydz(:,7);

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
cd(dir_code)
ExtractedSurface2;
hold on;
xq=surface.vertices(:,1);
yq=surface.vertices(:,2);
zq=surface.vertices(:,3);

%% SPATIAL REALOCATION OF THE GRIG
% GRID AND IMAGE HAVE DIFFERENT ORIGINS
% GRID:
% 1)bounding box
gridd.bounds.x=[min(x) max(x)];
gridd.bounds.y=[min(y) max(y)];
gridd.bounds.z=[min(z) max(z)];
% 2)center
gridd.center.x= mean(gridd.bounds.x);
gridd.center.y= mean(gridd.bounds.y);
gridd.center.z= mean(gridd.bounds.z);
% IMAGE:
% 1)bounding box
cd('G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\PREPROCESSING\3.SHIRT\MAIN\ShIRTM\Data\Matina\Moved_images')
dicomFields = dir('*.dcm');    % lists fields in the DICOM path
fileNames = {dicomFields.name}';
Nslices=numel(fileNames);
ImPosition = dicominfo(fileNames{1}).ImagePositionPatient;
Npix_x     = double(dicominfo(fileNames{1}).Columns);
Npix_y     = double(dicominfo(fileNames{1}).Rows);
res = 0.0104; %(milimeters)

% plot of the bounding boxes to see their different relevant location
% They have different origin and orinetation
image.bounds.x=[ImPosition(1,1) ImPosition(1,1)+Npix_x*res];
image.bounds.y=[ImPosition(2,1) ImPosition(2,1)+Npix_y*res];
image.bounds.z=[ImPosition(3,1) ImPosition(3,1)+Nslices*res];
cd(dir_code);
boundingBox_plot(image.bounds,lstyle,col);
hold on;
col='r';
boundingBox_plot(gridd.bounds,lstyle,col);

% 2)center
image.center.x= mean(image.bounds.x);
image.center.y= mean(image.bounds.y);
image.center.z= mean(image.bounds.z);

% global dinstances of the centers
dif_x=abs(image.center.x-gridd.center.x);
dif_y=abs(image.center.y-gridd.center.y);%
dif_z=abs(image.center.z-gridd.center.z);%

% SPATIAL TRANSLATION OF THE GRID
trans_grid.x=x+dif_x;
trans_grid.y=y+dif_y;
trans_grid.z=z+dif_z;

trans_grid.bounds.x=[min(trans_grid.x) max(trans_grid.x)];
trans_grid.bounds.y=[min(trans_grid.y) max(trans_grid.y)];
trans_grid.bounds.z=[min(trans_grid.z) max(trans_grid.z)];
%col=[0.6350 0.0780 0.1840]
col='#A2142F';
boundingBox_plot(trans_grid.bounds,lstyle,col);
hold off
%% TRILINEAR INTERPOLATION

Vq_x = interp3(trans_grid.x,trans_grid.y',trans_grid.z,Vx,xq,yq,zq);
Vq_y = interp3(trans_grid.x,trans_grid.y',trans_grid.z,Vy,xq,yq,zq);
Vq_z = interp3(trans_grid.x,trans_grid.y',trans_grid.z,Vz,xq,yq,zq);


%Final positions(- because the displacement is the dinstance vector from the fixed to the moved)
xq_t=xq-Vq_x;
yq_t=yq-Vq_y;
zq_t=zq-Vq_z;

ptCloud  = pointCloud([xq yq zq],'Color',repmat([0 1 1],size(xq,1),1));
ptCloud_t= pointCloud([xq_t yq_t zq_t],'Color',repmat(	[1 0 0],size(xq,1),1));
figure();pcshow(ptCloud);hold on;pcshow(ptCloud_t)
xlabel('x');ylabel('y');zlabel('z');
legend('Reference mesh','Registered reference mesh')
ax = gca;
ax.Color='k';
hold off;

%ind=main(ptCloud_t);

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
