mouse=[1 2 3 4 5 6];
week=18;

for i=1:size(mouse,2)
    for NS=5
pathres="G:\Shared drives\Matina_Emily\Emily_folder\Emilycode\ShIRTMResults\"; % EMILY
pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
%pathNS=strcat(sprintf('%d',dl),'voxels\','NodeSpacing',sprintf('%d',NS),'\');
pathNS=strcat('LocalDeform_2.5\Mode_Deformation\','NodeSpacing',sprintf('%d',NS),'\');
cd(strcat(pathres,pathSpec,pathNS));

% Loads the ShIRT outpout (interpolated to the Image Points) 
filename1=strcat('NSens_surface_displ_ML',num2str(mouse(i)),'W',num2str(week));
load(filename1);
d1 = [Vq_x Vq_y Vq_z];
pathNS1='2voxels\NodeSpacing5';
pathres1="G:\Shared drives\Matina_Emily\Emily_folder\Emilycode\ShIRTMResults\"; % EMILY
cd(strcat(pathres,pathSpec,pathNS1))
filename=sprintf('BoundaryArea_ML%dW%d',mouse(i),week);
load(filename,'ind_b','p1_b');% p1=[x y z]
len = length(ind_b);

[z,k1]=unique(p1_b(:,3));[slice,k]=unique(ind_b(:,3));
z1=z(30);z2=z(60);z3=z(90);z4=z(120);z5=z(139);
p1_slice1=p1_b(k1(30):k1(31)-1,:);p1_slice2=p1_b(k(60):k(61)-1,:);p1_slice3=p1_b(k(90):k(91)-1,:);p1_slice4=p1_b(k(120):k(121)-1,:);
p1_slice5=p1_b(k(139):end,:);% points on these slices
ind_slice1=ind_b(k(30):k(31)-1,:);ind_slice2=ind_b(k(60):k(61)-1,:);ind_slice3=ind_b(k(90):k(91)-1,:);ind_slice4=ind_b(k(120):k(121)-1,:);
ind_slice5=ind_b(k(139):end,:);% index of points on these slices
%dd= sqrt(d1(:,1).^2 + d1(:,2).^2 + d1(:,3).^2);% magnitude
d_xorder=reshape(d1(:,1),[316,326*175]);
dx_3D=reshape(d_xorder,[316,326,175]);% REMEMBER TO TRANSPOSE EACH SLICE- SOS!!! 3D matrix of displacement on x
d_yorder=reshape(d1(:,2),[316,326*175]);
dy_3D=reshape(d_yorder,[316,326,175]);% REMEMBER TO TRANSPOSE EACH SLICE- SOS!!! 3D matrix of displacement on y
d_zorder=reshape(d1(:,3),[316,326*175]);
dz_3D=reshape(d_zorder,[316,326,175]);% REMEMBER TO TRANSPOSE EACH SLICE- SOS!!! 3D matrix of displacement on z

%ind=[y x z]=[j i k]
dx_s1=[];dy_s1=[];dz_s1=[];
for m=1:size(ind_slice1,1)
    dx_slice=dx_3D(:,:,ind_slice1(m,3))';
    dx_s1=[dx_s1;dx_slice(ind_slice1(m,1),ind_slice1(m,2))];
    dy_slice=dy_3D(:,:,ind_slice1(m,3))';
    dy_s1=[dy_s1;dy_slice(ind_slice1(m,1),ind_slice1(m,2))];  
    dz_slice=dz_3D(:,:,ind_slice1(m,3))';
    dz_s1=[dz_s1;dz_slice(ind_slice1(m,1),ind_slice1(m,2))]; 
end
dx_s2=[];dy_s2=[];dz_s2=[];
for m=1:size(ind_slice2,1)
    dx_slice=dx_3D(:,:,ind_slice2(m,3))';
    dx_s2=[dx_s2;dx_slice(ind_slice2(m,1),ind_slice2(m,2))];
    dy_slice=dy_3D(:,:,ind_slice2(m,3))';
    dy_s2=[dy_s2;dy_slice(ind_slice2(m,1),ind_slice2(m,2))];  
    dz_slice=dz_3D(:,:,ind_slice2(m,3))';
    dz_s2=[dz_s2;dz_slice(ind_slice2(m,1),ind_slice2(m,2))]; 
end
dx_s3=[];dy_s3=[];dz_s3=[];
for m=1:size(ind_slice3,1)
    dx_slice=dx_3D(:,:,ind_slice3(m,3))';
    dx_s3=[dx_s3;dx_slice(ind_slice3(m,1),ind_slice3(m,2))];
    dy_slice=dy_3D(:,:,ind_slice3(m,3))';
    dy_s3=[dy_s3;dy_slice(ind_slice3(m,1),ind_slice3(m,2))];  
    dz_slice=dz_3D(:,:,ind_slice3(m,3))';
    dz_s3=[dz_s3;dz_slice(ind_slice3(m,1),ind_slice3(m,2))]; 
end
dx_s4=[];dy_s4=[];dz_s4=[];
for m=1:size(ind_slice4,1)
    dx_slice=dx_3D(:,:,ind_slice4(m,3))';
    dx_s4=[dx_s4;dx_slice(ind_slice4(m,1),ind_slice4(m,2))];
    dy_slice=dy_3D(:,:,ind_slice4(m,3))';
    dy_s4=[dy_s4;dy_slice(ind_slice4(m,1),ind_slice4(m,2))];  
    dz_slice=dz_3D(:,:,ind_slice4(m,3))';
    dz_s4=[dz_s4;dz_slice(ind_slice4(m,1),ind_slice4(m,2))]; 
end
dx_s5=[];dy_s5=[];dz_s5=[];
for m=1:size(ind_slice5,1)
    dx_slice=dx_3D(:,:,ind_slice5(m,3))';
    dx_s5=[dx_s5;dx_slice(ind_slice5(m,1),ind_slice5(m,2))];
    dy_slice=dy_3D(:,:,ind_slice5(m,3))';
    dy_s5=[dy_s5;dy_slice(ind_slice5(m,1),ind_slice5(m,2))];  
    dz_slice=dz_3D(:,:,ind_slice5(m,3))';
    dz_s5=[dz_s5;dz_slice(ind_slice5(m,1),ind_slice5(m,2))]; 
end
figure()
plot3(p1_slice1(:,1),p1_slice1(:,2),p1_slice1(:,3),'k.','markersize',3);hold on;
plot3(p1_slice2(:,1),p1_slice2(:,2),p1_slice2(:,3),'k.','markersize',3);hold on;
plot3(p1_slice3(:,1),p1_slice3(:,2),p1_slice3(:,3),'k.','markersize',3);hold on;
plot3(p1_slice4(:,1),p1_slice4(:,2),p1_slice4(:,3),'k.','markersize',3);hold on;
plot3(p1_slice5(:,1),p1_slice5(:,2),p1_slice5(:,3),'k.','markersize',3);hold on;

p2_slice1_x=p1_slice1(:,1)+dx_s1;p2_slice1_y=p1_slice1(:,2)+dy_s1;p2_slice1_z=p1_slice1(:,3)+dz_s1;
p2_slice2_x=p1_slice2(:,1)+dx_s2;p2_slice2_y=p1_slice2(:,2)+dy_s2;p2_slice2_z=p1_slice2(:,3)+dz_s2;
p2_slice3_x=p1_slice3(:,1)+dx_s3;p2_slice3_y=p1_slice3(:,2)+dy_s3;p2_slice3_z=p1_slice3(:,3)+dz_s3;
p2_slice4_x=p1_slice4(:,1)+dx_s4;p2_slice4_y=p1_slice4(:,2)+dy_s4;p2_slice4_z=p1_slice4(:,3)+dz_s4;
p2_slice5_x=p1_slice5(:,1)+dx_s5;p2_slice5_y=p1_slice5(:,2)+dy_s5;p2_slice5_z=p1_slice5(:,3)+dz_s5;
p2_sl1=[p2_slice1_x p2_slice1_y p2_slice1_z];
p2_sl2=[p2_slice2_x p2_slice2_y p2_slice2_z];
p2_sl3=[p2_slice3_x p2_slice3_y p2_slice3_z];
p2_sl4=[p2_slice4_x p2_slice4_y p2_slice4_z];
p2_sl5=[p2_slice5_x p2_slice5_y p2_slice5_z];

Xp1=[p1_slice1(:,1) p2_sl1(:,1)];Yp1=[p1_slice1(:,2) p2_sl1(:,2)];Zp1=[p1_slice1(:,3) p2_sl1(:,3)];
Xp2=[p1_slice2(:,1) p2_sl2(:,1)];Yp2=[p1_slice2(:,2) p2_sl2(:,2)];Zp2=[p1_slice2(:,3) p2_sl2(:,3)];
Xp3=[p1_slice3(:,1) p2_sl3(:,1)];Yp3=[p1_slice3(:,2) p2_sl3(:,2)];Zp3=[p1_slice3(:,3) p2_sl3(:,3)];
Xp4=[p1_slice4(:,1) p2_sl4(:,1)];Yp4=[p1_slice4(:,2) p2_sl4(:,2)];Zp4=[p1_slice4(:,3) p2_sl4(:,3)];
Xp5=[p1_slice5(:,1) p2_sl5(:,1)];Yp5=[p1_slice5(:,2) p2_sl5(:,2)];Zp5=[p1_slice5(:,3) p2_sl5(:,3)];

plot3(Xp1',Yp1',Zp1','-b');hold on;
plot3(Xp2',Yp2',Zp2','-b');hold on;
plot3(Xp3',Yp3',Zp3','-b');hold on;
plot3(Xp4',Yp4',Zp4','-b');hold on;
plot3(Xp5',Yp5',Zp5','-b');hold on;

plot3(p2_sl1(:,1),p2_sl1(:,2),p2_sl1(:,3),'b.','markersize',5);hold on;
plot3(p2_sl2(:,1),p2_sl2(:,2),p2_sl2(:,3),'b.','markersize',5);hold on;
plot3(p2_sl3(:,1),p2_sl3(:,2),p2_sl3(:,3),'b.','markersize',5);hold on;
plot3(p2_sl4(:,1),p2_sl4(:,2),p2_sl4(:,3),'b.','markersize',5);hold on;
plot3(p2_sl5(:,1),p2_sl5(:,2),p2_sl5(:,3),'b.','markersize',5);hold on;

fx= gradient(dx_s5); fy=gradient(dy_s5); fz=gradient(dz_s5);
figure()
plot(p1_slice5(:,1),-p1_slice5(:,2),'k.','markersize',5),hold on;
quiver(p1_slice5(:,1),-p1_slice5(:,2),fx,zeros(size(fy)))
    
    end
end


