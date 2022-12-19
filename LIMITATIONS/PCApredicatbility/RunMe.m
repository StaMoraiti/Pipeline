%% This function applies the leave-one mouse-out tests
%1) Deletes one mouse= 2 timepoints-observations
%2) Applies the PCA of the limited database
%3) Projects the mouse-out in the PCA space
%4) Calculates the point-to-point distance

clear all;
clc;
dir_codes=pwd;
MainPath='G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\';
SubPath= 'PCA\MAIN\';
cd(strcat(MainPath,SubPath))
load('PCAinput.mat');

cd(dir_codes)
% which mouse I delete:
limX1=[inputX(2:6,:);inputX(8:end,:)];
limX2=[inputX(1,:);inputX(3:6,:);inputX(7,:);inputX(9:end,:)];
limX3=[inputX(1:2,:);inputX(4:6,:);inputX(7:8,:);inputX(10:end,:)];
limX4=[inputX(1:3,:);inputX(5:6,:);inputX(7:9,:);inputX(11:end,:)];
limX5=[inputX(1:4,:);inputX(6,:);inputX(7:10,:);inputX(end,:)];
limX6=[inputX(1:5,:);inputX(7:end-1,:)];

% PCA:
coeff1= pca(limX1);
coeff2= pca(limX2);
coeff3= pca(limX3);
coeff4= pca(limX4);
coeff5= pca(limX5);
coeff6= pca(limX6);

% Calculates the scores for the new geometry
[Er1t1,Er1t2]=constr_Error(inputX,coeff1,1);
[Er2t1,Er2t2]=constr_Error(inputX,coeff2,2);
[Er3t1,Er3t2]=constr_Error(inputX,coeff3,3);
[Er4t1,Er4t2]=constr_Error(inputX,coeff4,4);
[Er5t1,Er5t2]=constr_Error(inputX,coeff5,5);
[Er6t1,Er6t2]=constr_Error(inputX,coeff6,6);


function [Ert1,Ert2,Ert1_m,Ert2_m,Ert1_s,Ert2_s]=constr_Error(inputX,coeff,mouse)
for i=1:size(coeff,2)
 a1t1(i)=dot(inputX(mouse,:)-mean(inputX),coeff(:,i));
 a1t2(i)=dot(inputX(mouse+6,:)-mean(inputX),coeff(:,i));
end

% Projection
SP1t1=mean(inputX)';
SP1t2=mean(inputX)';
for i=1:size(coeff,2)
  SP1t1=SP1t1+a1t1(i)*coeff(:,i);
  SP1t2=SP1t2+a1t2(i)*coeff(:,i);
end
GT1=reshape(inputX(mouse,:)',[9125,3]);
SPT1=reshape(SP1t1,[9125,3]);
GT2=reshape(inputX(mouse+6,:)',[9125,3]);
SPT2=reshape(SP1t2,[9125,3]);
% Surface Error
D=@(A,B)sqrt((A(:,1)-B(:,1)).^2+(A(:,2)-B(:,2)).^2+(A(:,3)-B(:,3)).^2);
Ert1=D(GT1,SPT1); Ert1_m=mean(Ert1); Ert1_s=std(Ert1); Q3t1=quantile(Ert1,0.9);
Ert2=D(GT2,SPT2); Ert2_m=mean(Ert2); Ert2_s=std(Ert2); Q3t2=quantile(Ert2,0.9);
cd()
filename=sprintf('ErrorStatsM%d',mouse);
save(filename,"Ert2","Ert2_s","Ert2_m","Ert1_s","Ert1_m","Ert1");

end






