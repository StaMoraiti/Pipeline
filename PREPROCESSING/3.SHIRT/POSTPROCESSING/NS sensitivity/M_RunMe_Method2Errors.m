clear all;
mouse=[1 2 3 5 6];week=18;NS=[5:5:50];
dir_codes=pwd;
%ShIRT results directory:
pathres="G:\Shared drives\Matina_Emily\Emily_folder\Emilycode\ShIRTMResults\";
% Original mesh directory:
MeshPath='G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\LIMITATIONS\NODAL SPACING\DISPLACEMENT SENSITIVITY\MOUSE Differences_surfaces\DATA\';
cd(MeshPath);
 surfR=ml4w18;
 surf1=ml1w18;
 surf2=ml2w18;
 surf3=ml3w18;
 surf5=ml5w18;
 surf6=ml6w18;
 surfs={surfR surf1 surf2 surf3 surf5 surf6};
for i=1:size(mouse,2)
    for j=1:size(NS,2)
        
        pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
        pathNS=strcat('Method2\','NodeSpacing',sprintf('%d',NS(j)),'\');
        cd(strcat(pathres,pathSpec,pathNS));
        filename=strcat('NSens_surface_displ_ML',num2str(mouse(i)),'W',num2str(week));
        load(filename)
        cd(MeshPath);


        %Final positions(- because the displacement is the dinstance vector from the fixed to the moved)
        xq_t=surfs{1}.vertices(:,1)-Vq_x;
        yq_t=surfs{1}.vertices(:,2)-Vq_y;
        zq_t=surfs{1}.vertices(:,3)-Vq_z;
        MapSurf{i,j}.vertices=[xq_t yq_t zq_t];
        MapSurf{i,j}.faces=surfs{1}.faces;
        MapSurf{i,j}.spec=mouse(i);
        MapSurf{i,j}.NS=NS(j);

        TargetSurf= surfs{i+1};
        cd(strcat(pathres,pathSpec,pathNS));
        save MappedSurf MapSurf TargetSurf
        cd(dir_codes);
        %[NDcr,NDmu,NDstd]=NormalDist(surfs{i+1},MapSurf{i,j});
        [hd,hds,D,cP,cQ]= HausdorffDist(surfs{i+1}.vertices,MapSurf{i,j}.vertices,[],'visualize');

        cd(strcat(pathres,pathSpec,pathNS))
%         filename=strcat('Errors_ND',sprintf('ML%dW%d',mouse(i),week));
%         save(filename,'NDcr','NDmu','NDstd');
        filename=strcat('Errors_HD1',sprintf('ML%dW%d',mouse(i),week));
        save(filename,'hd','hds');

    end
end
