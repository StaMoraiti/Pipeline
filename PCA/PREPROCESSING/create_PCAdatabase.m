clear all;clc;
%DATABASE INFO:
mouse=[1 2 3 4 5 6];
week=[18 24];
inputX=[];
data=[];
dir_codes=pwd;

cd('F:\PhD\WORK\2nd_year\PCA_PIPELINE\PREPROCESSING\3.SHIRT\POSTPROCESSING\OUTPUTS');
for j=1:size(week,2)
     for i=1:size(mouse,2)
         if not(mouse(i)==4 && week(j)==18)
             filename=strcat('surface_displ_ML',num2str(mouse(i)),'W',num2str(week(j)));
             load(filename,'ptCloud_t')
             inputX=[ inputX ; reshape(ptCloud_t.Location,[1, 3*size(ptCloud_t.Location,1)])];
         else
           ExtractedSurface2;
           inputX=[ inputX ; reshape(surface.vertices,[1, 3*size(surface.vertices,1)])];
           
         end
         data=[data ;strcat('ML',num2str(mouse(i)),'W',num2str(week(j)))];
     end
end
 
save PCAinput inputX data
movefile PCAinput.mat F:\PhD\WORK\2nd_year\PCA_PIPELINE\PCA\MAIN