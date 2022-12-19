mouse=[1];
week=[24];

 for i=1:size(mouse,2)
     for j=1:size(week,2)
         if not(mouse(i)==4 && week(j)==18)
            disp('----------------------------------------------------------------------------')
            disp('Examined group: Mechanical Loading          Examined Section: 6th')
            disp(' ')
            fprintf('Fixed images: Mouse %d, Age %d-weeks old\n',mouse(i), week(j))
            disp('Moved images: Mouse 4, Age 18-weeks old')
            disp('____________________________________________________________________________')
            mouseTibia_Reg(mouse(i),week(j))
            
         end
     end
 end