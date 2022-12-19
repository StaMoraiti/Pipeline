cd('C:\ShIRTM\Data\Matina\Fixed_images\ML1\ML1W24')
dicomFields = dir('*.dcm');    % lists fields in the DICOM path
fileNames   = {dicomFields.name}';
Nslices     = numel(fileNames);
MidPosition = dicominfo(fileNames{Nslices/2}).ImagePositionPatient;
f1 = dicomread(fileNames{Nslices/2});
[rows, columns, numberOfColorChannels] = size(f1);
origin = [MidPosition(1,1), MidPosition(2,1)];  % Assume x, y, NOT row, column
xdata = origin(1) : 0.0104*rows + origin(1);
ydata = origin(2) : 0.0104*columns + origin(2);
imshow(f1, 'XData', xdata, 'YData', ydata);
axis on;
hp = impixelinfo
grid on;