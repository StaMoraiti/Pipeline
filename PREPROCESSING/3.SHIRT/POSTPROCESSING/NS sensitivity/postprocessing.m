mouse=[1 2 3 4 5 6];

week=18;
NS=[5:5:50];
pathres1="G:\Shared drives\Matina_Emily\Emily_folder\Emilycode\ShIRTMResults\";
%pathres2="G:\Shared drives\Matina_Emily\Emily_folder\Code\ShIRTM\Results\";

Acc_ErrV2=[];Pr_ErrV2=[];
Acc_ErMu_N2=[];Pr_ErMu_N2=[];
Acc_ErrV4=[];Pr_ErrV4=[];
Acc_ErMu_N4=[];Pr_ErMu_N4=[];
Acc_ErrV6=[];Pr_ErrV6=[];
Acc_ErMu_N6=[];Pr_ErMu_N6=[];
Acc_ErrV2_5=[];Pr_ErrV2_5=[];
Acc_ErrV2_5gr=[];Pr_ErrV2_5gr=[];
Acc_ErrV2_5grLoc=[];Pr_ErrV2_5grLoc=[];
Acc_ErrV2_4=[];Pr_ErrV2_4=[];
Acc_ErrV2_5grLocMore=[];Pr_ErrV2_5grLocMore=[];
Acc_ErrV2_5grLoc85=[];Pr_ErrV2_5grLoc85=[];
Acc_ErrV2_5grLoc115=[];Pr_ErrV2_5grLoc115=[];
Acc_ErrV2_5grLocMode=[];Pr_ErrV2_5grLocMode=[];
for j=1:length(NS)
   for i=1:length(mouse)
