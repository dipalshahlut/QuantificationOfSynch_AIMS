clear all; clc; close all
% addpath ../mcmcstat
%%
color = ['b','g','r','c','k','m','g','r','c','k','b']; % plot color
K = [0.1, 0.3, 0.5, 0.8, 2.5, 5.5]; % kappa (coupling strength) to estimate
N = 500;   %nu of oscillators
teta = rand(N,1)*2*pi;  
ft   = 1600; no  = 2000;  % final time and num. of time points
ntest = 50; % nu. of ensembles
time = linspace(0,ft,no);   %total time points 
ind = 50:no;   % timepoint index

figure, hold on,
for ik =1:length(K) % for loop through all the couplings
    Ki = K(ik);
    for k=1:ntest; % for loop through all the ensembles
     tic  
     Omega=rand(N,1); % frequency for each oscillators 
     teta = rand(N,1)*2*pi; % initial condition
     [t,y]=ode23s(@ode_kura,time,teta,[],Ki,Omega);%23s when K>0.7

     Y{k}=y;
     %Kuramoto oscillators coordinates calculation on unit circle
%      xm = mean(cos(y(ind,:))'); ym=mean(sin(y(ind,:))'); % mean of the oscillators angle
     xs = std(cos(y(ind,:))');  ys=std(sin(y(ind,:))');  % std of the oscillators angle

%      means(k,:) = [xm ym];   
     stds(k,:)  = [xs ys];

     for kk=ind; orders(k,kk-ind(1)+1) = order(y(kk,:));end  % order estimation
        figure(1); hold all  % plot
        nres = orders(k,:);
        Nres(ik,k,:) = nres; 
        [Ecdf,xh] = empcdf(nres,100); H(ik) = plot(xh,Ecdf,color(ik));hold on;
        x_xh(k,:) = xh;x_Ecdf(k,:) = Ecdf;
        ylabel('eCDF','FontSize', 16), xlabel('Order','FontSize', 16) 
        set(gca, 'FontSize',16);
        set(gca,'Box','on','LineWidth',2)
        text(0.03,0.93,sprintf('(a)'),'FontSize', 18)

        figure(2); hold all
        nres1 = stds(k,:) ;
        Nres1(ik,k,:) = nres1; 
        [Ecdf1,xh1] = empcdf(nres1,100); H1(ik) = plot(xh1,Ecdf1,color(ik));hold on;
        x_xh1(k,:) = xh1;x_Ecdf1(k,:) = Ecdf1;
        ylabel('eCDF','FontSize', 16), xlabel('Stand. Deviation','FontSize', 16) 
        set(gca, 'FontSize',16);
        set(gca,'Box','on','LineWidth',2)
        text(0.03,0.93,sprintf('(b)'),'FontSize', 18)
    end
   X_Ecdf(:,:,ik) =x_Ecdf;   
   X_Ecdf1(:,:,ik) =x_Ecdf1;
 toc
end
[hleg, hobj, hout, mout] = legend([H(1,1), H(1,2), H(1,3), H(1,4), H(1,5), H(1,6)],...
{'0.1', '0.3', '0.5', '0.8', '2.5', '5.5'},...
'Location','southeast','FontSize',16,'Box','off');
hleg.Title.NodeChildren.Position = [0.15 1.05 0];
title(hleg,'Coupling ($\kappa$)','Interpreter','latex')
hleg.Title.Visible = 'on';
h1 = findobj(hobj,'type','line');
set(h1,'linewidth',2),

% %  save  figure
% saveas(gcf,['..\..\Article_fig\Kuramoto_Order.eps'],'epsc')


[hleg, hobj, hout, mout] = legend([H1(1,1), H1(1,2), H1(1,3), H1(1,4), H1(1,5), H1(1,6)],...
{'0.1', '0.3', '0.5', '0.8', '2.5', '5.5'},...
'Location','southeast','FontSize',16,'Box','off');
hleg.Title.NodeChildren.Position = [0.15 1.05 0];
title(hleg,'Coupling ($\kappa$)','Interpreter','latex')
hleg.Title.Visible = 'on';
h2 = findobj(hobj,'type','line');
set(h2,'linewidth',2)

% %  save  figure
% saveas(gcf,['..\..\Article_fig\Kuramoto_Std.eps'],'epsc')
function [r,psii] = order(teta)

 N = length(teta);
 expi  = exp(teta*i);esum = sum(expi);
 r     = 1/N*abs(esum); psii = angle(esum);
end

function dteta=ode_kura(t,teta,K,Omega)

[r,psii] = order(teta);
 dteta   = Omega + K*r*sin(psii-teta(:));
end