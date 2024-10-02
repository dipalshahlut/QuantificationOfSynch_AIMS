%% Lorenz CIL plot
clear all; close all;clc
%% Lorenz Position vector 
data = importdata('Lorenz_S_CIL.mat'); % load Lorenz position CIL data
Label = ['c'];
for i = 1:size(data,2)
    ccc=[1 0 0
     1 0 1
     .3 .75 .93
     0 0 1
     0 1 0
     0.47 0.67 0.19
     0 0.67 0     
     1 1 0
     0 1 1
     1 0.4 0.6];   % color code 
    xx = data{1,i}; CIL= data{2,i};  % CIL data
    p(:,i)= plot(xx,CIL(1:floor(size(CIL,1)/100):end,1:end),'-','color',ccc(i,:),'LineWidth',1);hold on;
    set(gca,'FontSize',16,'LineWidth',2)
    set(gca,'Box','on','LineWidth',2)
    xlabel('log(R)' ,'FontSize',16);
    ylabel('logC(R)' ,'FontSize',16);
    set(gca,'XLim', [-10 -2], 'YLim', [-30 0])
%     text(-9.8, -1.8,sprintf('(%c)',Label),'FontSize',16,'FontWeight','bold');hold on
    set(gca,'Ytick',([-30 -20 -10 0]),'FontSize',16)
end
[hleg, hobj, hout, mout] = legend([p(1,1), p(1,2), p(1,3), p(1,4), p(1,5)],...
{'1', '3', '6', '7', '9'},...
'Location','southeast','FontSize',16);
hleg.Title.NodeChildren.Position = [0.15 1.05 0];
title(hleg,'Coupling ($\varepsilon$)','Interpreter','latex')
hleg.Title.Visible = 'on';
hl = findobj(hobj,'type','line');
set(hl,'linewidth',2)
legend boxoff
h = axes('Parent',gcf,'Position',[0.43 0.25 0.25 0.25]); hold on
box on
cS = [1, 3, 6, 7, 9];
data = importdata('Lorenz_S_CIL.mat'); % load Lorenz position CIL data
for i = 1:size(data,2)
    CIL= data{2,i};  % CIL data
    C1 = cov(CIL);
    SIG = diag(CIL);
    Length = 2:100:(size(CIL,1));
    for k = 1:length(Length)
        ind = Length(k);
        s451(k) = (CIL(ind+1,5) - CIL(ind-1,4) )/-1;
        s781(k) = (CIL(ind+1,9) - CIL(ind-1,8) )/-1;
    end
    Points =[1:2:20];
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
