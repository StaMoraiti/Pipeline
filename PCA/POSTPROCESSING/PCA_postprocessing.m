function [Mode1Cloud,Mode2Cloud,Mode3Cloud] = PCA_postprocessing(inputX,coeff,scores,latent)
figure()
semilogy(latent,'o-')
ylabel('Variance')
xlabel('Number of modes')

figure()
cum_var=cumsum(latent)/sum(latent);
semilogy(cum_var,'o-')
ylabel('Cumulative variance')
xlabel('Number of modes')
% figure();
% subplot(2,1,1)
% biplot(scores(:,1:2))
% 
% biplot(scores(:,2:3))
% xlabel('Component 2')
% ylabel('Component 3')
% sgtitle('Loading plot')
% contribution of the first and second PC tat describes the most variance
i=0;
for w=-3:3
i=i+1;
x_1(:,i)=mean(inputX)'+(mean(scores(:,1))+w*std(scores(:,1)))*coeff(:,1);
x_2(:,i)=mean(inputX)'+(mean(scores(:,2))+w*std(scores(:,2)))*coeff(:,2);
x_3(:,i)=mean(inputX)'+(mean(scores(:,3))+w*std(scores(:,3)))*coeff(:,3);
end
Mode1Cloud.mu  = pointCloud(reshape(x_1(:,4),[9125,3]),'Color',repmat([1 0 0],9125,1));
Mode1Cloud.lb  = pointCloud(reshape(x_1(:,1),[9125,3]),'Color',repmat([0 1 0],9125,1));
Mode1Cloud.ub  = pointCloud(reshape(x_1(:,7),[9125,3]),'Color',repmat([0 0 1],9125,1));
figure();subplot(1,3,1);pcshow(Mode1Cloud.mu);hold on;pcshow(Mode1Cloud.lb);hold on;pcshow(Mode1Cloud.ub);
xlabel('x');ylabel('y');zlabel('z');
legend('Mean','Mean-3std','Mean+3std')
title(' 1st PCA mode (52.76%)')
Mode2Cloud.mu  = pointCloud(reshape(x_2(:,4),[9125,3]),'Color',repmat([1 0 0],9125,1));
Mode2Cloud.lb  = pointCloud(reshape(x_2(:,1),[9125,3]),'Color',repmat([0 1 0],9125,1));
Mode2Cloud.ub  = pointCloud(reshape(x_2(:,7),[9125,3]),'Color',repmat([0 0 1],9125,1));
;subplot(1,3,2);pcshow(Mode2Cloud.mu);hold on;pcshow(Mode2Cloud.lb);hold on;pcshow(Mode2Cloud.ub);
xlabel('x');ylabel('y');zlabel('z');
legend('Mean','Mean-3std','Mean+3std')
title('2nd PCA mode(25.16%)')
Mode3Cloud.mu  = pointCloud(reshape(x_3(:,4),[9125,3]),'Color',repmat([1 0 0],9125,1));
Mode3Cloud.lb  = pointCloud(reshape(x_3(:,1),[9125,3]),'Color',repmat([0 1 0],9125,1));
Mode3Cloud.ub  = pointCloud(reshape(x_3(:,7),[9125,3]),'Color',repmat([0 0 1],9125,1));
subplot(1,3,3);pcshow(Mode3Cloud.mu);hold on;pcshow(Mode3Cloud.lb);hold on;pcshow(Mode3Cloud.ub);
xlabel('x');ylabel('y');zlabel('z');
legend('Mean','Mean-3std','Mean+3std')
title('3rd PCA mode(8.14%)')