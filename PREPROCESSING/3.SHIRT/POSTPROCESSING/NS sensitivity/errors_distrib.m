mouse=1;week=18;
pathNS1='2voxels\NodeSpacing5';
pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\');
pathres1="G:\Shared drives\Matina_Emily\Emily_folder\Emilycode\ShIRTMResults\"; % EMILY
cd(strcat(pathres1,pathSpec,pathNS1))
filename=sprintf('BoundaryArea_ML%dW%d',mouse,week);
load(filename,'ind_b');
len = length(ind_b);

filename2='PointsImage';
load(filename2,'p1');
Xco=repmat(p1(1:316,1)',[326,1]); % separate the coordinates
Yco=repmat(unique(p1(:,2)),[1,316]);
Zco=unique(p1(:,3));


PP_B=[];%[X Y Z]
for m=1:size(ind_b,1)
    PP_B=[PP_B;Xco(ind_b(m,1),ind_b(m,2)) Yco(ind_b(m,1),ind_b(m,2)) Zco(ind_b(m,3))];
end

h(1) = plot3(PP_B(:,1),PP_B(:,2),PP_B(:,3),'bx','markersize',2,'linewidth',3);hold on;

cd("G:\Shared drives\Matina_Emily\Emily_folder\Emily's code\ShIRTMResults\NSensitivity\ML1\ML1W18\LocalDeform_2.5\NodeSpacing5");
load("ErrorsS_BoundaryML1W18V2_5.mat")
Xe=[PP_B(:,1)+ErrorS(:,1)*10^(-3) PP_B(:,1)];
Ye=[PP_B(:,2)+ErrorS(:,1)*10^(-3) PP_B(:,2)];
Ze=[PP_B(:,3)+ErrorS(:,1)*10^(-3) PP_B(:,3)];
plot3(Xe',Ye',Ze','-r');





