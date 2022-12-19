mouse=[1 2 3 4 5 6];
dir_codes=pwd;
SubPath='OUTPUTS\WHOLE';

cd(strcat(dir_codes,SubPath));
for i =1: 6
  filename=sprintf('ComIPoints_ML%dW18.mat',mouse(i));
  load(filename)
%   dif_Em=(ComIP(:,1)-ComIP(:,2))./ComIP(:,1);
  dif_Em=abs(ComIP(:,1)-ComIP(:,2));
  dmax=max(dif_Em);
  dmin=min(dif_Em);
  dmu(i)=nanmean(dif_Em);
  dstd(i)= std(isfinite(dif_Em));
  

  figure();
  histogram(dif_Em(isfinite(dif_Em)),50)
  set(gca, 'YScale', 'log')
  title(sprintf('Mouse:%d', mouse(i)))

  resFile=sprintf('strainDifabs_ML%dW18.mat',mouse(i));
  dmui=dmu(i);
  dstdi=dstd(i);
  save(resFile,'dmui','dif_Em','dstdi')
end

figure();
plot([1:length(dmu)],dmu,'o')
