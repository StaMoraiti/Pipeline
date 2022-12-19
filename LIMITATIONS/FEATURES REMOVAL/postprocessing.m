mouse=[1 2 3 4 5 6];
rootpath=pwd;
figure()
%[ha, pos] =tight_subplot(6, 2, [.01 .03], [0 0], [.05 .05])
for g=1:length(mouse)
    filename=sprintf('StrainErCritical_ML%dW18',mouse(g));
    load(filename)
    subplot(6,2,2*(g-1)+1)
   %axes(ha(2*(g-1)+1))
     histogram(DE3_cr(isfinite(DE3_cr)),40)
     set(gca, 'YScale', 'log')
     %title(sprintf('Mouse:%d', mouse(g)))
     subplot(6,2,2*g)
    % axes(ha(2*g))
     plot([1:length(DE3_cr)],DE3_cr');
   
    
    
end
%set(ha,'XTickLabel',''); set(ha,'YTickLabel','')

