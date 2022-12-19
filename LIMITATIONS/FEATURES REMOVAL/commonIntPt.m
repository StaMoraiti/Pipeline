% function commonIntPt
%  rootpath='/home/mep20sm/Mouse_microFE_S6/';
% % %path1='abaqus-comm_m5a2';
%  path2='ML5W18/with_features/';
%  path3='ML5W18/without_features/test/';
%  dir_codes=pwd;

clear all;clc;
res=0.0104;
dir_codes=pwd;
% storing directories
rootpath='G:\My Drive\PhD\WORK\2nd_year\μCT2μFE_pipeline\';

% results directory
Respath='OUTPUTS\HDLs';
mouse=[6];
for kk=1:1
path2=sprintf('abaqus-with_m%da2',mouse(kk));

path3=sprintf('abaqus-without_m%da2',mouse(kk));
dir_codes=pwd;

% 'WITH' MODEL:
cd(strcat(rootpath,path2));
filename='nodedata.txt';
fid2=fopen(filename,'rt');
C=textscan(fid2,'%d%f%f%f','Delimiter',', ');
CC2=cell(1,2);
CC2{1,1}=C{1,1};
CC2{1,2}=[C{1,2} C{1,3} C{1,4}];
nd2=double(CC2{1,2});
fclose(fid2);

filename='IntPTcoord.rpt';
fidIP2= fopen(filename,'rt');
%D2=textscan(fid2E,'%f%f%f','HeaderLines',19);
C=textscan(fidIP2,'%f%f%f%f%f','HeaderLines',20);
IntPs2=[C{1,:}];

filename='EMIN.rpt';
fidEM2= fopen(filename,'rt');
C=textscan(fidEM2,'%f%f%f','HeaderLines',20);
E2=[C{1,3}];


%-----------------
%'WITHOUT' MODEL:
cd(strcat(rootpath,path3));
filename='nodedata.txt';
fid3=fopen(filename,'rt');
C=textscan(fid3,'%d%f%f%f','Delimiter',', ');
CC3=cell(1,2);
CC3{1,1}=C{1,1};
CC3{1,2}=[C{1,2} C{1,3} C{1,4}];
nd3=CC3{1,2};% nodal coordinates
fclose(fid3);

filename='IntPTcoord.rpt';
fidIP3= fopen(filename,'rt');
C=textscan(fidIP3,'%f%f%f%f%f','HeaderLines',20);
IntPs3=[C{1,:}];% IPs

filename='EMIN.rpt';
fidEM3= fopen(filename,'rt');
C=textscan(fidEM3,'%f%f%f','HeaderLines',20);
E3=[C{1,3}];% strain values of each IP


%FUNCTIONS:
A=@(MM,p0)(round((MM-p0)/res)); % SCALING THE COORDINATES WITH RESPECT TO THE REFERENCE POINT 0 AND THE RESOLUTION OF THE IMAGE
AA=@(MM,p0)((MM-p0)/res);
L=@(MM)(size(unique(MM),1)); % NUMBER OF NODES IN X, Y, Z DIRECTION,
F=@(i,j,k,Mi,Nj)(i+(Mi+1)*j+(Mi+1)*(Nj+1)*k); % NEW NODE LABELLING GIVEN FROM THIS FUNCTION
S=@(MM1,MM2)(sign(MM1-MM2)); % QUARTER OF THE 3D SPACE,(8 COMBINATIONS (X,Y,Z): 1)-,-,-  2)-,-,+  3)-,+,-  4)-,+,+  5)+,-,-  6)+,-,+  7)+,+,-  8)+,+,+ )


%'WITH' MODEL:
RfPt2=min(nd2); % REFERENCE POINT 0 (Xmin,Ymin,Zmin), MODEL 'WITH'
ND2=A(nd2,RfPt2);% NODES COORDINATES EXPRESSED AS AN INTEGER(i,j,k) * RESOLUTION FAR FROM THE REFERENCE POINT, MODEL 'WITH'
M2=L(ND2(:,1));N2=L(ND2(:,2));L2=L(ND2(:,3)); % NUMBER OF NODES IN X, Y, Z DIRECTION,, MODEL 'WITH'
NL2=F(ND2(:,1), ND2(:,2), ND2(:,3),M2,N2);% NEW NODE LABELLING OF EACH NODE

INPT2=AA(IntPs2(:,3:end),RfPt2);%INPT2=[i(+/-) j(+/-) k(+/-)] around a node
closest2=A(IntPs2(:,3:end),RfPt2);% closest2=[i j k]: the closest neightbouring node
NLclos2=F(closest2(:,1), closest2(:,2), closest2(:,3),M2,N2); % the new labeling of the closest node
Q2=S(INPT2,closest2);
%-----------------
%'WITHOUT' MODEL:
RfPt3=min(nd3); % REFERENCE POINT 0 (Xmin,Ymin,Zmin), MODEL 'WITH'
ND3=A(nd2,RfPt3);% NODES EXPRESED AS AN INTEGER* RESOLUTION FAR FROM THE REFERENCE POINT, MODEL 'WITH'
M3=L(ND3(:,1));N3=L(ND3(:,2));L3=L(ND3(:,3)); % NUMBER OF NODES IN X, Y, Z DIRECTION,, MODEL 'WITH'
NL3=F(ND3(:,1), ND3(:,2), ND3(:,3),M3,N3);% NEW NODE LABELLING OF EACH NODE

