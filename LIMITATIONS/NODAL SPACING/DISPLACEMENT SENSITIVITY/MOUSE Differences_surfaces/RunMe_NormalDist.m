
dir_code=pwd;
Datapath='\DATA\';
   cd(strcat(dir_code,Datapath));
   
   surfR=ml4w18;
   surf1=ml1w18;
   surf2=ml2w18;
   surf3=ml3w18;
   surf5=ml5w18;
   surf6=ml6w18;

     
% MAXIMUM DISTANCE OF THE NORMAL DISTANCES 1-2 AND 2-1  
   surfs={surfR surf1 surf2 surf3 surfR surf5 surf6};
   tic
   for i=2:length(surfs)
      cd(dir_code)
      [ND(i),NDmu(i)]=NormalDist(surfs{1},surfs{i});
   
   end
   toc;
mouse=[1 2 3 5 6];
for ii=1:length(mouse)
   cd(strcat(dir_code,Datapath));
   filename=strcat('NormalDist_', sprintf('ML%dW18',mouse(ii)));
   NDm=ND(ii);NDmum=NDmu(ii);
   save(filename,'ND','NDmu');
end