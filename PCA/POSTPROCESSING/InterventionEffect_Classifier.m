clear all;
dir_codes=pwd;
%% Read the PCA outputs

Respath='C:\Users\matin\.1-PHD\Pipeline\PCA\OUTPUTS\';
cd(Respath);
load("PCA_results_MLvsOVX_Registered.mat")
Inputpath='C:\Users\matin\.1-PHD\Pipeline\PCA\MAIN\';
cd(Inputpath)
load("PCAinput_MLvsOVX.mat")

%% Scores Clustering with respect to the intervention groups and timepoints t1 and t2
[a_g1,a_g2,a_g3,a_g4]=scores_clustering(latent, score, coeff);
Mml=size(a_g1,1);Movx=size(a_g3,1);
%% FIRST CRTERION: Identifies the modes that describe temporal variations
%% Gradient of the scores between t1 and t2 should be of the
%% same sign for every sample
%% if there is one sample not meeting this requirment, then:
%% 1) create the distribution of the scores gradient
%% 2) accept the possible outlier only if it belongs in the m+-3std
%% if there are more than one scores having different sign of gradient then,
%% the corresponding modes describes natural variability or uncesrtainty
%% AND NOT A TEMPORAL VARIATION

% daML=diff_M(a_g1,a_g2);
% daOVX=diff_M(a_g3,a_g4);

daML=diff_M1(a_g1,a_g2);
daOVX=diff_M1(a_g3,a_g4);
%% PINAKI'S CRITERION:
% Calculates the mean difference between the score temporal changes of two groups over
% the the mean score change in the ovx
%f= (median(daML)-median(daOVX))./(median(daOVX).*(mean([std(daML); std(daOVX)])));
f= (mean(daML)-mean(daOVX))./(mean(daOVX));

figure;
group=[zeros(Mml,1);ones(Movx,1)];
colors=lines(length(unique(group)));
cd(strcat(dir_codes,'/pairplot/'))
pairplot([daML(:,1) daML(:,6);daOVX(:,1) daOVX(:,6)], {'\deltaa_1', '\deltaa_6'}, num2cell(num2str(group)), colors, 'bar')
flagML=sign(daML);
flagOVX=sign(daOVX);

sML=sum(flagML,1);
sOVX=sum(flagOVX,1);
OVXmode=[];

MLmodeT=Criterion_Gradient(Mml,sML,daML);
OVXmodeT=Criterion_Gradient(Movx,sOVX,daOVX);

%% SECOND CRITERION: Identifies the treatment related temporal variations by:
%% 1)keeping the modes that describe temporal changes in the ML group AND
%% do not show up in the corresponding matrix of the OVX group
%% 2)keeping the common modes only if the mean absolute scores-gradient is 
%% higher in the ML than OVX group.
%  This means that this mode describes a temporal change in both groups but
%  the intervention accelerates this geometrical change.

%-- OUTPUT--:
% The index of the modes that satisfy these conditions

TRmode=Criterion_GroupComparison(MLmodeT,OVXmodeT,daML,daOVX);

%% THIRD CRITERION: Identifies the important treatment effects
%% It applies Wilcoxon paired two sided test to reject the null hypothesis that the 
%% the medians of the subgroups of scores pre and post treatmennt are not equal
for q=1:length(TRmode)
[~,h(q)] = signrank(a_g1(:,TRmode(q)),a_g2(:,TRmode(q)));
[~,h2(q)] = signrank(a_g3(:,TRmode(q)),a_g4(:,TRmode(q)));
end
SSTRmode=TRmode(h>0);

%% FORTH CRITERION: Measures the effect size for eac significant mode
%% The gropus are the modal scores of the ML groups classified
%% with respect to the time point
%% As the aim is to compare two time points , pre and post the intervention
%% within one group, the effect size formula is the Cohen's d averaged.

for q=1:length(SSTRmode)
    a_g1I=a_g1(:,SSTRmode(q));a_g2I=a_g2(:,SSTRmode(q));
    davML(q,1)=Average_CohensD(a_g1I,a_g2I);
    
    a_g3I=a_g3(:,SSTRmode(q));a_g4I=a_g4(:,SSTRmode(q));
    davOVX(q,1)=Average_CohensD(a_g3I,a_g4I);

end

EffectSize={SSTRmode,davML};

% Comparison between control and intervention group
Flag2=abs(davOVX(:))<abs(davML(:));

%% EXTRA ATTRIBUTE 1: The std of the modal scores for the ML and t2 samples
%% is higher than the std of the corresponding score of the OVX.

Flag3=std(a_g1(:,SSTRmode))>std(a_g3(:,SSTRmode));


%% EXTRA ATTRIBUTE 2: percent variation explained form the significant 
%% treatment related modes.
load('../../OUTPUTS/PCA_results_MLvsOVX_Registered.mat','latent','coeff','score')
cum_var=cumsum(latent)/sum(latent);
for i=1:size(SSTRmode,1)
    if i==1
        Mvar(i)=cum_var(SSTRmode(i));
    else
        Mvar(i)=cum_var(SSTRmode(i))-cum_var(SSTRmode(i)-1);
    end
end

%% EXTRA ARRTIBUTE 3: Max localized magnitude of the averaged temporal mode change
for i=1:size(SSTRmode,1)
    LocMCha(i)=abs(max(coeff(:,SSTRmode(i)))*mean(daML(:,SSTRmode(i))));
end





%% Supplementary functions

function dav=Average_CohensD(g1,g2)
Adiff=g1-g2;
s1=std(g1);s2=std(g2);

Stdav = (s1 + s2)/2;
dav = mean(Adiff) / Stdav;



end


function A=Criterion_GroupComparison(modesG1,modesG2,daG1,daG2)
A=[];
for ii=1:size(modesG1)
    if isempty(find(modesG2(:,1)==modesG1(ii,1)))
        A=[A;modesG1(ii,1)];
    else
       if  abs(mean(daG1(:,ii)))>abs(mean(daG2(:,ii)))
        A=[A;modesG1(ii,1)];
       else
           continue;
       end

    end
end



end

function mode=Criterion_Gradient(M,s,da)
mode=[];
for k=1:size(s,2)
    if abs(s(k))>=M-2
        if abs(s(k))==M
            mode=[mode;k];
        else % Mml-1
           if sign(s(:,k))==-1
               [~,ind]=max(da(:,k));
           elseif sign(s(:,k))==1
               [~,ind]=min(da(:,k));
           end
           da_m=mean([da(1:ind-1,k); da(ind+1:end,k)]);
           da_s=std([da(1:ind-1,k); da(ind+1:end,k)]);
           if abs(da(ind,k))<abs(da_m)+3*da_s && abs(da(ind,k))>abs(da_m)-3*da_s% express this threshold defined by the distribution 
              mode=[mode;k];
           else
              continue
           end
        end
    end
end

end


function [daN]=diff_M(a_g1,a_g2)
Ma_i=max([abs(a_g1) ; abs(a_g2)]);
for i=1:size(a_g1,1)
    daN(i,:)=(a_g2(i,:)-a_g1(i,:));  
    
    
end

end


function [daN]=diff_M1(a_g1,a_g2)

%% Standardize over the mean value of the t1
Mu_i=mean(a_g1);
for i=1:size(a_g1,1)
    daN(i,:)=(a_g2(i,:)-a_g1(i,:))./Mu_i;    
end

end






