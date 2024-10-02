%%  Supplementary figure 5
clear all; clc; close all
tic 
addpath ../mcmcstat
%%
color = ['b','g','r','c','k','b','g','r','c','k','b'];
N=500;          % nu of oscillators
h=1;%0.1;          % time increment
iter=2^13;%20000; % time points  5000;%
t=0:h:h*iter;   %  total time 
ens = 5;       % nu. of ensembles
Omega=rand(N,1);   % frequency for each oscillators  %ones(N,1);%
K_crit = mean(Omega); % critical coupling for synchronization
k = [K_crit-0.3, K_crit-0.2, K_crit, K_crit+0.2, K_crit+0.5,1.7,3.5,5], 
% k =[ 10];  % kappa (coupling strength) to estimate

% k = [0.1,0.3,0.5,0.7,0.9,1.3,1.7,3.5,5];
% k = [0.3 0.7 0.9];%k = 3;
k = 0.8;
for ind = 1:length(k) %loop through all different kappa 
    K = k(ind)  
    for j = 1:ens  % loop through all ensemble
        j
        In = 2*pi.*rand(N,1); 
        In = In.*(1+randn(N,1).*0.01);  % Initial condition In = (1:N)/N*2*pi;
        In1 = 2*pi.*rand(N,1); 
        In1 = In1.*(1+randn(N,1).*0.01);  % Initial condition 
        

%         In1 = In.*(1+randn(N,1).*0.01);  % Initial condition 
        %% model 

        tic
        [t1,y1] = ode23s(@(t,y)kuramoto(y,K,N,Omega),t,In);
        [t2,y2] = ode23s(@(t,y)kuramoto(y,K,N,Omega),t,In1);
         toc
         t1 = t1(2001:end,:);   t2 = t2(2001:end,:);
         y1 = y1(2001:end,:);   y2 = y2(2001:end,:); 
%          % 2nd model generated from the 1st model radom time points shuffling
%          Index = randperm(length(y1)); 
%          y2 = y1(Index,:);
         Model_1 =y1; 
         Model_2 = y2;
        
        %% Kuramoto oscillators coordinates calculation on unit circle
        x1=cos(Model_1);    x2=sin(Model_1); 
        xx1=cos(Model_2);    xx2=sin(Model_2);
        
        %%  % residual distance calculation
%         nres=sqrt(sum((x1-x2)'.^2 + (xx1-xx2)'.^2));

%         nres = [sum((x1-xx1).^2,2)
%             sum((x2-xx2).^2,2)].^(0.5);  

%         res_x = x1-xx1;  res_y = x2-xx2;
%         res_x = res_x';  res_y = res_y';
%         nres = [sum((res_x).^2)
%                 sum((res_y).^2)].^(0.5);  
%         nres = reshape(nres,[],1);

%         nres =[ mean(x1,2);mean(xx1,2);std(x2,0,2);std(xx2,0,2)];
%          nres =abs([mean(x2,2); mean(x1,2)]);
%           nres =[std(x1,0,2); std(x2,0,2)];
% % potential and order parameter
for ik = 1:length(t1)
    z1(ik,:) = 1/N*sum(exp(1i*y1(ik,:)));
    z2(ik,:) = 1/N*sum(exp(1i*y2(ik,:)));
    V1(ik,:) = potential(y1(ik,:),N);
    V2(ik,:) = potential(y2(ik,:),N);

end
z1 = abs(z1);
z2 = abs(z2);


% figure(4); plot(t1,z1,'-','Color',color(ind)); hold all%,t1,z2,'b-')
% figure(5); plot(t1,V1,'-','Color',color(ind)), hold all%,t1,V2,'b-')
% figure(6); plot(t1,std(y1,0,2),'-','Color',color(ind)), hold all%,t1,V2,'b-')

        nres = [z1];%[V1;V2]; %abs(z1);abs(z2)];%; 
        Nres(ind,j,:) = nres; 
        [Ecdf,xh] = empcdf(nres,100); H(ind) = plot(xh,Ecdf,color(ind),'DisplayName', sprintf('K = %0.2f',k(ind)));hold on;
        x_xh(j,:) = xh;x_Ecdf(j,:) = Ecdf;

    end
    legend(H)
    X_Ecdf(:,:,ind) =x_Ecdf;
end
%  xlabel('[std(cos(S)),std(sin(S))]'), ylabel('ecdf')
% xlabel('[mean(cos(S)),mean(sin(S))]'), ylabel('ecdf')
% save x_Ecdf  
toc
%%
% xbin = linspace(0.001,20,20);
% color = ['b','g','r','c','k','b','g','r','c','k','b'];
% for E=1:length(k);N=[];
%    
%   for kk=1:50;  %50 repetitions
%       for kkk=1:50;
%       d=Nres(E,kk,:);
%       d=d(:);
%       ri = randi(36000,26000,1);
%       d = d(ri);
%       [nh,xh]=empcdf(d,20,xbin); Nh(kkk,:) = nh;
%      % 
%       figure(2); subplot(2,1,1);plot(xh,nh,color(E));
%               title(['eps=' num2str(k(E))]) ;hold on; %Ecdf
%       [nh,xh]=hist(d,100);
%       subplot(2,1,2);plot(xh,nh,color(E));
%               title(['eps=' num2str(k(E))]); hold on; %histogram
%       end;
%       N = [N;Nh];
% 
%   end;
% end
% 
% i=2:17;
% iC = (inv(cov(N(:,i))));
% y=N(:,i);y0=y-repmat(mean(y),2500,1);
% khi = sum(y0'.*(iC*y0'));
% [nh,xh]=hist(khi,20);
% chi_pf=chipf(xh,size(y0,2));
% nh=nh/sum(nh)/(xh(2)-xh(1));
% figure(3); plot(xh,chi_pf,'-sr'),hold on
% plot(xh,nh,'-ob')

function v = potential(theta,N)
    % The potential.
    v = 0;
    for k = 1:N
        v = v + sum(sin((theta(:,k+1:end)-theta(:,k))/2).^2);
    end
    v = (4/N^2)*v;
end
function dx=kuramoto(x,K,N,Omega)
 
dx = Omega + K/N.*sum(sin(x-x'))';

end


% function indx = Cov_check(Y)
% 
% indx=[];
% for i=1:size(Y,2)
%     if std(Y(:,i))>1e-3 && std(Y(:,i))<0.5e1
%        indx =[indx,i];
%     end
%         
% end
% 
% end
% 
% function [x,khi_n,chi_pf] = chi2_test(Y)
% 
% Yave= mean(Y);
% Ystd = std(Y);
% Y0= Y-repmat(Yave,size(Y,1),1);
% C=cov(Y);
% iC = inv(C);
% khi2= sum(Y0'.*(iC*Y0'));
% [khi,x]=hist(khi2,50);
% khi_n = khi/sum(khi)/(x(2)-x(1));
% chi_pf=chipf(x,size(Y0,2));
% 
% end