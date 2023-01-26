%% Load data

% mouse=[1 2 3 4 5 6];
% week=[18];
% dl=[2 4];
% N = NS=[5 10 15 20 25 30 35 40 45 50];
%% Function 

function ShIRToutputmap_code(mouse,week,dl,NS) 

pathRes="G:\Shared drives\Matina_Emily\Emily_folder\Emilycode\ShIRTMResults\NSensitivity\"; % EMILY
pathSpec= strcat(sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\');
pathNS=strcat('\LocalDeform_2.5\Mode_Deformation\','NodeSpacing',sprintf('%d',NS),'\');

cd(strcat(pathRes,pathSpec,pathNS));
filename=strcat('output_map4'); % EMILY

T = readtable('output_map4');
grid_dxdydz=table2array(T);
filname = strcat(sprintf('ML%dW%d',mouse,week),'_ShIRToutputmap');
save(filname,'grid_dxdydz')
clear all
% end

% NS=[5 10 15 20 25 30 35 40 45 50];
% dl=[2 4];
% mouse=[1 2 3 4 5 6];
% week = 18;
% for i=1:length(mouse)
%     for j=1:length(dl)
%         for k=1:length(NS)
%             pathres="C:\Users\emily\OneDrive\Documents\insigneo\Code\ShIRTMResults\"; % EMILY
%             pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
%             pathNS=strcat(sprintf('%d',dl(j)),'voxels\','milimetersNodeSpacing',sprintf('%d',NS(k)),'\');
%             cd(strcat(pathres,pathSpec,pathNS));
%             filename=strcat('output_map4');
%             T = readtable('output_map4');
%             grid_dxdydz=table2array(T);
%             filname = strcat(sprintf('ML%dW%d',mouse(i),week),'_ShIRToutputmap');
%             save(filname,'grid_dxdydz')
%             clear all
%         end
%     end
% end

%surface_displacements

% ------------------- (save ML2W18_ShIRToutputmap grid_dxdydz)



% ctrl r %comment
% ctrl t %uncomment