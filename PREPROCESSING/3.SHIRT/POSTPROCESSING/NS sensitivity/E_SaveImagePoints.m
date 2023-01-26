cd("G:\Shared drives\Matina_Emily\Emily_folder\Emilycode\ShIRTMResults\NSensitivity\ML6\ML6W18\LocalDeform_2.5\Local\NodeSpacing5")
load('PointsImage.mat')
filename = strcat('PointsImage');
week=18;
%NS=[5 10 15 20 25 30 35 40 45 50];
dl=[2.5];
%mouse=[1 2 3 4 5 6];
NS=[5:5:50];
mouse=[1 2 3 4 5 6];
for i=1:length(mouse)
    for j=1:length(dl)
        for k=1:length(NS)
            pathres="G:\Shared drives\Matina_Emily\Emily_folder\Emilycode\ShIRTMResults\"; % EMILY
            pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
            pathNS=strcat('\LocalDeform_2.5\Mode_Deformation\','NodeSpacing',sprintf('%d',NS(k)),'\');
            cd(strcat(pathres,pathSpec,pathNS));
            save(filename, 'p1')
        end
    end
end

