clear all;
dir_codes=pwd;
cd ('../OUTPUTS')
load('PCA_results1.mat')%coeff score latent

cd('../MAIN');
load('PCAinput.mat') %inputX

mu_shape.nodes=reshape(mean(inputX),[9125,3]);
cd(dir_codes)
surface= ExtractedSurface2;
mu_shape.elements=surface.faces;

% mode1=reshape(coeff(:,1),[9125,3]);
% mode2=reshape(coeff(:,2),[9125,3]);
% jobPath=dir_codes;
% jobName='3DMode2_1';
% WriteVtk(jobPath, jobName, mu_shape, mode2);

%Mean profile of the time point w18
x1_t1=mean(inputX)'+min(score(:,2))*coeff(:,2);
mu_t1.nodes=reshape(x1_t1,[9125,3]);
mu_t1.elements=surface.faces;
%Mean profile of the time point w24
x1_t2=mean(inputX)'+2*max(score(:,2))*coeff(:,2);
mu_t2.nodes=reshape(x1_t2,[9125,3]);
mu_t2.elements=surface.faces;

d=x1_t2-x1_t1;change1=reshape(d,[9125,3]);
jobPath=dir_codes;
jobName1='3dbefore_M2';
jobName2='3Dafter2_M2';
WriteVtk(jobPath, jobName1, mu_t1, change1);
WriteVtk(jobPath, jobName2, mu_t2, change1);

