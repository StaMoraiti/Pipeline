mouse=1;
week=18;
NS=10;
res=10.4;
for NS=10
pathres="G:\Shared drives\Matina_Emily\Emily_folder\Emilycode\ShIRTMResults\"; % EMILY
pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\');
%pathNS=strcat(sprintf('%d',dl),'voxels\','NodeSpacing',sprintf('%d',NS),'\');
pathNS='LocalDeform_2.5\Mode_Deformation\';
cd(strcat(pathres,pathSpec,pathNS));

% Loads the ShIRT outpout (interpolated to the Image Points) 
filename1='ImposedMode.mat';
load(filename1);

pathNS1='2voxels\NodeSpacing5';
pathres1="G:\Shared drives\Matina_Emily\Emily_folder\Emilycode\ShIRTMResults\"; % EMILY
cd(strcat(pathres,pathSpec,pathNS1))
filename=sprintf('BoundaryArea_ML%dW%d',mouse,week);
load(filename,'ind_b');% p1=[x y z]
len = length(ind_b);

d_hat3D=repmat(d_hat,[1,1,175]);
dhat_s1=[];
for m=1:size(ind_b,1)
    d_slice=d_hat3D(:,:,ind_b(m,3));
    dhat_s1=[dhat_s1;d_slice(ind_b(m,1),ind_b(m,2))];
end
 
histogram(dhat_s1,40)
thr=100*mean(dhat_s1)/5;
for mouse=[1 2 3 4 5 6]
       pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\');
       pathNS=strcat('LocalDeform_2.5\Mode_Deformation\','NodeSpacing',sprintf('%d',NS),'\');
       cd(strcat(pathres1,pathSpec,pathNS));
       filename=strcat('ErrorsS_Boundary',sprintf('ML%dW%dV',mouse,week),'2_5');
       load(filename, 'ErrorS_avL', 'ErrorS_stdL');
       Acc_ErrV2_5grLocMode(1,mouse)=ErrorS_avL; Pr_ErrV2_5grLocMode(1,mouse)=ErrorS_stdL;
end
Acc_ErMu_N2_5grLocMode=median(Acc_ErrV2_5grLocMode,2)/res;Pr_ErMu_N2_5grLocMode=mean(Pr_ErrV2_5grLocMode,2)/res;
if abs(Acc_ErMu_N2_5grLocMode)<thr && Pr_ErMu_N2_5grLocMode<thr
    sprintf('The optimum NS is: %d voxels',NS)
end
end

