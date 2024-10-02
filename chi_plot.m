clear all; close all; clc
addpath ../mcmcstat
load('simu_1KURA_sync_2000_1600_2.mat')
[Y0,iC,x,chi_pf,Yave,Ystd,khi_n]=chi2_test(data.CIL)
figure()
plot(x,khi_n,'b','LineWidth',3);hold on
plot(x,chi_pf,'r','LineWidth',3);hold on
xlabel('\boldmath{$\chi^2$} \textbf{value}','FontSize',16,'FontWeight','bold','Interpreter','latex')

ylabel('Density','FontSize',16,'FontWeight','bold')
set(gca,'Ytick',([0:0.05:0.15]),'FontSize',16)
set(gca,'Xtick',([0:10:50]),'FontSize',16)
set(gca,'Box','off','LineWidth',2)


load('simu_1LOR_sync_2548_2048_4.mat')
[Y0,iC,x,chi_pf,Yave,Ystd,khi_n]=chi2_test(data.CIL)
figure()
plot(x,khi_n,'b','LineWidth',3);hold on
plot(x,chi_pf,'r','LineWidth',3);hold on
xlabel('\boldmath{$\chi^2$} \textbf{value}','FontSize',16,'FontWeight','bold','Interpreter','latex')

ylabel('Density','FontSize',16,'FontWeight','bold')
set(gca,'Ytick',([0:0.05:0.15]),'FontSize',16)
set(gca,'Xtick',([0:10:40]),'FontSize',16)
set(gca,'Box','off','LineWidth',2)

function [Y0,iC,x,chi_pf,Yave,Ystd,khi_n]=chi2_test(Y)

Yave= mean(Y);
Ystd = std(Y);
Y0= Y-repmat(Yave,size(Y,1),1);
C=cov(Y);iC = inv(C);
khi2= sum(Y0'.*(iC*Y0'));
[khi,x]=hist(khi2,50);
khi_n = khi/sum(khi)/(x(2)-x(1));
chi_pf=chipf(x,size(Y0,2));
end
