function boundingBox_plot(stru,lstyle,col)
x=stru.x;%x=[x1 x2]
y=stru.y;
z=stru.z;
%points_indx stores the index of x y and z.
%The first column refers to the x, the second to y the third to z
points_indx(:,:,1) = [ 1 1 1;
                       2 1 1;
                       2 2 1;
                       1 2 1; ];
points_indx(:,:,2) = [ 1 1 2;
                       2 1 2;
                       2 2 2;
                       1 2 2; ];
xx=zeros(1,size(points_indx,1)+1);
yy=zeros(1,size(points_indx,1)+1);
zz=zeros(1,size(points_indx,1)+1,2);
for i=1:size(points_indx,1)
    xx(1,i)= x(points_indx(i,1));
    yy(1,i)= y(points_indx(i,2));
end
xx(1,end)= x(1,1);
yy(1,end)= y(1,1);
zz(1,:,1)= z(1,1);
zz(1,:,2)= z(1,2);
plot_grid(xx,yy,zz,stru,lstyle,col);                   

function plot_grid(x,y,z,stru,lstyle,col)
%

n = size(z,3);
for k = 1:n
    plot3(x,y',z(1,:,k),'Color', col,'LineWidth',2)
hold on;
end
xlabel('x');ylabel('y');zlabel('z');
x=stru.x;%x=[x1 x2]
y=stru.y;
z=stru.z;
plot3([x(1) x(1)],[y(1) y(1)],[z(1) z(2)],lstyle,'Color', col,'LineWidth',2);hold on;
plot3([x(2) x(2)],[y(1) y(1)],[z(1) z(2)],lstyle,'Color', col,'LineWidth',2);hold on;
plot3([x(2) x(2)],[y(2) y(2)],[z(1) z(2)],lstyle,'Color', col,'LineWidth',2);hold on;
plot3([x(1) x(1)],[y(2) y(2)],[z(1) z(2)],lstyle,'Color', col,'LineWidth',2);

