motherPath='G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\';


%% Load the strength values
Subpath='STRENGTH RELATION\DATA\';
cd(strcat(motherPath,Subpath));
load('failureLoad.mat','F');
F=[F(:,3);F(:,6)];
%% Load the modal scores
Subpath1='PCA\OUTPUTS\';
cd(strcat(motherPath,Subpath1));
load('PCA_results');

score1=score(:,1);
score2=score(:,2);
score3=score(:,3);

%% Correltion analysis
R1 = corrcoef(F,score1);
R2 = corrcoef(F,score2);
R3 = corrcoef(F,score3);





%% Simple Regression analysis
%key parameters:
n=12;% number of observations;
ps=2;% number of coeff
p0=1;% number of qoi
x=zscore(score1);
y=F;
[p,S]= polyfit(x,y,1);
[yfit,delta]=polyval(p,x,S);
yresid=y-yfit;
SSresid=sum(yresid.^2);
SStotal= (length(F)-1)*var(F);
rsq=1 - SSresid/SStotal;

plot(x(1:6),y(1:6),'go');hold on;plot(x(7:12),y(7:12),'ro')
hold on
plot(x,yfit,'r-')
plot(x,yfit+2*delta,'m--',x,yfit-2*delta,'m--')
title('Linear Fit of Data with 95% Prediction Interval')
legend('Data: w18','Data: w24','Linear Fit','95% Prediction Interval')
xlabel('1st PCA scores')
ylabel('Compressive strength(N)')


%% Multiple Regression analysis
%key parameters:
pm=3;%number of regression coeffs
X = [ones(size(score1)) score1 score2];
X1 = zscore(X);
y = F;
[b,~,r,rint,stat] = regress(y,X);
b1= regress(y,X1) ; 
YFIT = b(1) + b(2)*X(:,2) + b(3)*X(:,3);
FresidM=y-YFIT;
SSresidM=sum(FresidM.^2);


figure();
scatter3(score1(1:6),score2(1:6),F(1:6),'go');hold on;scatter3(score1(7:12),score2(7:12),F(7:12),'ro')
hold on;
s1fit = min(score1):max(score1);
s2fit = min(score2):max(score2);
[S1FIT,S2FIT] = meshgrid(s1fit,s2fit);
MOD = b(1) + b(2)*S1FIT + b(3)*S2FIT;
mesh(S1FIT,S2FIT,MOD)


zlabel('Compressive strength(N)');ylabel('2nd Component Scores');xlabel('1st Compopnent Scores');hold on;
legend('Data: w18','Data: w24','Linear Fit');


%% Comparison between models

Fv=((SSresid-SSresidM)*(n-pm)) / (SSresidM*(pm-ps));
DFM = pm - ps; DFE = n - pm; Fcrit=5.1174; %f-table
p=0.06252; % p calculator
if Fv<Fcrit 
    flag=0;
    disp(['The null hypothesis is accepted:' ])
    disp(['The fit of the simple regression model is NOT significant ' ...
        'different from the fit of the multiple regression model']);
else
    disp(['The null hpothesis is rejected: The fit of the multiple' ...
        'regression model is different from the simple one.' ...
        'As the R-Squared id higher this means that the model is better' ...
        'and additionally it is significant to add the second scores variable' ...
        'associated with the second principal component in the model']);
end

