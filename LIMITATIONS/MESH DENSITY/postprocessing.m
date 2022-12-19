mouse=[1 2 3 4 5 6]
rootpath=pwd;

for g=1:length(mouse)
folderpath=sprintf('ML%dW18',mouse(g));
filename=sprintf('BidirectLocalDistanceML%dW18',mouse(g));
cd(strcat(rootpath,'\',folderpath))
load(filename)
if g==4
    BLD=[BLD(:,1) BLD(:,2) BLD(:,15) BLD(:,28) BLD(:,42)];
end
MU_D(g,:)=mean(BLD);

end

max_mD=max(MU_D);
min_mD=min(MU_D);
plot([1 2 15 28 42],min_mD);hold on
plot([1 2 15 28 42],max_mD);

cd(rootpath)
figure()
shadedplot([1 2 15 28 42],min_mD,max_mD,[0.9 0.9 0.9],'b');hold on;
plot([1 2 15 28 42],mean(MU_D),'Color',[0.8500 0.3250 0.0980]); hold on;
plot([1 2 15 28 42],repmat(0.0104,1,5),'k','LineWidth',3)
