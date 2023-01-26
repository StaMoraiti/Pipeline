
mouse = [1 2 3 4 5 6];
dl=2.5;
week=18;
NS = [5:5:50];
parpool(4)

parfor i = 1:length(mouse)
    for j = 1:length(dl)
        for k = 1:length(NS)
        %parfor k = 1:length(NS)
            cd("G:\Shared drives\Matina_Emily\Emily_folder\Emilycode\")            
            M_av_sd_AllNodes_Limited(mouse(i),18,dl(j),NS(k));
        end
    end
end

