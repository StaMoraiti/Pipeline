clear all;
dir_codes=pwd;
mouse=[1 2 3 5 6];week=18;
NS=[5:5:50];
%ShIRT results directory:
pathres='G:\Shared drives\Matina_Emily\Emily_folder\Emilycode\ShIRTMResults\';
for i=1:size(mouse,2)
    for j=1:size(NS,2)
        
        pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
        pathNS=strcat('Method2\','NodeSpacing',sprintf('%d',NS(j)),'\');
        cd(strcat(pathres,pathSpec,pathNS));
        load('MappedSurf.mat')
        mesh1.nodes=MapSurf{i,j}.vertices;
        mesh1.elements=MapSurf{i,j}.faces;
        mesh2.nodes=TargetSurf.vertices;
        mesh2.elements=TargetSurf.faces;
        jobName1='Mapped';
        jobName2='Target';
        jobPath=strcat(pathres,pathSpec,pathNS);
        cd(dir_codes)
        M_WriteVtk(jobPath, jobName1, mesh1);
        M_WriteVtk(jobPath, jobName2, mesh2);

    end
end
        