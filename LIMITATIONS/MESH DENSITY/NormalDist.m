% clear all;clc;


% load('test.mat')
% mesh={aa bb};
% aafaces=[1 2 3 4;
%          1 2 5 6;
%          1 3 5 7;
%          4 3 7 8;
%          2 4 6 8;
%          1 5 3 7];
% bbfaces=[1 13 24 18;
%          2 18 24 9;
%          24 17 9 6;
%          13 5 24 17;
%          1 15 21 13;
%          13 21 5 14;
%          21 16 14 7;
%          15 3 21 16;
%          1 18 25 15;
%          18 2 11 25;
%          15 3 25 20;
%          25 20 11 4;
%          2 9 11 22;
%          9 6 22 10;
%          11 22 4 12;
%          22 10 12 8;
%          4 12 20 23;
%          12 8 23 19;
%          3 20 16 23;
%          16 23 7 19;
%          6 17 10 26;
%          17 5 26 14;
%          10 26 8 19;
%          26 14 19 7];
% 
% 
% 
% 
% a=[1,0,0];% faces info
% b=[0,0,1];
% c=[0,1,0];
function [ND,NDmu]=NormalDist(surf1,surf2)
aa=surf1.vertices;
aafaces=surf1.faces;

bb=surf2.vertices;
bbfaces=surf2.faces;

for j=1:size(aafaces,1)
    face=aafaces(j,:);
    a=aa(face(1),:);
    b=aa(face(2),:);
    c=aa(face(3),:);


    %normal vector
    n=cross(b-a,c-a);
    NNa(j,:)=n./sqrt(sum(n.*n));
end

for j=1:size(bbfaces,1)
    face=bbfaces(j,:);
    a=bb(face(1),:);
    b=bb(face(2),:);
    c=bb(face(3),:);


    %normal vector
    n=cross(b-a,c-a);
    NNb(j,:)=n./sqrt(sum(n.*n));
end

for i=1:size(aa,1) %forward distance a-b
  p=aa(i,:);%point
  for j=1:size(bbfaces,1)
    face=bbfaces(j,:);
    a=bb(face(1),:);

   %point-to-surface distance
   D(j)=abs(dot(p-a,NNb(j,:)));
  end
  Dab(i,1)=min(D);
end
MaxDab=max(Dab);
MuDab=mean(Dab);

for i=1:size(bb,1)% backward distance b-a
  p=bb(i,:);%point
  for j=1:size(aafaces,1)
    face=aafaces(j,:);
    a=aa(face(1),:);

   %poit-to-surface distance
   D(j)=abs(dot(p-a,NNa(j,:)));
  end
  Dba(i,1)=min(D);

end
MaxDba=max(Dba);
MuDba=mean(Dba);
ND=max(MaxDab,MaxDba);
NDmu=max(MuDab,MuDba);
cd('G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\LIMITATIONS\MESH_DENSITY\ML4W18\SURFACEmESHES')
 filename=sprintf('%d',i);
 save(filename,'ND','NDmu');
