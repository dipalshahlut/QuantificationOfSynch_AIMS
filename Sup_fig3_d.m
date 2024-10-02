%% Rossler CIL plot
clear all; close all;clc
%% Rossler Position vector 
data = importdata('Rossler_S_CIL.mat');% load Rossler position CIL data
Label = ['d'];

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
    set(gca,'XLim', [-12 -2], 'YLim', [-30 0])
    text(-11.8, -1.8,sprintf('(%c)',Label),'FontSize',16,'FontWeight','bold');hold on

    set(gca,'Ytick',([-30 -20 -10 0]),'FontSize',16)
end

[hleg, hobj, hout, mout] = legend([p(1,1), p(1,2), p(1,3), p(1,4), p(1,5), p(1,6)],...
{'0.01', '0.04', '0.14', '0.20', '0.24', '0.35'},...
'Location','southeast','FontSize',16);
hleg.Title.NodeChildren.Position = [0.32 1.05 0];
title(hleg,'Coupling ($\varepsilon$)','Interpreter','latex')
hleg.Title.Visible = 'on';
hl = findobj(hobj,'type','line');
set(hl,'linewidth',2)
legend boxoff