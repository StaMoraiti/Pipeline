mouse=[1 2 3 5 6];
res=10.4;
week=18;
NS=[5:5:50];
pathres1="G:\Shared drives\Matina_Emily\Emily_folder\Emilycode\ShIRTMResults\";
%pathres2="G:\Shared drives\Matina_Emily\Emily_folder\Code\ShIRTM\Results\";

Acc_Err=[];Pr_Err=[];
Acc_ErMu=[];Pr_ErMu=[];
for j=1:length(NS)
   for i=1:length(mouse)
       
       pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
       pathNS=strcat('Method2\','NodeSpacing',sprintf('%d',NS(j)),'\'); 
       cd(strcat(pathres1,pathSpec,pathNS));
       filename=strcat('Errors_HD',sprintf('ML%dW%d',mouse(i),week));
       load(filename);

       Acc_Err(j,i)=hd*1000;Pr_Err(j,i)=hds*1000;
   end
end
Acc_ErMu=median(Acc_Err,2)/res;
Pr_ErMu=median(Pr_Err,2)/res;
figure(1)
plot(NS,Acc_ErMu,'b-','LineWidth', 1.7);
set(gca, 'FontSize', 12)
xlabel('Nodal Spacing (voxels)')
ylabel('Hausdorff distance(voxels)')
title('Error associated to Accuracy')
cd(strcat(pathres1,'NSensitivity\Figures'))
savefig(figure(1),'accuracyHDMethod2.fig')
figure(2)
plot(NS,Pr_ErMu,'b-','LineWidth', 1.7);
set(gca, 'FontSize', 12)
xlabel('Nodal Spacing (voxels)')
ylabel('Hausdorff distance (voxels)')
title('Error associated to Precision')
cd(strcat(pathres1,'NSensitivity\Figures'))
savefig(figure(2),'precisionHDMethod2.fig')