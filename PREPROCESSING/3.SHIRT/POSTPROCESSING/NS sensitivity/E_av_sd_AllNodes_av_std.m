%% All nodal spacing

function  E_av_sd_AllNodes(mouse, week, dl, NS)
%    mouse = 1;
%    dl = 2;
%    NS = 10;
     week=18;
pathres="C:\Users\emily\OneDrive\Documents\insigneo\Code\ShIRTMResults\"; % EMILY
pathSpec= strcat('NSensitivity\',sprintf('ML%d',mouse),'\',sprintf('ML%dW%d',mouse,week),'\');
pathNS=strcat(sprintf('%d',dl),'voxels\','NodeSpacing',sprintf('%d',NS),'\');
cd(strcat(pathres,pathSpec,pathNS));

filename=strcat('NSens_surface_displ_ML',num2str(mouse),'W',num2str(week));
load(filename);
%dx_1 = [Vq_x Vq_y Vq_z];

dxyz_1=sqrt(Vq_x.^2 + Vq_y.^2 + Vq_z.^2);

len = length(dxyz_1);
vs_(dl)=sqrt((dl*0.0104)^2*3);

d_hat = repmat(-vs_(dl),len,1);
Error_dxyz = dxyz_1 - d_hat;
Error_av = mean(Error_dxyz);
Error_std = std(Error_dxyz);

filename=strcat('Errors',sprintf('ML%dW%dV%d%NS%d',mouse,week,dl,NS));
cd(strcat(pathres,pathSpec,pathNS));
save(filename, 'Error_av','Error_std')
end
% makes [av_vqx av_vqy av_vqz]'
%should now make [av_vq_xyz]