%        dl=2;
%        pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
%        pathNS=strcat(sprintf('%d',dl),'voxels\','NodeSpacing',sprintf('%d',NS(j)),'\'); 
%        cd(strcat(pathres1,pathSpec,pathNS));
%        filename=strcat('ErrorsS_Lim',sprintf('ML%dW%dV%d%',mouse(i),week,dl));
%        load(filename, 'ErrorS_avL', 'ErrorS_stdL');
%        Acc_ErrV2(j,i)=ErrorS_avL;Pr_ErrV2(j,i)=ErrorS_stdL;

       dl=2.5;
       pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
       pathNS=strcat(sprintf('%g\n',dl),'voxelsGREY\','NodeSpacing',sprintf('%d',NS(j)),'\');
       cd(strcat(pathres1,pathSpec,pathNS));
       filename=strcat('ErrorsS_Lim',sprintf('ML%dW%dV',mouse(i),week),'2_5');
       load(filename, 'ErrorS_avL', 'ErrorS_stdL');
       Acc_ErrV2_5gr(j,i)=ErrorS_avL; Pr_ErrV2_5gr(j,i)=ErrorS_stdL;

       dl=2.5;
       pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
       pathNS=strcat('LocalDeform_2.5\','NodeSpacing',sprintf('%d',NS(j)),'\');
       cd(strcat(pathres1,pathSpec,pathNS));
       filename=strcat('ErrorsS_Boundary',sprintf('ML%dW%dV',mouse(i),week),'2_5');
       load(filename, 'ErrorS_avL', 'ErrorS_stdL');
       Acc_ErrV2_5grLoc(j,i)=ErrorS_avL; Pr_ErrV2_5grLoc(j,i)=ErrorS_stdL;
       
       
       pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
       pathNS=strcat('LocalDeform_2.5\Mode_Deformation\','NodeSpacing',sprintf('%d',NS(j)),'\');
       cd(strcat(pathres1,pathSpec,pathNS));
       filename=strcat('ErrorsS_Boundary',sprintf('ML%dW%dV',mouse(i),week),'2_5');
       load(filename, 'ErrorS_avL', 'ErrorS_stdL');
       Acc_ErrV2_5grLocMode(j,i)=ErrorS_avL; Pr_ErrV2_5grLocMode(j,i)=ErrorS_stdL;

       dl=2.5;
       pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
       pathNS=strcat('LocalDeform_2.5\Local\','NodeSpacing',sprintf('%d',NS(j)),'\');
       cd(strcat(pathres1,pathSpec,pathNS));
       filename=strcat('ErrorsS_Boundary',sprintf('ML%dW%dV',mouse(i),week),'2_5');
       load(filename, 'ErrorS_avL', 'ErrorS_stdL');
       Acc_ErrV2_5grLocMore(j,i)=ErrorS_avL; Pr_ErrV2_5grLocMore(j,i)=ErrorS_stdL;

       dl=2.5;
       pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
       pathNS=strcat('LocalDeform_2.5\Local85\','NodeSpacing',sprintf('%d',NS(j)),'\');
       cd(strcat(pathres1,pathSpec,pathNS));
       filename=strcat('ErrorsS_Boundary',sprintf('ML%dW%dV',mouse(i),week),'2_5');
       load(filename, 'ErrorS_avL', 'ErrorS_stdL');
       Acc_ErrV2_5grLoc85(j,i)=ErrorS_avL; Pr_ErrV2_5grLoc85(j,i)=ErrorS_stdL;

       dl=2.5;
       pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
       pathNS=strcat('LocalDeform_2.5\Local115\','NodeSpacing',sprintf('%d',NS(j)),'\');
       cd(strcat(pathres1,pathSpec,pathNS));
       filename=strcat('ErrorsS_Boundary',sprintf('ML%dW%dV',mouse(i),week),'2_5');
       load(filename, 'ErrorS_avL', 'ErrorS_stdL');
       Acc_ErrV2_5grLoc115(j,i)=ErrorS_avL; Pr_ErrV2_5grLoc115(j,i)=ErrorS_stdL;

       dl=2.5;
       pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
       pathNS=strcat(sprintf('%g\n',dl),'voxelsRULE\','NodeSpacing',sprintf('%d',NS(j)),'\');
       cd(strcat(pathres1,pathSpec,pathNS));
       filename=strcat('ErrorsS_Boundary',sprintf('ML%dW%dV',mouse(i),week),'2_5');
       load(filename, 'ErrorS_avL', 'ErrorS_stdL');
       Acc_ErrV2_5(j,i)=ErrorS_avL; Pr_ErrV2_5(j,i)=ErrorS_stdL;
       
%        pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
%        pathNS=strcat('2xy_4zvoxels\','NodeSpacing',sprintf('%d',NS(j)),'\');
%        cd(strcat(pathres1,pathSpec,pathNS));
%        filename=strcat('ErrorsS_Lim',sprintf('ML%dW%dV',mouse(i),week),'2xy_4z');
%        load(filename, 'ErrorS_avL', 'ErrorS_stdL');
%        Acc_ErrV2_4(j,i)=ErrorS_avL; Pr_ErrV2_4(j,i)=ErrorS_stdL;
%        
%        dl=4;
%        pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
%        pathNS=strcat(sprintf('%d',dl),'voxels\','NodeSpacing',sprintf('%d',NS(j)),'\'); 
%        cd(strcat(pathres1,pathSpec,pathNS));
%        filename=strcat('ErrorsS_Lim',sprintf('ML%dW%dV%d',mouse(i),week,dl));
%        load(filename, 'ErrorS_avL', 'ErrorS_stdL');
%        Acc_ErrV4(j,i)=ErrorS_avL;Pr_ErrV4(j,i)=ErrorS_stdL;
%        dl=6;
%        pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse(i)),'\',sprintf('ML%dW%d',mouse(i),week),'\');
%        pathNS=strcat(sprintf('%d',dl),'voxels\','NodeSpacing',sprintf('%d',NS(j)),'\'); 
%        cd(strcat(pathres1,pathSpec,pathNS));
%        filename=strcat('ErrorsS_Lim',sprintf('ML%dW%dV%d',mouse(i),week,dl));
%        load(filename, 'ErrorS_avL', 'ErrorS_stdL');
%        Acc_ErrV6(j,i)=ErrorS_avL;Pr_ErrV6(j,i)=ErrorS_stdL;
   end

end
%% Graphs
res=10.4;
figure(1)
% Acc_ErMu_N2=mean(Acc_ErrV2,2)/res;Acc_ErMu_N2_5=mean(Acc_ErrV2_5,2)/res;Acc_ErMu_N2_5gr=mean(Acc_ErrV2_5gr,2)/res;
% Acc_ErMu_N4=mean(Acc_ErrV4,2)/res;Acc_ErMu_N6=mean(Acc_ErrV6,2)/res;Acc_ErMu_N2_4=mean(Acc_ErrV2_4,2)/res;
Acc_ErMu_N2_5grLoc=median(Acc_ErrV2_5grLoc,2)/res;Acc_ErMu_N2_5grLocMore=median(Acc_ErrV2_5grLocMore,2)/res;
Acc_ErMu_N2_5grLoc85=median(Acc_ErrV2_5grLoc85,2)/res;Acc_ErMu_N2_5grLoc115=median(Acc_ErrV2_5grLoc115,2)/res;
Acc_ErMu_N2_5grLocMode=median(Acc_ErrV2_5grLocMode,2)/res;Acc_ErMu_N2_5gr=mean(Acc_ErrV2_5gr,2)/res;Acc_ErMu_N2_5=mean(Acc_ErrV2_5,2)/res;
% plot(NS,Acc_ErMu_N2_5,'Color',[0.6350 0.0780 0.1840],'LineWidth', 1.7);hold on;
% plot(NS,Acc_ErMu_N2_5gr,'Color',[0.8500 0.3250 0.0980],'LineWidth', 1.7);hold on;
plot(NS,Acc_ErMu_N2_5grLoc,'y-','LineWidth', 1.7);hold on;
plot(NS,Acc_ErMu_N2_5grLocMore,'b-','LineWidth', 1.7);hold on;
plot(NS,Acc_ErMu_N2_5grLoc85,'g-','LineWidth', 1.7);hold on;
plot(NS,Acc_ErMu_N2_5grLoc115,'r-','LineWidth', 1.7);hold on;
plot(NS,Acc_ErMu_N2_5grLocMode,'k-','LineWidth', 1.7);
legend('VT2+LD, Post: Half, Tcoef=0.95, MacS.D= 3vx','VT2+LD, Post: Smaller part, Tcoef=0.95','VT2+LD, Post: Smaller part, Tcoef=0.85','VT2+LD, Post: Smaller part, Tcoef=1.15','VT2+LD, Anter: Half, Observed dif: Tcoef=1.2, MaxS.D=12vx')
%legend('VT1: 2.5vx in Binary images','VT2: 2.5vx in grey images + binarization','VT2+LD, Post: Half, Tcoef=0.95, MacS.D= 3vx','VT2+LD, Post: Smaller part, Tcoef=0.95','VT2+LD, Post: Smaller part, Tcoef=0.85','VT2+LD, Post: Smaller part, Tcoef=1.15','VT2+LD, Anter: Half, Observed dif: Tcoef=1.2, MaxS.D=12vx')
% plot(NS,Acc_ErMu_N2_5grLoc,'Color',[0.6350 0.0780 0.1840],'LineWidth', 1.7);hold on;
% plot(NS,Acc_ErMu_N2_4,'y-','LineWidth', 1.7);hold on;
% plot(NS,Acc_ErMu_N2,'b-','LineWidth', 1.7);hold on;
% plot(NS,Acc_ErMu_N4,'g-','LineWidth', 1.7);hold on;
% plot(NS,Acc_ErMu_N6,'r-','LineWidth', 1.7);
% 
% legend('2.5 voxels in x-y, 2 in z','2.5 voxels in x-y, 2 in z, Greyscale','Local Deformation','2 voxels in x-y, 4 in z','2 voxels', '4 voxels', '6 voxels')
set(gca, 'FontSize', 12)
xlabel('Nodal Spacing (voxels)')
ylabel('Error of Accuracy (voxels)')
title('Effect of Voxel size and Nodal Spacing on accuracy ')
set(gcf, 'color', [1 1 1])
set(gca, 'Color',[1 1 1], 'XColor',[0 0 0], 'YColor',[0 0 0])
set(gca,'linewidth',2)
set(gca,'box','off')
cd(strcat(pathres1,'NSensitivity\Figures'))
savefig(figure(1),'accuracyLocal+Mode.fig')
% Pr_ErMu_N2=mean(Pr_ErrV2,2)/res;Pr_ErMu_N2_5=mean(Pr_ErrV2_5,2)/res;Pr_ErMu_N2_5gr=mean(Pr_ErrV2_5gr,2)/res;
% Pr_ErMu_N4=mean(Pr_ErrV4,2)/res;Pr_ErMu_N6=mean(Pr_ErrV6,2)/res;Pr_ErMu_N2_4=mean(Pr_ErrV2_4,2)/res;
Pr_ErMu_N2_5grLoc=mean(Pr_ErrV2_5grLoc,2)/res;Pr_ErMu_N2_5grLocMore=mean(Pr_ErrV2_5grLocMore,2)/res;
Pr_ErMu_N2_5grLoc85=mean(Pr_ErrV2_5grLoc85,2)/res;Pr_ErMu_N2_5grLoc115=mean(Pr_ErrV2_5grLoc115,2)/res;
Pr_ErMu_N2_5grLocMode=mean(Pr_ErrV2_5grLocMode,2)/res; Pr_ErMu_N2_5=mean(Pr_ErrV2_5,2)/res;Pr_ErMu_N2_5gr=mean(Pr_ErrV2_5gr,2)/res;
figure(2);
% plot(NS,Pr_ErMu_N2_5,'Color',[0.6350 0.0780 0.1840],'LineWidth', 1.7);hold on;
% plot(NS,Pr_ErMu_N2_5gr,'Color',[0.8500 0.3250 0.0980],'LineWidth', 1.7);hold on;
plot(NS,Pr_ErMu_N2_5grLoc,'y-','LineWidth', 1.7);hold on;
plot(NS,Pr_ErMu_N2_5grLocMore,'b-','LineWidth', 1.7);hold on;
plot(NS,Pr_ErMu_N2_5grLoc85,'g-','LineWidth', 1.7);hold on;
plot(NS,Pr_ErMu_N2_5grLoc115,'r-','LineWidth', 1.7);hold on;
plot(NS,Pr_ErMu_N2_5grLocMode,'k-','LineWidth', 1.7)
legend('VT2+LD, Post: Half, Tcoef=0.95, MacS.D= 3vx','VT2+LD, Post: Smaller part, Tcoef=0.95','VT2+LD, Post: Smaller part, Tcoef=0.85','VT2+LD, Post: Smaller part, Tcoef=1.15','VT2+LD, Anter: Half, Observed dif: Tcoef=1.2, MaxS.D=12vx')

%legend('VT1: 2.5vx in Binary images','VT2: 2.5vx in grey images + binarization','VT2+LD, Post: Half, Tcoef=0.95, MacS.D= 3vx','VT2+LD, Post: Smaller part, Tcoef=0.95','VT2+LD, Post: Smaller part, Tcoef=0.85','VT2+LD, Post: Smaller part, Tcoef=1.15','VT2+LD, Anter: Half, Observed dif: Tcoef=1.2, MaxS.D=12vx')

% semilogy(NS,Pr_ErMu_N2_5,'m-','LineWidth', 1.7);hold on;
% semilogy(NS,Pr_ErMu_N2_5gr,'k-','LineWidth', 1.7);hold on;
% semilogy(NS,Pr_ErMu_N2_5grLoc,'Color',[0.6350 0.0780 0.1840],'LineWidth', 1.7);hold on;
% semilogy(NS,Pr_ErMu_N2_4,'y-','LineWidth', 1.7);hold on;
% semilogy(NS,Pr_ErMu_N2,'b-','LineWidth', 1.7);hold on;
% semilogy(NS,Pr_ErMu_N4,'g-','LineWidth', 1.7);hold on;
% semilogy(NS,Pr_ErMu_N6,'r-','LineWidth', 1.7)
% %axis([5 50 10E-6 0.1]);
% legend('2.5 voxels in x-y, 2 in z','2.5 voxels in x-y, 2 in z, Greyscale','Local Deformation','2 voxels in x-y, 4 in z','2 voxels', '4 voxels', '6 voxels')
set(gca, 'FontSize', 12)
xlabel('Nodal Spacing (voxels)')
ylabel('Error of Precision (voxels)')
title('Effect of Voxel size and Nodal Spacing on Precision')
set(gcf, 'color', [1 1 1])
set(gca, 'Color',[1 1 1], 'XColor',[0 0 0], 'YColor',[0 0 0])
set(gca,'linewidth',2)
set(gca,'box','off')
cd(strcat(pathres1,'NSensitivity\Figures'))
savefig(figure(2),'precisionLocal+Mode.fig')
%% mini graph Accuracy 2.5 Voxels 
figure('Name','Accuracy: 2.5 Voxels, Resampling, Binarization & Local deformation effects')
plot(NS,Acc_ErMu_N2_5grLoc,'Color',[0.6350 0.0780 0.1840],'LineWidth', 1.7);hold on;
set(gca, 'FontSize', 12)
xlabel('Nodal Spacing (voxels)')
ylabel('Accuracy (voxels)')
title('Accuracy: 2.5 Voxels, Resampling, Binarization & Local deformation effects')
set(gcf, 'color', [1 1 1])
set(gca, 'Color',[1 1 1], 'XColor',[0 0 0], 'YColor',[0 0 0])
set(gca,'linewidth',2.5)
set(gca,'box','off')

%% mini graph Precision 2.5 Voxels 
figure('Name','Precision: 2.5 Voxels, Resampling, Binarization & Local deformation effects')
plot(NS,Pr_ErMu_N2_5grLoc,'Color',[0.6350 0.0780 0.1840],'LineWidth', 1.7);hold on;
set(gca, 'FontSize', 12)
xlabel('Nodal Spacing (voxels)')
ylabel('Precision (voxels)')
title('Precision: 2.5 Voxels, Resampling, Binarization & Local deformation effects ')
set(gcf, 'color', [1 1 1])
set(gca, 'Color',[1 1 1], 'XColor',[0 0 0], 'YColor',[0 0 0])
set(gca,'linewidth',2)
set(gca,'box','off')
