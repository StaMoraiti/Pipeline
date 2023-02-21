function [a_g1,a_g2,a_g3,a_g4]=scores_clustering(latent, score, coeff)


%% Normalize over the percentage explained
% cum_var=cumsum(latent)/sum(latent);
% Mvar(1)=cum_var(1);
% for i=2:size(coeff,2)
%         Mvar(i)=cum_var(i)-cum_var(i-1);
% end
% score=-score./repmat(Mvar,[22,1]);
% smax=max(score);
% score=-score./smax;


a_g1=score(1:6,:);muA_g1=mean(a_g1);
a_g2=score(7:12,:);muA_g2=mean(a_g2);
a_g3=score(13:17,:);muA_g3=mean(a_g3);
a_g4=score(18:22,:);muA_g4=mean(a_g4);

g1=[1 1 1 1 1 1];
g2=[2 2 2 2 2 2];
g3=[3 3 3 3 3];
g4=[4 4 4 4 4];

[MaxCoef,Loc3D]=max(abs(coeff(:,1:7)));
plot_scores(a_g1,a_g2,a_g3,a_g4,g1,g2,g3,g4);

end

function plot_scores(a_g1,a_g2,a_g3,a_g4,g1,g2,g3,g4)
figure()
plot(g1,a_g1(:,1),'go');hold on;
plot(g2,a_g2(:,1),'ro');hold on;
plot(g3,a_g3(:,1),'go');hold on;
plot(g4,a_g4(:,1),'ro');hold on;
t1_2=[1 2];
a1m1t1_2=[a_g1(1,1) a_g2(1,1)];a1m2t1_2=[a_g1(2,1) a_g2(2,1)];a1m3t1_2=[a_g1(3,1) a_g2(3,1)];
a1m4t1_2=[a_g1(4,1) a_g2(4,1)];a1m5t1_2=[a_g1(5,1) a_g2(5,1)];a1m6t1_2=[a_g1(6,1) a_g2(6,1)];
plot(t1_2,a1m1t1_2,'b-');hold on;text(t1_2,a1m1t1_2,'S1');
plot(t1_2,a1m2t1_2,'b-');hold on;text(t1_2,a1m2t1_2,'S2');
plot(t1_2,a1m3t1_2,'b-');hold on;text(t1_2,a1m3t1_2,'S3');
plot(t1_2,a1m4t1_2,'b-');hold on;text(t1_2,a1m4t1_2,'S4');
plot(t1_2,a1m5t1_2,'b-');hold on;text(t1_2,a1m5t1_2,'S5');
plot(t1_2,a1m6t1_2,'b-');hold on;text(t1_2,a1m6t1_2,'S6');
t3_4=[3 4];
a1m1t3_4=[a_g3(1,1) a_g4(1,1)];a1m2t3_4=[a_g3(2,1) a_g4(2,1)];a1m3t3_4=[a_g3(3,1) a_g4(3,1)];
a1m4t3_4=[a_g3(4,1) a_g4(4,1)];a1m5t3_4=[a_g3(5,1) a_g4(5,1)];
plot(t3_4,a1m1t3_4,'b-');hold on;text(t3_4,a1m1t3_4,'S1');
plot(t3_4,a1m2t3_4,'b-');hold on;text(t3_4,a1m2t3_4,'S2');
plot(t3_4,a1m3t3_4,'b-');hold on;text(t3_4,a1m3t3_4,'S3');
plot(t3_4,a1m4t3_4,'b-');hold on;text(t3_4,a1m4t3_4,'S4');
plot(t3_4,a1m5t3_4,'b-');text(t3_4,a1m5t3_4,'S5');
title('1st Mode Shape')
figure()
plot(g1,a_g1(:,2),'go');hold on;
plot(g2,a_g2(:,2),'ro');hold on;
plot(g3,a_g3(:,2),'go');hold on;
plot(g4,a_g4(:,2),'ro');hold on;
t1_2=[1 2];
a2m1t1_2=[a_g1(1,2) a_g2(1,2)];a2m2t1_2=[a_g1(2,2) a_g2(2,2)];a2m3t1_2=[a_g1(3,2) a_g2(3,2)];
a2m4t1_2=[a_g1(4,2) a_g2(4,2)];a2m5t1_2=[a_g1(5,2) a_g2(5,2)];a2m6t1_2=[a_g1(6,2) a_g2(6,2)];
plot(t1_2,a2m1t1_2,'b-');hold on;text(t1_2,a2m1t1_2,'S1');
plot(t1_2,a2m2t1_2,'b-');hold on;text(t1_2,a2m2t1_2,'S2');
plot(t1_2,a2m3t1_2,'b-');hold on;text(t1_2,a2m3t1_2,'S3');
plot(t1_2,a2m4t1_2,'b-');hold on;text(t1_2,a2m4t1_2,'S4');
plot(t1_2,a2m5t1_2,'b-');hold on;text(t1_2,a2m5t1_2,'S5');
plot(t1_2,a2m6t1_2,'b-');hold on;text(t1_2,a2m6t1_2,'S6');
t3_4=[3 4];
a2m1t3_4=[a_g3(1,2) a_g4(1,2)];a2m2t3_4=[a_g3(2,2) a_g4(2,2)];a2m3t3_4=[a_g3(3,2) a_g4(3,2)];
a2m4t3_4=[a_g3(4,2) a_g4(4,2)];a2m5t3_4=[a_g3(5,2) a_g4(5,2)];
plot(t3_4,a2m1t3_4,'b-');hold on;text(t3_4,a2m1t3_4,'S1');
plot(t3_4,a2m2t3_4,'b-');hold on;text(t3_4,a2m2t3_4,'S2');
plot(t3_4,a2m3t3_4,'b-');hold on;text(t3_4,a2m3t3_4,'S3');
plot(t3_4,a2m4t3_4,'b-');hold on;text(t3_4,a2m4t3_4,'S4');
plot(t3_4,a2m5t3_4,'b-');text(t3_4,a2m5t3_4,'S5');
title('2nd Mode Shape')
figure()
plot(g1,a_g1(:,3),'go');hold on;
plot(g2,a_g2(:,3),'ro');hold on;
plot(g3,a_g3(:,3),'go');hold on;
plot(g4,a_g4(:,3),'ro');
t1_2=[1 2];
a3m1t1_2=[a_g1(1,3) a_g2(1,3)];a3m2t1_2=[a_g1(2,3) a_g2(2,3)];a3m3t1_2=[a_g1(3,3) a_g2(3,3)];
a3m4t1_2=[a_g1(4,3) a_g2(4,3)];a3m5t1_2=[a_g1(5,3) a_g2(5,3)];a3m6t1_2=[a_g1(6,3) a_g2(6,3)];
plot(t1_2,a3m1t1_2,'b-');hold on;text(t1_2,a3m1t1_2,'S1');
plot(t1_2,a3m2t1_2,'b-');hold on;text(t1_2,a3m2t1_2,'S2');
plot(t1_2,a3m3t1_2,'b-');hold on;text(t1_2,a3m3t1_2,'S3');
plot(t1_2,a3m4t1_2,'b-');hold on;text(t1_2,a3m4t1_2,'S4');
plot(t1_2,a3m5t1_2,'b-');hold on;text(t1_2,a3m5t1_2,'S5');
plot(t1_2,a3m6t1_2,'b-');hold on;text(t1_2,a3m6t1_2,'S6');
t3_4=[3 4];
a3m1t3_4=[a_g3(1,3) a_g4(1,3)];a3m2t3_4=[a_g3(2,3) a_g4(2,3)];a3m3t3_4=[a_g3(3,3) a_g4(3,3)];
a3m4t3_4=[a_g3(4,3) a_g4(4,3)];a3m5t3_4=[a_g3(5,3) a_g4(5,3)];
plot(t3_4,a3m1t3_4,'b-');hold on;text(t3_4,a3m1t3_4,'S1');
plot(t3_4,a3m2t3_4,'b-');hold on;text(t3_4,a3m2t3_4,'S2');
plot(t3_4,a3m3t3_4,'b-');hold on;text(t3_4,a3m3t3_4,'S3');
plot(t3_4,a3m4t3_4,'b-');hold on;text(t3_4,a3m4t3_4,'S4');
plot(t3_4,a3m5t3_4,'b-');text(t3_4,a3m5t3_4,'S5');
title('3rd Mode Shape')
figure()
plot(g1,a_g1(:,4),'go');hold on;
plot(g2,a_g2(:,4),'ro');hold on;
plot(g3,a_g3(:,4),'go');hold on;
plot(g4,a_g4(:,4),'ro');
t1_2=[1 2];
a4m1t1_2=[a_g1(1,4) a_g2(1,4)];a4m2t1_2=[a_g1(2,4) a_g2(2,4)];a4m3t1_2=[a_g1(3,4) a_g2(3,4)];
a4m4t1_2=[a_g1(4,4) a_g2(4,4)];a4m5t1_2=[a_g1(5,4) a_g2(5,4)];a4m6t1_2=[a_g1(6,4) a_g2(6,4)];
plot(t1_2,a4m1t1_2,'b-');hold on;text(t1_2,a4m1t1_2,'S1');
plot(t1_2,a4m2t1_2,'b-');hold on;text(t1_2,a4m2t1_2,'S2');
plot(t1_2,a4m3t1_2,'b-');hold on;text(t1_2,a4m3t1_2,'S3');
plot(t1_2,a4m4t1_2,'b-');hold on;text(t1_2,a4m4t1_2,'S4');
plot(t1_2,a4m5t1_2,'b-');hold on;text(t1_2,a4m5t1_2,'S5');
plot(t1_2,a4m6t1_2,'b-');hold on;text(t1_2,a4m6t1_2,'S6');
t3_4=[3 4];
a4m1t3_4=[a_g3(1,4) a_g4(1,4)];a4m2t3_4=[a_g3(2,4) a_g4(2,4)];a4m3t3_4=[a_g3(3,4) a_g4(3,4)];
a4m4t3_4=[a_g3(4,4) a_g4(4,4)];a4m5t3_4=[a_g3(5,4) a_g4(5,4)];
plot(t3_4,a4m1t3_4,'b-');hold on;text(t3_4,a4m1t3_4,'S1');
plot(t3_4,a4m2t3_4,'b-');hold on;text(t3_4,a4m2t3_4,'S2');
plot(t3_4,a4m3t3_4,'b-');hold on;text(t3_4,a4m3t3_4,'S3');
plot(t3_4,a4m4t3_4,'b-');hold on;text(t3_4,a4m4t3_4,'S4');
plot(t3_4,a4m5t3_4,'b-');text(t3_4,a4m5t3_4,'S5');
title('4th Mode Shape')
figure()
plot(g1,a_g1(:,5),'go');hold on;
plot(g2,a_g2(:,5),'ro');hold on;
plot(g3,a_g3(:,5),'go');hold on;
plot(g4,a_g4(:,5),'ro');
t1_2=[1 2];
a5m1t1_2=[a_g1(1,5) a_g2(1,5)];a5m2t1_2=[a_g1(2,5) a_g2(2,5)];a5m3t1_2=[a_g1(3,5) a_g2(3,5)];
a5m4t1_2=[a_g1(4,5) a_g2(4,5)];a5m5t1_2=[a_g1(5,5) a_g2(5,5)];a5m6t1_2=[a_g1(6,5) a_g2(6,5)];
plot(t1_2,a5m1t1_2,'b-');hold on;text(t1_2,a5m1t1_2,'S1');
plot(t1_2,a5m2t1_2,'b-');hold on;text(t1_2,a5m2t1_2,'S2');
plot(t1_2,a5m3t1_2,'b-');hold on;text(t1_2,a5m3t1_2,'S3');
plot(t1_2,a5m4t1_2,'b-');hold on;text(t1_2,a5m4t1_2,'S4');
plot(t1_2,a5m5t1_2,'b-');hold on;text(t1_2,a5m5t1_2,'S5');
plot(t1_2,a5m6t1_2,'b-');hold on;text(t1_2,a5m6t1_2,'S6');
t3_4=[3 4];
a5m1t3_4=[a_g3(1,5) a_g4(1,5)];a5m2t3_4=[a_g3(2,5) a_g4(2,5)];a5m3t3_4=[a_g3(3,5) a_g4(3,5)];
a5m4t3_4=[a_g3(4,5) a_g4(4,5)];a5m5t3_4=[a_g3(5,5) a_g4(5,5)];
plot(t3_4,a5m1t3_4,'b-');hold on;text(t3_4,a5m1t3_4,'S1');
plot(t3_4,a5m2t3_4,'b-');hold on;text(t3_4,a5m2t3_4,'S2');
plot(t3_4,a5m3t3_4,'b-');hold on;text(t3_4,a5m3t3_4,'S3');
plot(t3_4,a5m4t3_4,'b-');hold on;text(t3_4,a5m4t3_4,'S4');
plot(t3_4,a5m5t3_4,'b-');text(t3_4,a5m5t3_4,'S5');
title('5th Mode Shape')
figure()
plot(g1,a_g1(:,6),'go');hold on;
plot(g2,a_g2(:,6),'ro');hold on;
plot(g3,a_g3(:,6),'go');hold on;
plot(g4,a_g4(:,6),'ro');
t1_2=[1 2];
a6m1t1_2=[a_g1(1,6) a_g2(1,6)];a6m2t1_2=[a_g1(2,6) a_g2(2,6)];a6m3t1_2=[a_g1(3,6) a_g2(3,6)];
a6m4t1_2=[a_g1(4,6) a_g2(4,6)];a6m5t1_2=[a_g1(5,6) a_g2(5,6)];a6m6t1_2=[a_g1(6,6) a_g2(6,6)];
plot(t1_2,a6m1t1_2,'b-');hold on;text(t1_2,a6m1t1_2,'S1');
plot(t1_2,a6m2t1_2,'b-');hold on;text(t1_2,a6m2t1_2,'S2');
plot(t1_2,a6m3t1_2,'b-');hold on;text(t1_2,a6m3t1_2,'S3');
plot(t1_2,a6m4t1_2,'b-');hold on;text(t1_2,a6m4t1_2,'S4');
plot(t1_2,a6m5t1_2,'b-');hold on;text(t1_2,a6m5t1_2,'S5');
plot(t1_2,a6m6t1_2,'b-');hold on;text(t1_2,a6m6t1_2,'S6');
t3_4=[3 4];
a6m1t3_4=[a_g3(1,6) a_g4(1,6)];a6m2t3_4=[a_g3(2,6) a_g4(2,6)];a6m3t3_4=[a_g3(3,6) a_g4(3,6)];
a6m4t3_4=[a_g3(4,6) a_g4(4,6)];a6m5t3_4=[a_g3(5,6) a_g4(5,6)];
plot(t3_4,a6m1t3_4,'b-');hold on;text(t3_4,a6m1t3_4,'S1');
plot(t3_4,a6m2t3_4,'b-');hold on;text(t3_4,a6m2t3_4,'S2');
plot(t3_4,a6m3t3_4,'b-');hold on;text(t3_4,a6m3t3_4,'S3');
plot(t3_4,a6m4t3_4,'b-');hold on;text(t3_4,a6m4t3_4,'S4');
plot(t3_4,a6m5t3_4,'b-');text(t3_4,a6m5t3_4,'S5');
title('6th Mode Shape')
figure()
plot(g1,a_g1(:,7),'go');hold on;
plot(g2,a_g2(:,7),'ro');hold on;
plot(g3,a_g3(:,7),'go');hold on;
plot(g4,a_g4(:,7),'ro');
t1_2=[1 2];
a7m1t1_2=[a_g1(1,7) a_g2(1,7)];a7m2t1_2=[a_g1(2,7) a_g2(2,7)];a7m3t1_2=[a_g1(3,7) a_g2(3,7)];
a7m4t1_2=[a_g1(4,7) a_g2(4,7)];a7m5t1_2=[a_g1(5,7) a_g2(5,7)];a7m6t1_2=[a_g1(6,7) a_g2(6,7)];
plot(t1_2,a7m1t1_2,'b-');hold on;text(t1_2,a7m1t1_2,'S1');
plot(t1_2,a7m2t1_2,'b-');hold on;text(t1_2,a7m2t1_2,'S2');
plot(t1_2,a7m3t1_2,'b-');hold on;text(t1_2,a7m3t1_2,'S3');
plot(t1_2,a7m4t1_2,'b-');hold on;text(t1_2,a7m4t1_2,'S4');
plot(t1_2,a7m5t1_2,'b-');hold on;text(t1_2,a7m5t1_2,'S5');
plot(t1_2,a7m6t1_2,'b-');hold on;text(t1_2,a7m6t1_2,'S6');
t3_4=[3 4];
a7m1t3_4=[a_g3(1,7) a_g4(1,7)];a7m2t3_4=[a_g3(2,7) a_g4(2,7)];a7m3t3_4=[a_g3(3,7) a_g4(3,7)];
a7m4t3_4=[a_g3(4,7) a_g4(4,7)];a7m5t3_4=[a_g3(5,7) a_g4(5,7)];
plot(t3_4,a7m1t3_4,'b-');hold on;text(t3_4,a7m1t3_4,'S1');
plot(t3_4,a7m2t3_4,'b-');hold on;text(t3_4,a7m2t3_4,'S2');
plot(t3_4,a7m3t3_4,'b-');hold on;text(t3_4,a7m3t3_4,'S3');
plot(t3_4,a7m4t3_4,'b-');hold on;text(t3_4,a7m4t3_4,'S4');
plot(t3_4,a7m5t3_4,'b-');text(t3_4,a7m5t3_4,'S5');
title('7th Mode Shape')
% figure();
% plot3(a_g1(:,1),a_g1(:,2),a_g1(:,4),'ro');hold on;
% plot3(a_g2(:,1),a_g2(:,2),a_g2(:,4),'go');hold on;
% plot3(a_g3(:,1),a_g3(:,2),a_g3(:,4),'bo');hold on;
% plot3(a_g4(:,1),a_g4(:,2),a_g4(:,4),'ko');
% xlabel('mode 1');
% ylabel('mode 2');
end
