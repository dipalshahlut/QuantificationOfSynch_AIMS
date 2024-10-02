h = axes('Parent',gcf,'Position',[0.43 0.25 0.25 0.25]); hold on
box on
cS = [1, 3, 6, 7, 9];
data = importdata('Lorenz_S_CIL.mat'); % load Lorenz position CIL data
for i = 1:size(data,2)-1
    CIL= data{2,i};  % CIL data
    C1 = cov(CIL);
    SIG = diag(CIL);
    Length = 2:(size(CIL,1))-1;%2:100:(size(CIL,1));
    for k = 1:length(Length)
        ind = Length(k);
        s451(k) = (CIL(ind+1,5) - CIL(ind-1,4) )/-1;
        s781(k) = (CIL(ind+1,9) - CIL(ind-1,8) )/-1;
    end
    Points =[1:2014];%[1:2:20];
    for jj = 1:length(Points)
        Ind = Points(jj);
        slope1dr(jj,i) = s451(:,Ind); 
        slope2dr(jj,i) = s781(:,Ind); 
    end
end
Slopedr(1,:) = mean(slope1dr);
Slopedr(2,:) = mean(slope2dr);
plot(cS,mean(Slopedr),'-','Color','k'), hold on
for i= 1:length(cS)
plot(cS(i),mean(Slopedr(:,i)),'s','LineWidth',2,'color',ccc(i,:),...
'MarkerSize',6,'MarkerEdgeColor',ccc(i,:),'MarkerFaceColor',ccc(i,:)), hold on
end
set(gca, 'FontSize',12,'LineWidth',2); box on, hold on 
% title('Coupled system')
ylabel('Corr. Dim.')