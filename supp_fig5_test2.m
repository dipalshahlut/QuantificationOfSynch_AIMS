clear all; clc;close all
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
teta = rand(N,1)*2*pi;  
ft   = 1600; no  = 2000;  % final time and num. of time points
ntest = 50; % nu. of ensembles
time = linspace(0,ft,no);   %total time points 
ind = 50:no;   % timepoint index

for ik =1:length(K) % for loop through all the couplings
    Ki = K(ik);
    for k=1:ntest; % for loop through all the ensembles
     tic   
     Omega=rand(N,1); % frequency for each oscillators 
     teta = rand(N,1)*2*pi; % initial condition
     if ik < 4
         [t,y]=ode23(@ode_kura,time,teta,[],Ki,Omega);%23s when K>0.7
     else
         [t,y]=ode23s(@ode_kura,time,teta,[],Ki,Omega);%23s when K>0.7
     end

     Y{k}=y;
     %Kuramoto oscillators coordinates calculation on unit circle
%      xm = mean(cos(y(ind,:))'); ym=mean(sin(y(ind,:))'); % mean of the oscillators angle
     xs = std(cos(y(ind,:))');  ys=std(sin(y(ind,:))');  % std of the oscillators angle

%      means(k,:) = [xm ym];   
     stds(k,:)  = [xs ys];

     if ik <= 3
        figure(1); hold all  % plot
        h5= subplot(122), hold all
        nres1 = stds(k,:) ;
        Nres1(ik,k,:) = nres1; 
        [Ecdf1,xh1] = empcdf(nres1,100); H1(ik) = plot(xh1,Ecdf1,'color',color(ik,:));hold on;
        x_xh1(k,:) = xh1;x_Ecdf1(k,:) = Ecdf1;

        else 
       figure(1); hold all  % plot
        h6 = subplot(121), hold all 
        nres1 = stds(k,:) ;
        Nres1(ik,k,:) = nres1; 
        [Ecdf1,xh1] = empcdf(nres1,100); H1(ik) = plot(xh1,Ecdf1,'color',color(ik,:));hold on;
        x_xh1(k,:) = xh1;x_Ecdf1(k,:) = Ecdf1;
        
        set(gca,'FontSize', 16);
        ylabel(h5,'eCDF','FontSize', 16)
        xlabel(h5,'Stand. Deviation','FontSize', 16) 
        set(gca, 'FontSize',16);
        set(gca,'Box','on','LineWidth',2)
         text(0.03,0.93,sprintf('(b)'),'FontSize', 18)
end
    end

end
% save Nres1

% %  save  figure
% saveas(gcf,['..\Article_fig\Kuramoto_Std.eps'],'epsc')
function [r,psii] = order(teta)

 N = length(teta);
 expi  = exp(teta*i);esum = sum(expi);
 r     = 1/N*abs(esum); psii = angle(esum);
end

function dteta=ode_kura(t,teta,K,Omega)

[r,psii] = order(teta);
 dteta   = Omega + K*r*sin(psii-teta(:));
end