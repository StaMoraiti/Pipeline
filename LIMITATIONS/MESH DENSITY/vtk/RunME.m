clear all;
dir_codes=pwd;
inputs=vtk_UserInput;
cd(strcat(inputs.motherPath,inputs.SpecsPath,inputs.StudyPath))
%load('BidirectionalLocalDist.mat')%coeff score latent

surf0=ExtractedSurface0;
mesh0.elements=surf0.faces;
mesh0.nodes=surf0.vertices;

surf7=ExtractedSurface7;
mesh7.elements=surf7.faces;
mesh7.nodes=surf7.vertices;

surf15=ExtractedSurface15;
mesh15.elements=surf15.faces;
mesh15.nodes=surf15.vertices;

cd(dir_codes)
jobPath=dir_codes;
jobName='Mesh0';
WriteVtk(jobPath, jobName, mesh0);
jobName='Mesh7';
WriteVtk(jobPath, jobName, mesh7);
jobName='Mesh15';
WriteVtk(jobPath, jobName, mesh15);
%WriteVtk(jobPath, jobName, mesh, output);