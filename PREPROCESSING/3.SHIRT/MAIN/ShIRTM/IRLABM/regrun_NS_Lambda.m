
function [Output,L,map02]=regrun_NS_Lambda(ITERinput, NSinput, Lambdainput, vdim, pathdataF_input, pathdataM_input,pathdataMASK_input, pathres_input, filefixed_input, filemoved_input, filemask_input, Thresh, mouse, week)
%Example[Output]=regrun('50', 'D:\Projects_UniSh\MAMBO\Registration\Accuracy\CORT\Crop2\Scan1\', 'D:\Projects_UniSh\MAMBO\Registration\Accuracy\CORT\Crop2\Scan2\', 'D:\Projects_UniSh\MAMBO\Registration\Accuracy\CORT\Crop2\Scan12\', 'Scan1_crop_fixed.dcm', 'Scan2_crop_fixed.dcm')

%clc

%IRLab
%clear all
% diary D:\Will\Results\Chapter5\Results\diary\diary.txt
%delete old files
delete c:\ShIRTM\ShIRTData\*.img
delete c:\ShIRTM\ShIRTData\*.map
delete c:\ShIRTM\ShIRTData\*.msh
delete c:\ShIRTM\ShIRTData\*.msk
%delete C:\ShIRT\euheart1mats\vsegment*.*

%define the number N of nodes not to be counted (same layer in the beginning and end)
Lremx = 0;
Lremy = 0;
Lremz = 0;

%define the node spacing NS and the other parameters

NS =int2str(NSinput);

NSstring = strcat('NodeSpacing', NS);
%ASCI code for blank is 32
NSstring2 = strcat('NodeSpacing', 32, NS);


Iter =int2str(ITERinput);
Iterstring = strcat('Iterations', Iter);

%%ASCI code for blank is 32
Iterstring2 = strcat('Iterations', 32, Iter);
ParamString2 = strcat('NodeSpacing', 32, NS, 32, 'Iterations', 32, Iter)

if isa(Lambdainput, 'double') == 1
    Lambda =num2str(Lambdainput);
    Lambdastring = strcat('Lambda', Lambda);
    %%ASCI code for blank is 32
    Lambdastring2 = strcat('Lambda', 32, Lambda);
    ParamString2 = strcat('NodeSpacing', 32, NS, 32, 'Iterations', 32, Iter, 32, 'Lambda', 32, Lambda);
end

%SELECT PATHS FOR FIXED, MOVED and RESULS:

pathShIRT = 'G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\PREPROCESSING\3.SHIRT\MAIN\ShIRTM\ShIRTData\';
pathdataf = strcat(pathdataF_input);
pathdatam = strcat(pathdataM_input);
pathdataMASK = strcat(pathdataMASK_input);
if isa(Lambdainput, 'double') == 1
    pathres = strcat(pathres_input, Lambdastring, '\'); 
end
if isa(Lambdainput, 'double') == 0
    pathres = strcat(pathres_input, NSstring, '\');
end
pathres2 = pathres;
% pathres = strcat(pathres_input, NSstring, '\');
%pathres = strcat('D:\Projects_UniSh\MAMBO\Registration\Accuracy\CORT\Crop2\Scan12\', NSstring, '\Lrem1\');

%SELECT FIXED AND MOVED FILES FOR TRANSLATION OR SCALE , WHOLE OR SMALL
% filefixed = strcat(pathdataf, filefixed_input);
% filemoved = strcat(pathdatam, filemoved_input); 
% disp(filefixed)
% filemask = strcat(pathdataf, filemask_input);

voxeldim = vdim;

% f = dicomreadVolume(pathdataf,'MakeIsotropic', true);
% m = dicomreadVolume(pathdatam,'MakeIsotropic', true);
% ImageMask = dicomreadVolume(pathdataf,'MakeIsotropic', true);
% f = squeeze(f);
% m = squeeze(m);
% ImageMask = squeeze(ImageMask);
f = dicomread(strcat(pathdataf , filefixed_input));
m = dicomread(strcat(pathdatam , filemoved_input));
ImageMask = dicomread(strcat(pathdataMASK , filemask_input));

%f1=int16(f);
%m1=int16(m);
f1= double(f);
m1= double(m);
ImageMask1= double(ImageMask);
f2=squeeze(f1);
m2=squeeze(m1);
ImageMask2= squeeze(ImageMask1);
f3=image_object(f2);
m3=image_object(m2);
ImageMask3= image_object(ImageMask2);


IRLabM
disp('Registering the images');
disp(pathres);
%s2=register_image(f3, m3, f3 >=0, NSstring2);
%s2=register_image(f3, m3, f3 >=0, ParamString2);
    
    s2=register_image(f3, m3, ImageMask3 >= Thresh, ParamString2);
    %s2=register_image(f3, m3, f3 >=0, 'NodeSpacing 50 Iterations 10');
    %s2=register_image(f3, m3, f3 >=0, 'NodeSpacing 50');
    %s2=register_image(f3, m3, ImageMask3, 'NS 3');
    map02 = get_map('map');
    
    save_map(map02,'OutMap');
    disp('save and copy map');

    if ~exist(strcat(pathres), 'dir')
        mkdir(strcat(pathres));
    end
    cd(pathres)
    filename=strcat('ML',num2str(mouse),'W',num2str(week),'OutMap');
    save(filename,'map02');
    copyfile(strcat( pathShIRT, 'OutMap.map'), strcat(pathres,'OutMap.map'));
    dual(f3, m3);
    FigName =char(strcat(pathres, 'dual_preregistration4.fig'));
    savefig(FigName);

    %to be commented for large images:
    dual(f3, s2);
    show_map(map02, 'b');
    %%% save the dual figure
    FigName =char(strcat(pathres, 'dual_postregistration4.fig'));
    savefig(FigName);
    close all;


    %clear map ;

    %to be commented for large images:
    %map02

    %L=length(map02.x)*length(map02.y)*length(map02.z);
    Lx=length(map02.u(:,1,1));
    Ly=length(map02.u(1,:,1));
    Lz=length(map02.u(1,1,:));
    L=Lx*Ly*Lz;

    %CREATE FILE FOR WITH INFORMATION ABOUT NODES' COORDINATES AND
    %DISPLACEMENTS
    
    disp('write output file from map');
    outputfe = strcat(pathres2, 'output_map4.txt');
    fileIDfew = fopen(outputfe,'w');
    fileIDfea = fopen(outputfe,'a');
    fprintf(fileIDfew,'%12s %12s %12s %12s %12s %12s %12s\r\n', 'Node', 'x [um]','y [um]','z [um]','u [um]','v [um]','w [um]');
    
    for j=1:L
           fprintf(fileIDfea,'%12i %12.3f %12.3f %12.3f %12.8f %12.8f %12.8f\r\n', j, map02.x(j)*voxeldim(1), map02.y(j)*voxeldim(2), map02.z(j)*voxeldim(3), map02.u(j)*voxeldim(1), map02.v(j)*voxeldim(2), map02.w(j)*voxeldim(3));
    end



Output = 'OK'
diary off
disp('End');
 fclose('all');

end
 
 