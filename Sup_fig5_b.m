%%  Supplementary figure 5 b)
clear all; clc; close all
tic 
%%
color = ['b','g','r','c','k','b','g','r','c','k','b'];
N=100;          % nu of oscillators
h=0.1;          % time increment
iter=5000;%90000; % time points
t=0:h:h*iter;   %  total time 
ens = 60;       % nu. of ensembles
Omega=rand(N,1);   % frequency for each oscillators
K_crit = mean(Omega); % critical coupling for synchronization
k = [K_crit-0.3, K_crit-0.2, K_crit, K_crit+0.2, K_crit+0.5 ];  % kappa (coupling strength) to estimate
k = [0.1,0.3, 0.5, 0.7, 0.9, 5.5]; % kappa (coupling strength) to estimate
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
        
        %% Kuramoto oscillators coordinates calculation on unit circle
        x1=cos(y1);    
        xx1=sin(y1);    
        
        %%  % residual distance calculation
        nres =[ std(x1,0,2); std(xx1,0,2)];

        %%
        Nres(ind,j,:) = nres; 
        [Ecdf,xh] = empcdf(nres,100); H(ind) = plot(xh,Ecdf,color(ind),'DisplayName', sprintf('K = %0.2f',k(ind)));hold on;
        x_xh(j,:) = xh;x_Ecdf(j,:) = Ecdf;
    end
    legend(H,'Location','southeast'), 
    legend boxoff
end
xlabel('[std(sin(S)),std(cos(S))]'), ylabel('ecdf')
% save x_Ecdf    
toc


function dx=kuramoto(x,K,N,Omega)
 

for ind =1:N
    dx(ind) = Omega(ind) + K/N*sum(sin(x-x(ind)));
end
dx = dx(:);

end
