dir_codes=pwd;

cd('G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\PCA\MAIN\')
load('PCAinput.mat')
Sr=inputX(4,:);
cd('G:\My Drive\PhD\WORK\2nd_year\PCA_PIPELINE\PCA\OUTPUTS\')
load('PCA_results.mat')

ind=[1 2 3 5 6 7 8 9 10 11 12]
D=zeros(size(inputX));
Change1=cell(1,size(inputX,1));
Gr=reshape(inputX(4,:)',[9125,3]);
for i=1:size(ind,2)
    G{ind(i)}=reshape(mean(inputX)'+ sum(score(ind(i),:).*coeff(:,:),2),[9125,3]);
    for kk=1:size(Gr,1)
       Change1{ind(i)}(kk,1)=vecnorm(G{ind(i)}(kk,:)-Gr(kk,:));
    end
end

MedCh=median(cell2mat(Change1),2);
MuCh =mean(cell2mat(Change1),2);
MaxChAll=max(cell2mat(Change1),[],1);
MaxCh=max(MaxChAll);
