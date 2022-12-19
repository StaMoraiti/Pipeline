clear all;
dir_codes=pwd;
cd ('..\..\OUTPUTS')
load('PCA_results1.mat')%coeff score latent

cd('F:\PhD\WORK\2nd_year\PCA_PIPELINE\PCA\MAIN');
load('PCAinput.mat') %inputX

cd('F:\PhD\WORK\2nd_year\PCA_PIPELINE\PREPROCESSING\3.SHIRT\POSTPROCESSING\FUNCTIONS')
surface= ExtractedSurface2;
mu_shape.elements=surface.faces;
mu_shape.nodes=reshape(mean(inputX),[size(surface.vertices,1),3]);

mode1=reshape(coeff(:,1),[size(surface.vertices,1),3]);
mode2=reshape(coeff(:,2),[size(surface.vertices,1),3]);
jobPath=dir_codes;
jobName='3DMode2_1';
WriteVtk(jobPath, jobName, mu_shape, mode2);