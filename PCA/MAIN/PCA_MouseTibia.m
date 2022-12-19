clear all;clc;
dir_codes=pwd;
load('PCAinput.mat')
[coeff,score,latent] = pca(inputX);
%cd(strcat(dir_codes,'\OUTPUTS'))
save PCA_results coeff score latent
movefile('PCA_results.mat',strcat(dir_codes,'\OUTPUTS')); 
%[Mode1_Cloud,Mode2_Cloud,Mode3_Cloud] = PCA_postprocessing(inputX,coeff,score,latent);

%% Group seperation
Score_t1.a=score(1:end/2,:); % Scores of the t1
Score_t2.a=score(end/2+1:end,:); % Scores of the t2
Score_t1.mu=mean(Score_t1.a); % Mean score of the t1
Score_t1.s=std(Score_t1.a);% Natural variability in t1 group
Score_t2.mu=mean(Score_t2.a);% Mean score of the t2
Score_t2.s=std(Score_t2.a);% Natural variability in t2 group
mu_change= abs(Score_t2.mu(:,1:3)-Score_t1.mu(:,1:3));% Mean difference between the groups
ss=sqrt(Score_t1.s(1,:).*Score_t2.s(1,:));% 
treat_eff=mu_change./ss(1,1:3);
%Mode1 in t1
x_1t1=mean(inputX)'+Score_t1.mu(:,1)*coeff(:,1);
%Mode1 in t2
x_1t2=mean(inputX)'+Score_t2.mu(:,1)*coeff(:,1);
%Mode2 in t1
x_2t1=mean(inputX)'+Score_t1.mu(:,2)*coeff(:,2);
%Mode2 in t2
x_2t2=mean(inputX)'+Score_t2.mu(:,2)*coeff(:,2);
%Mode3 in t1
x_3t1=mean(inputX)'+Score_t1.mu(:,3)*coeff(:,2);
%Mode3 in t2
x_3t2=mean(inputX)'+Score_t2.mu(:,3)*coeff(:,2);


MeanShape.t1= pointCloud(reshape(mean(inputX(1:end/2,:)),[9125,3]),'Color',repmat([1 0 0],9125,1));
MeanShape.t2= pointCloud(reshape(mean(inputX(end/2+1:end,:)),[9125,3]),'Color',repmat([0 0 1],9125,1));
figure();pcshow(MeanShape.t1);hold on;pcshow(MeanShape.t2);
Mode1_Cloud.t1mu  = pointCloud(reshape(x_1t1,[9125,3]),'Color',repmat([0 1 0],9125,1));
Mode1_Cloud.t2mu  = pointCloud(reshape(x_1t2,[9125,3]),'Color',repmat([1 0 0],9125,1));
Mode2_Cloud.t1mu  = pointCloud(reshape(x_2t1,[9125,3]),'Color',repmat([0 1 0],9125,1));
Mode2_Cloud.t2mu  = pointCloud(reshape(x_2t2,[9125,3]),'Color',repmat([1 0 0],9125,1));
Mode3_Cloud.t1mu  = pointCloud(reshape(x_3t1,[9125,3]),'Color',repmat([0 1 0],9125,1));
Mode3_Cloud.t2mu  = pointCloud(reshape(x_3t2,[9125,3]),'Color',repmat([1 0 0],9125,1));
figure();subplot(1,2,1);pcshow(Mode1_Cloud.t1mu,'MarkerSize', 15);hold on;pcshow(Mode1_Cloud.t2mu,'MarkerSize', 15);
title(sprintf('1st Mode Shape(%d)',6.07));xlabel('x');ylabel('y');zlabel('z');
subplot(1,2,2);pcshow(Mode2_Cloud.t1mu,'MarkerSize', 15);hold on;pcshow(Mode2_Cloud.t2mu,'MarkerSize', 15);
title(sprintf('2nd Mode Shape(%d)',2.23));xlabel('x');ylabel('y');zlabel('z');
% subplot(1,3,3);pcshow(Mode3_Cloud.t1mu,'MarkerSize', 5);hold on;pcshow(Mode3_Cloud.t2mu);
% title(sprintf('3rd Mode Shape(%d)',treat_eff(3)));xlabel('x');ylabel('y');zlabel('z');
sgtitle('Treatment-driven geometric variability')
