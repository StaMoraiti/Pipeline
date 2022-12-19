clear all;clc;

surf0=ExtSurfOrig;vert0=surf0.vertices;
surf1=ExtSurf1;vert1=surf1.vertices;
surf2=ExtSurf2;vert2=surf2.vertices;
surf3=ExtSurf3;vert3=surf3.vertices;
surf4=ExtSurf4;vert4=surf4.vertices;
surf5=ExtSurf5;vert5=surf5.vertices;
surf6=ExtSurf6;vert6=surf6.vertices;
surf7=ExtSurf7;vert7=surf7.vertices;
surf8=ExtSurf8;vert8=surf8.vertices;
surf9=ExtSurf9;vert9=surf9.vertices; 
surf10=ExtSurf10;vert10=surf10.vertices; 
surf11=ExtSurf11;vert11=surf11.vertices; 
surf12=ExtSurf12;vert12=surf12.vertices;

meshes={vert0 vert1 vert2 vert3 vert4 vert5 vert6 vert7 vert8 vert9 vert10 vert11 vert12};
mesh={vrt8 vrt9 vrt10 vrt11};
for i=1:13  
%d = HausdorffDist(meshes{1,i},vert0,1);
d1 = HdorfDist(meshes{1,i},vert0);

disp(i)
memory
hd(i)=d;
hd1(i)=d1;
end

save hausdorffDistance hd hd1