function [surf1,surf2]=User_Input

% Structure parameters
rad=3;
xCen=0;
yCen=0;
z=[0;2];
% Mesh density 
theta1=0:pi/4:2*pi;
theta2=0:pi/2:2*pi;

% First mesh
mesh1=cylinder(theta1,rad,xCen,yCen,z);
% Second mesh
mesh2=cylinder(theta2,rad,xCen,yCen,z);

% Connectivity
faces1 =[1 2 9 10;
         2 3 10 11;
         3 4 11 12;
         4 5 12 13;
         5 6 13 14;
         6 7 14 15;
         7 8 15 16;
         8 1 16 9];

faces2 =[1 2 5 6;
         2 3 6 7;
         3 4 7 8;
         4 1 8 5];
     
 surf1=struct('vertices',mesh1,'faces',faces1);
 surf2=struct('vertices',mesh2,'faces',faces2);