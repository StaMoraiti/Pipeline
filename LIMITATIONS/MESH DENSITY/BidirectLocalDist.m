clear all;
% theta=0:pi/10:2*pi;
% 
% rad=3;
% xCen=0;
% yCen=0;
% 
% xCoor1=xCen+ rad*cos(theta);
% yCoor1=yCen+ rad*sin(theta);
% yCoor1(end)=0;
% 
% theta=0:pi/5:2*pi;
% rad2= 1;
% xCen2=2;
% yCen2=0;
% 
% xCoor2=xCen2+ rad2*cos(theta);
% yCoor2=yCen2+ rad2*sin(theta);
% yCoor2(end)=0;
% 
% % figure();
% % plot(xCoor1,yCoor1);hold on;
% % plot(xCoor2,yCoor2); grid; hold on;
% 
% R = [xCoor1' yCoor1']; T = [xCoor2' yCoor2']; % REFERENCE AND TEST SURFACE
mouse=[1 2 3 5 6];
for g=1:length(mouse)
rootpath=pwd;
folderpath=sprintf('L1%dW18',mouse(g));
cd(strcat(rootpath,folderpath))
surf0=ExtSurfOrig;vert0=surf0.vertices;
surf1=ExtSurf1;vert1=surf1.vertices;
surf2=ExtSurf2;vert2=surf2.vertices;
surf3=ExtSurf3;vert3=surf3.vertices;
surf4=ExtSurf4;ver4=surf4.vertices;

mesh={vert0 vert1 vert2 vert3 vert41};
sz=[size(vert0,1) size(vert1,1) size(vert2,1) size(vert3,1) size(ver4,1)];
for kk=1:length(mesh)
D = pdist2(mesh{1},mesh{kk});
[FMinD,int]=min(D,[],2);% MIN DISTANCE FOR EACH Pref TO THE TEST SURFACE
IND=[ int'; int' ]';
[Dtr,ind]=min(D);% MIN DISTANCE FOR EACH Pt TO THE REFERENCE SURFACE
pr=unique(ind);
BMaxD=zeros(size(mesh{1},1),1);
for i=1:length(pr)
[~,pt{i}]=find(ind==pr(i));
[BMaxD(pr(i)),in]=max(Dtr(find(ind==pr(i)))); % keep the pt to pref and then the maximum of them
IND(pr(i),2)=pt{i}(in);
end

[BLD(:,kk),I]=max([FMinD BMaxD],[],2);
II=[1:size(mesh{1},1); zeros(1,size(mesh{1},1))]';
for l=1:size(II,1)
   II(l,2)=IND(l,I(l));
   %plot([R(II(l,1),1),T(II(l,2),1)],[R(II(l,1),2),T(II(l,2),2)],'g-'); hold on;

end
clearvars D
end
filename=sprintf('BidirectLocalDistanceML%dW18',mouse(g));
save(filename,'BLD','sz')
cd(rootpath)
end
