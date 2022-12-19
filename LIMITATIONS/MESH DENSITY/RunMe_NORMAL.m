clear all;
%[surf1, surf2]=User_Input; 
mouse=[1 2 3 5 6];
rootpath='G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\LIMITATIONS\MESH_DENSITY\';
for ii=1:length(mouse)
   datapath=strcat(sprintf('ML%dW18',mouse(ii)),'\SURFACEmESHES');
   cd(strcat(rootpath,datapath)) 
   surf0=ExtractedSurface0;
   surf1=ExtractedSurface1;
   surf2=ExtractedSurface2;
   surf3=ExtractedSurface3;
   surf4=ExtractedSurface4;
   surf5=ExtractedSurface5;
   surf6=ExtractedSurface6;
   surf7=ExtractedSurface7;
   surf8=ExtractedSurface8;
   surf9=ExtractedSurface9;
   surf10=ExtractedSurface10;
   surf11=ExtractedSurface11;
   surf12=ExtractedSurface12;
   surf13=ExtractedSurface13;
   surf14=ExtractedSurface14;
   surf15=ExtractedSurface15;

     
% MAXIMUM DISTANCE OF THE NORMAL DISTANCES 1-2 AND 2-1  
   surfs={surf0 surf1 surf2 surf3 surf4 surf5 surf6 surf7 surf8 surf9 surf10 surf11 surf12 surf13 surf14 surf15};
   tic
   for i=2:length(surfs)
      cd(rootpath) 
      [ND(i),NDmu(i)]=NormalDist(surfs{1},surfs{i});
   
   end
   toc
   cd(cd(strcat(rootpath,datapath)));
   filename=strcat('NormalDist_', sprintf('ML%dW18',mouse(ii)));
   save(filename,'ND','NDmu');
end