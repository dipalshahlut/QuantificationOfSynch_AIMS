clear all; clc;close all
load Nres1
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
N = 500;   %nu of oscillators
ntest = 50;
for ik =length(K):-1:1 % for loop through all the couplings
    N_nres = Nres1(ik,:,:);
    for k = 1:ntest
        n_res = N_nres(:,k,:);
     
     if ik <= 3
        figure(1); hold all  % plot
        h5= subplot(122), hold all
        [Ecdf1,xh1] = empcdf(n_res,100); H1(ik) = plot(xh1,Ecdf1,'color',color(ik,:));hold on;
        set(gca,'Box','on','FontSize',16,'LineWidth',2);hold on
         set(gca,'Xtick',([0.6 0.7 0.8]),'FontSize',16);hold on
        xlim([0.6 0.8]), hold on  %  ylim([]);
        set(gca,'YTickLabel', [],'YTick',[]);hold on
%         text(0.05,0.93,sprintf('(a)'),'FontSize', 18),hold off

        else 
       figure(1); hold all  % plot
        h6 = subplot(121), hold all 
        [Ecdf1,xh1] = empcdf(n_res,100); H1(ik) = plot(xh1,Ecdf1,'color',color(ik,:));hold on;
        set(gca,'Box','on','FontSize',16,'LineWidth',2);hold on
         set(gca,'Xtick',([0 0.25 0.5]),'FontSize',16);hold on
        xlim([0 0.5]), hold on  %  ylim([]);
        text(0.05,0.93,sprintf('(b)'),'FontSize', 18),hold off
        
        set(gca,'FontSize', 16);
        ylabel(h6,'eCDF','FontSize', 16)
        xlabel(h6,'Stand. Deviation','FontSize', 16) 
        set(gca, 'FontSize',16);
        set(gca,'Box','on','LineWidth',2)
%          text(0.03,0.93,sprintf('(b)'),'FontSize', 18)
end
    end

end



