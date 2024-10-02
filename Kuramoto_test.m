%%  Supplementary figure 5 a)
clear all; clc; close all
tic 
addpath ../mcmcstat
%%
color = ['b','g','r','c','k','b','g','r','c','k','b'];
N=500;          % nu of oscillators
h=0.1;          % time increment
iter=50000;%90000; % time points
t=0:h:h*iter;   %  total time 
ens = 60;       % nu. of ensembles
Omega=rand(N,1);   % frequency for each oscillators
K_crit = mean(Omega); % critical coupling for synchronization
k = [K_crit-0.3, K_crit-0.2, K_crit, K_crit+0.2, K_crit+0.5 ];  % kappa (coupling strength) to estimate
k = [0.1,0.3, 0.5, 0.7, 0.9, 5.5]; % kappa (coupling strength) to estimate
k = [0.8];%k = 3;
for ind = 1:length(k) %loop through all different kappa 
    K = k(ind)  
    for j = 1:ens  % loop through all ensemble
        j
        In = 2*pi.*rand(N,1); 
        In = In.*(1+randn(N,1).*0.01);  % Initial condition 
        
        %% model 

        tic
        [t1,y1] = ode23s(@(t,y)kuramoto(y,K,N,Omega),t,In);
         toc
%         y1 = y1(2001:end,:);
        %% Kuramoto oscillators coordinates calculation on unit circle
        x1=cos(y1);    
        xx1=sin(y1);    
        
        %%  % residual distance calculation
%         nres =[ mean(xx1,2); mean(x1,2);std(xx1,0,2); std(x1,0,2)];
%         nres =abs([ mean(x1,2); mean(xx1,2)]);
        %%
        Nres(ind,j,:) = nres; 
        [Ecdf,xh] = empcdf(nres,100); H(ind) = plot(xh,Ecdf,'color',color(ind));%,'DisplayName', sprintf('K = %0.2f',k(ind)));hold on;
        x_xh(j,:) = xh;x_Ecdf(j,:) = Ecdf;
    end
    legend(H,'Location','southeast'), 
    legend boxoff
end
xlabel('[mean(sin(S)),mean(cos(S))]'), ylabel('ecdf')
% save x_Ecdf    
toc

% k = [K_crit-0.3 K_crit-0.2 K_crit K_crit+0.2];
xbin = linspace(0.001,20,20);
color = ['b','g','r','c','k','b','g','r','c','k','b'];
for E=1:length(k);N=[];
   
  for kk=1:50;  %50 repetitions
      for kkk=1:50;
      d=Nres(E,kk,:);
      d=d(:);
      ri = randi(50000,20000,1);
      d = d(ri);
      [nh,xh]=empcdf(d,20,xbin); Nh(kkk,:) = nh;
     % 
      figure(2); subplot(2,1,1);plot(xh,nh,color(E));
              title(['eps=' num2str(k(E))]) ;hold on; %Ecdf
      [nh,xh]=hist(d,100);
      subplot(2,1,2);plot(xh,nh,color(E));
              title(['eps=' num2str(k(E))]); hold on; %histogram
      end;
      N = [N;Nh];

  end;
end

% i=2:17;
% iC = (inv(cov(N(:,i))));
% y=N(:,i);y0=y-repmat(mean(y),2500,1);
% khi = sum(y0'.*(iC*y0'));
% [nh,xh]=hist(khi,20);
% chi_pf=chipf(xh,size(y0,2));
% nh=nh/sum(nh)/(xh(2)-xh(1));
% figure(3); plot(xh,chi_pf,'-sr'),hold on
% plot(xh,nh,'-ob')



function dx=kuramoto(x,K,N,Omega)
 

for ind =1:N
    dx(ind) = Omega(ind) + K/N*sum(sin(x-x(ind)));
end
dx = dx(:);

end
