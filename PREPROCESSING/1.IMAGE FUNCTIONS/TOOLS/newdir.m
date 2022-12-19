function newdir(newSubPath,mother_dir)
%datapath=strcat('data/N',num2str(N),'/',num2str(d),'/');
addpath(mother_dir)
if ~exist(newSubPath, 'dir')
  mkdir(newSubPath);
end