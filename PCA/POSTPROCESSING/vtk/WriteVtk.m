function WriteVtk(jobPath, jobName, mesh, output)
fid = fopen([jobPath filesep jobName '.vtk'],'w');
fprintf(fid,'# vtk DataFile Version 2.0\n');
fprintf(fid,[jobName '\n']);fprintf(fid,'ASCII\n');fprintf(fid,'DATASET UNSTRUCTURED_GRID\n');
fprintf(fid,'POINTS %d float\n',size(mesh.nodes,1));
fprintf(fid,'%13.6f %13.6f %13.6f\n',(mesh.nodes)');
fprintf(fid,'CELLS %d %d\n',size(mesh.elements,1),4*size(mesh.elements,1));
fprintf(fid,'3 %d %d %d\n',(mesh.elements-1)');
fprintf(fid,'CELL_TYPES %d\n',size(mesh.elements,1));
fprintf(fid,'%d\n',repmat(5,1,size(mesh.elements,1)));
fprintf(fid,'POINT_DATA %d\n',size(mesh.nodes,1));
fprintf(fid,'VECTORS U float\n');
fprintf(fid,'%13.6f %13.6f %13.6f\n',-output');
% fprintf(fid,'VECTORS R float\n');
% fprintf(fid,'%13.6f %13.6f %13.6f\n',(output.state(1).R)');
% fprintf(fid,'CELL_DATA %d\n',size(mesh.elements,1));
% fprintf(fid,'VECTORS Snormal float\n');
% fprintf(fid,'%13.6f %13.6f %13.6f\n',(output.state(1).stress(:,1:3))');
% fprintf(fid,'VECTORS Sshear float\n');
% fprintf(fid,'%13.6f %13.6f %13.6f\n',(output.state(1).stress(:,4:6))');
% fprintf(fid,'VECTORS Sprincipal float\n');
% fprintf(fid,'%13.6f %13.6f %13.6f\n',(output.state(1).pStress)');
% fprintf(fid,'VECTORS Enormal float\n');
% fprintf(fid,'%13.6f %13.6f %13.6f\n',(output.state(1).strain(:,1:3))');
% fprintf(fid,'VECTORS Eshear float\n');
% fprintf(fid,'%13.6f %13.6f %13.6f\n',(output.state(1).strain(:,4:6))');
% fprintf(fid,'VECTORS Eprincipal float\n');
% fprintf(fid,'%13.6f %13.6f %13.6f\n',(output.state(1).pStrain)');
fclose(fid);

end