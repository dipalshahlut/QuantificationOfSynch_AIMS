%%  main text figure 2 b)
clear all; close all; clc
load escape.mat  % load data file

res=X(:,1:3)-X(:,4:6);res=res';    % residual estimation
nres=sqrt(sum(res.^2)); 
figure(2); plot(35000:45000,nres(:,35000:45000),'m-');hold on;
plot(ii,nres(ii),'go');hold on;
plot(36991:37077,nres(36991:37077),'go');hold on; 
plot(37601:37725,nres(37601:37725),'go'); hold off
xlim([35000 45000]),xticks([35000 37500 40000 42500 45000])
ylim([0 50]),yticks([0 20 40 50]);
set(gca, 'FontSize',16);
set(gca, 'FontSize',16,'LineWidth',2);
text(35160,47,sprintf('(b)'),'FontSize', 18, 'FontWeight','bold')
ylabel('Residual Distance','FontSize', 16), xlabel('Time','FontSize', 16) 