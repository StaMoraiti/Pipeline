
function ind=main(ptCloud_t)

    % some data
x=ptCloud_t.Location(:,1);
y=ptCloud_t.Location(:,2);
z=ptCloud_t.Location(:,3);


    % set up plane using 3 points
cd('C:\ShIRTM\Data\Matina\Fixed_images\ML1\ML1W24')
dicomFields = dir('*.dcm');    % lists fields in the DICOM path
fileNames   = {dicomFields.name}';
Nslices     = numel(fileNames);
MidPosition = dicominfo(fileNames{Nslices/2}).ImagePositionPatient;    

p0 = MidPosition';
    % normal vector of a plane

n=[0 0 1];
    % equation of a plane
    % a(x-x0) + b(y-y0) + c(z-z0) = 0
F = @(X,Y) -n(1)/n(3)*(X-p0(1)) - n(2)/n(3)*(Y-p0(2)) + p0(3);
[x0,y0] = meshgrid([min(x(:)) max(x(:))]);
z0 = F(x0,y0);
    % find distance to plane for each point
    % (using the same formula)
FDIST = @(X,Y,Z) sum(n.*(p0-[X Y Z]));
D = arrayfun(FDIST,x(:),y(:),z(:),'uni',false);
D1 = cell2mat(D);
mindist = 0.0104;                          % minumum distance to plane
ind = abs(D1) < mindist;


mplot = @(p,s) plot3(p(1),p(2),p(3),s);
plot3(x(:),y(:),z(:),'.b')              % all data
hold on
plot3(x(ind),y(ind),z(ind),'or')        % points belong to plane
    % original points
surf(x0,y0,z0,'FaceAlpha',0.5)          % plane
hold off

axis equal