clear all;
dir_codes=pwd;
%% Read the PCA outputs

Respath='C:\Users\matin\.1-PHD\Pipeline\PCA\OUTPUTS\';
cd(Respath);
load("PCA_results_MLvsOVX_Registered.mat")
Inputpath='C:\Users\matin\.1-PHD\Pipeline\PCA\MAIN\';
cd(Inputpath)
load("PCAinput_MLvsOVX.mat")
cd(dir_codes)

%% Score separation with respecto to the exmained cohoorts and time points
[a_g1,a_g2,a_g3,a_g4]=scores_clustering(latent, score, coeff); 
Mml=size(a_g1,1);Movx=size(a_g3,1);

%% Calculate the temporal score changes
daML=diff_M(a_g1,a_g2);
daOVX=diff_M(a_g3,a_g4);


%% STATISTICAL TESTS
%% F=DAml-DAovx/DAovx : measure for treatment classification

conf=0.05;
for i=1:size(a_g1,2)
t0=ranksum(a_g1(:,i),a_g3(:,i));% H0: T1ml=T1ovx, H1: T1ml/=T1ovx;
ta=ranksum(daML(:,i),daOVX(:,i));% H0: daML=daOVX, H1: daML/=daOVX;
tb1=signrank(daOVX(:,i),0);% H0: daOVX=0, H1: daOVX/=0;
tb2=signrank(daML(:,i),0,'tail','left');% H0: daML>0, H1: daML<0
tc1=signrank(daOVX(:,i),0,'tail','left');% H0: daOVX>0, H1: daOVX<0
tc2=ranksum(daML(:,i),daOVX(:,i),'tail','left');% H0: daML>daOVX, H1: daML<daOVX

%% 2. Treatment effect classification  
     % is there ssd in the temporal score changes between groups?
     if ta>=conf % the temporal changes ML= OVX
         if tb1>conf % OVX = 0
             disp(strcat(sprintf('Mode %d:',i),' No effect of either "OVX" or "ML"'));
         elseif tb1<conf % ovx/=0
             if tc1<conf % ovx<0
                 disp(strcat(sprintf('Mode %d:',i),' Negative effect onf OVX, no separate effect of ML'));
             else
                 disp(strcat(sprintf('Mode %d:',i),' Positive effect o OVx, no separate effect of ML'));
             end
         end
     else % ml/=ovx
        if tb1>conf % ovx=0;
            if tb2<conf % ml<0
               disp(strcat(sprintf('Mode %d:',i),' ML has a negative effect, pure and independent from the OVX'));
            else % ml>0
               disp(strcat(sprintf('Mode %d:',i),' ML has a positive effect, pure and independent from the OVX'));
            end
        elseif tb1<conf %ovx/=0
                if tc1<conf && tc2<conf % ovx<0, ml>ovx
                    disp(strcat(sprintf('Mode %d:',i),' ML opposes OVX effects'));
                elseif tc1<conf && tc2>conf % ovx<0. ml<ovx
                    disp(strcat(sprintf('Mode %d:',i),' ML exaggerates OVX effects'));
                elseif tc1>conf && tc2<conf % ovx>0, ml>ovx
                    disp(strcat(sprintf('Mode %d:',i),' ML exaggerates OVX effects'));
                elseif tc1>conf && tc2>conf %ovx>0, ml<ovx
                    disp(strcat(sprintf('Mode %d:',i),' ML opposes OVX effects'));
                end
        end

     end


end

%% EXTRA FEATURE: THE TREATMENT EFFECT (MODEWISE) SHOULD BE LARGER THAN THE NATURAL VARIABILITY 
%% DESCRIBED BY THE EXAMINED MODE
f2=(mean(a_g2)-mean(a_g1))/std(a_g1); % f>1, f<1




























%% SUPPLEMENTARY FUNCTIONS


function da=diff_M(a_g1,a_g2)
 da = a_g2-a_g1 ; 
end