INPT3cr=AA(IntPs3(:,3:end),RfPt3);
closest3=A(IntPs3(:,3:end),RfPt3);
NLclos3=F(closest3(:,1), closest3(:,2), closest3(:,3),M3,N3);
Q3=S(INPT3cr,closest3);


%% WHOLE SECTION - calculates the M1


%ComIP=zeros(size(NLclos2,1),2);
%QM=[1 1 1;-1 1 1;1 -1 1;-1 -1 1;1 1 -1;-1 1 -1;1 -1 -1;-1 -1 -1]; % 8 ELEMENTS WITH DIFFERENT DIRECTION BUT SOME NODE, POSSIBLE OUTPUTS OF THE S FUNCTION
% for i=1: size(NLclos2,1)
%    CmClNodind=find(NLclos2(i)-NLclos3(:,1)==0);%Int. Pts lables with Common Closest Node
%    
%    if ~isempty(CmClNodind)
%      %ComEl=find()
%      Qi3=Q3(CmClNodind,:);
%      Qi2=Q2(i,:);
%      ComQ2=find(Qi2(1)-Qi3(:,1)==0 & Qi2(2)-Qi3(:,2)==0 & Qi2(3)-Qi3(:,3)==0);
%      ComIP(i,:)=[E2(i,1) E3(CmClNodind(ComQ2),1)];
%      ComIPind(i,:)=[i CmClNodind(ComQ2)];
%    end
% end


%% CRITICAL REGION - calculates the M2


[E3u_s,Iu]=sort(E2); E3u=E3u_s(1:0.1*size(E3u_s,1),1);Iu=Iu(1:0.1*size(Iu,1),1); % Optimized failure ctriterion
[E3p_s,Ip]=sort(E3); E3p=E3p_s(1:0.1*size(E3p_s,1),1);Ip=Ip(1:0.1*size(Ip,1),1);

%'WITH' MODEL:
INPT2cr=AA(IntPs2(Iu,3:end),RfPt2);%INPT2=[i(+/-) j(+/-) k(+/-)] around a node
closest2cr=A(IntPs2(Iu,3:end),RfPt2);% closest2=[i j k]: the closest neightbouring node
NLclos2cr=F(closest2cr(:,1), closest2cr(:,2), closest2cr(:,3),M2,N2); % the new labeling of the closest node
Q2cr=S(INPT2cr,closest2cr);
%'WITHOUT' MODEL:
INPT3cr=AA(IntPs3(Ip,3:end),RfPt3);
closest3cr=A(IntPs3(Ip,3:end),RfPt3);
NLclos3cr=F(closest3cr(:,1), closest3cr(:,2), closest3cr(:,3),M3,N3);
Q3cr=S(INPT3cr,closest3cr);


ComIPcr=zeros(size(NLclos2cr,1),2); % stores the strain values at the common Highly Deformend Locations
ComIPindCR=zeros(size(NLclos2cr,1),2); % stores the index of the strain values at the common HDLs
ComIPxyzCR=zeros(size(NLclos2cr,1),6); % stores the cooridinates of the common HDLs

for i=1: size(NLclos2cr,1)
   CmClNodindCR=find(NLclos2cr(i)-NLclos3cr(:,1)==0);%Int. Pts lables with Common Closest Node
   
   if ~isempty(CmClNodindCR)
     %ComEl=find()
     Qi3cr=Q3cr(CmClNodindCR,:);
     Qi2cr=Q2cr(i,:);
     ComQ2cr=find(Qi2cr(1)-Qi3cr(:,1)==0 & Qi2cr(2)-Qi3cr(:,2)==0 & Qi2cr(3)-Qi3cr(:,3)==0);
     if ~isempty(ComQ2cr)
     ComIPcr(i,:)=[E3u(i,1) E3p(CmClNodindCR(ComQ2cr),1)];
     ComIPindCR(i,:)=[Iu(i) Ip(CmClNodindCR(ComQ2cr))];
     ComIPxyzCR(i,:)=[IntPs2(Iu(i),3:end) IntPs3(Ip(CmClNodindCR(ComQ2cr)),3:end)];
     end
   end
end

cd(strcat(dir_codes,Respath));
filename=sprintf('ComIPCritical_ML%dW18.mat',mouse(kk));
save(filename,"ComIPxyzCR","ComIPindCR","ComIPcr");
DE3_cr=abs(ComIPcr(:,1)-ComIPcr(:,2))/abs(max(E3u));
MuDE3=mean(DE3_cr);
f=size(nonzeros(ComIPindCR(:,1)),1)/size(Iu,1);
filename1=sprintf('StrainErCritical_ML%dW18.mat',mouse(kk));
save(filename1,'DE3_cr',"MuDE3",'f');
end

