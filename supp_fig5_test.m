clear all; close all; clc


load Nres
addpath ../mcmcstat
%
color = [0 1 0
        1 0 0
        0 0.3 1
        1 0 1
        0 1 1
        0 0.5 0 
        .3 .75 .93
        1 1 0
        0 1 1
        1 0.4 0.6]; % plot color
K = [0.1, 0.3, 0.5, 0.8, 2.5, 5.5]; % kappa (coupling strength) to estimate
ntest = 50; % nu. of ensembles
time = linspace(0,ft,no);   %total time points 
for ik =1:length(K) % for loop through all the couplings
    N_nres = Nres(ik,:,:);
    for k = 1:ntest
        n_res = N_nres(:,k,:);
        if ik <= 3

         figure(1); hold all  % plot
         h1 = subplot(141), hold all
         [Ecdf,xh] = empcdf(n_res,100); H(ik) = plot(xh,Ecdf,'color',color(ik,:));hold on;
%          p1=get(h1,'position');
         set(gca,'Box','on','FontSize',16,'LineWidth',2);hold on
         set(gca,'Xtick',([0 0.5]),'FontSize',16);hold on
        xlim([0 0.5]), hold on  %  ylim([]);
%         text(0.05,0.93,sprintf('(a)'),'FontSize', 18),hold off
     elseif ik==4 
         figure(1); hold all  % plot
         h2 = subplot(142), hold all 
         p2=get(h2,'position');
         [Ecdf,xh] = empcdf(n_res,100); H(ik) = plot(xh,Ecdf,'color',color(ik,:));hold on;
         set(gca,'Box','on','FontSize',16,'LineWidth',2);hold on
        set(gca,'YTickLabel', [],'YTick',[]);hold on
        set(gca,'Xtick',([0.91 0.93]),'FontSize',16);hold on
        xlim([0.91 0.93]), hold on  %  ylim([]);
      elseif ik==5
         figure(1); hold all  % plot
         h3 = subplot(143), hold all 
         [Ecdf,xh] = empcdf(n_res,100); H(ik) = plot(xh,Ecdf,'color',color(ik,:));hold on;
         p3=get(h3,'position');
         set(gca,'Box','on','FontSize',16,'LineWidth',2);hold on
        set(gca,'YTickLabel', [],'YTick',[]);hold on
        set(gca,'Xtick',([0.993 0.994]),'FontSize',16);hold on
        xlim([0.993 0.994]), hold on  %  ylim([]);
        
     else
         figure(1); hold all  % plot
         h4 = subplot(144), hold all 
         p4=get(h4,'position');
         [Ecdf,xh] = empcdf(n_res,100); H(ik) = plot(xh,Ecdf,'color',color(ik,:));hold on;
         set(gca,'Box','on','FontSize',16,'LineWidth',2);hold on
        set(gca,'YTickLabel', [],'YTick',[]);hold on
        set(gca,'Xtick',([0.9985 0.9987]),'FontSize',16);hold on
        xlim([0.9985 0.9987]), hold on  %  ylim([]);
        end
    end
        
end    

xlabel(h2,'Order','FontSize', 16, 'Rotation',0), hold on
set(gca,'FontSize', 16);hold on
ylabel(h1,'eCDF','FontSize', 16),hold on
% text(0.05,0.93,sprintf('(a)'),'FontSize', 18),hold off

%%
clear all; clc;close all
load Nres
addpath ../mcmcstat
N_plot = Nres(2,:,:);
for i = 1:1
[Ecdf,xh] = empcdf(N_plot(:,i,:),10); H(ik) = plot(xh,Ecdf,'color','r','LineWidth',1.5);hold on; %,'LineWidth',1.5
end
set(gca,'YTickLabel',[]);hold on
set(gca,'XTickLabel',[]);hold on
xlabel('R','FontSize', 16,'FontWeight','bold'), hold on
set(gca,'FontSize', 16);hold on
ylabel('eCDF','FontSize', 16,'FontWeight','bold'),hold on
set(gca,'Box','off'), hold on
set(gca,'linewidth', 2)