% isnan(Vq_z)==1; %puts NaN values =1
% find(ans==1);
% find(isnan(Vq_z)==1);

%cd('C:\Users\emily\OneDrive\Documents\insigneo\Code\ShIRTMResults\NSensitivity\ML1\ML1W18\2voxels\milimetersNodeSpacing5')
% load('PointsImage.mat')
% filename = strcat('PointsImage');

week=18;
NS=[10];
dl=[2 4];
mouse=[1 2 3 4 5 6];

for i=1:length(mouse)
    for j=1:length(dl)
        for k=1:length(NS)
            pathres="G:\My Drive\PhD\Other Projects\Insigneo Sumer Programme\Emily_folder\Emily's code\ShIRTMResults\"; % EMILY
            pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
            pathNS=strcat(sprintf('%d',dl(j)),'voxels','\interp\',sprintf('NodeSpacing%d',N),'\');
            cd(strcat(pathres,pathSpec,pathNS));
            filename = strcat('NSens_surface_displ_',sprintf('ML%dW%d',mouse(i),week));
            load(filename)
            NaN = find(isnan(Vq_z)==1)
            %print(NaN)
        end
    end
end