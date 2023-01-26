%Delete all files which are not ErrorsA

mouse = [1 2 3 4 5 6];
pathres="G:\Shared drives\Matina_Emily\Emily_folder\Emily's code\ShIRTMResults\"; % EMILY
dl = [2 4 6];
week=18;
%NS = [20 30 35 50];
NS = [5:5:50];
%parpool(4)

for i = 1:length(mouse)
    for j = 1:length(dl)
        %parfor k = 1:length(NS)
        for k = 1:length(NS)     
            pathSpec= strcat('NSensitivity\',sprintf('ML%d',(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
            pathNS=strcat(sprintf('%d',dl(j)),'voxels\','NodeSpacing',sprintf('%d',NS(k)),'\');
            %pathNS=strcat('2.5voxels\','NodeSpacing',sprintf('%d',NS(k)),'\');
            cd(strcat(pathres,pathSpec,pathNS));
            filename1=strcat('ErrorsR',sprintf('ML%dW%dV%d%NS%d',mouse(i),week,dl(j),NS(k)),'.mat');
            %filename1=strcat('ErrorsR',sprintf('ML%dW%d',mouse(i),week),'2_5',sprintf('NS%d',NS(k)));
            delete(filename1)
            filename2=strcat('Errors',sprintf('ML%dW%dV%d%NS%d',mouse(i),week,dl(j),NS(k)),'.mat');
            %filename2=strcat('Errors',sprintf('ML%dW%d',mouse(i),week),'2_5',sprintf('NS%d',NS(k)));
            delete (filename2)
        end
    end
end

