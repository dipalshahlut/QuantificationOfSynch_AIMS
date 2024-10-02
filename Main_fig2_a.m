%%  main text figure 2 a)
clear all; close all; clc
load escape.mat  % load data file
figure();
plot3(X(1:10:100000,1),X(1:10:100000,2),X(1:10:100000,3),'r.');hold on; 
plot3(X(36991:37077,4),X(36991:37077,5),X(36991:37077,6),'bo');hold on; 
plot3(X(37601:37725,4),X(37601:37725,5),X(37601:37725,6),'bo');hold on; 
set(gca, 'FontSize',16,'LineWidth',2);
xlim([-20 20]),xticks([-20:20:20]);
ylim([-40 40]),yticks([-40:40:40]);
zlim([0 50]),zticks([0:25:50]);
xh = get(gca,'XLabel'); % Handle of the x label
set(xh, 'Units', 'Normalized')
pos = get(xh, 'Position');
set(xh, 'Position',pos.*[1,1,1],'Rotation',30)
yh = get(gca,'YLabel'); % Handle of the y label
set(yh, 'Units', 'Normalized')
pos = get(yh, 'Position');
set(yh, 'Position',pos.*[1,1,1],'Rotation',-37.5)
zh = get(gca,'ZLabel'); % Handle of the z label
set(zh, 'Units', 'Normalized')
pos = get(zh, 'Position');
set(zh, 'Position',pos.*[1,1,0],'Rotation',90)
text(-18,38,45,sprintf('(a)'),'FontSize', 18, 'FontWeight','bold')