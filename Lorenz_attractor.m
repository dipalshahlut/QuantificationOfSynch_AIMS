%%  main text figure 1
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

%%  supplementary text figure 1 

tspan =linspace(0,2500,2500);   % total time span
y = 0.001*randn(1,6)+ [3.9022,6.2365,16.4244,3.9031,6.2381,16.4213]; % initial condition
theta=[8/3;10;28;   % model parameter
    8/3;10;28];
mu = [0, 1, 6, 8];  %  coupling parameter
mu = 7
Label = ['a', 'b', 'c', 'd']; % figure label
for i =1:length(mu)  % loop through all coupling param (mu)
    Theta = [theta;mu(i)];  % update model parameter
    [t,s] = ode45(@fun_lorenz,tspan,y,[],Theta);  % ode solver
    t=t(101:end,:); s = s(101:end,:);  % remove inital perturbation
    figure();
    plot3(s(:,1),s(:,2),s(:,3),'r.'), hold on
    plot3(s(:,4),s(:,5),s(:,6),'b.'), hold on
    xlim([-20 20]),xticks([-20:20:20]);
    ylim([-40 40]),yticks([-40:40:40]);
    zlim([0 50]),zticks([0:25:50]);
    set(gca, 'FontSize',16,'LineWidth',2);
    text(-18,38,45,sprintf('(%c)',Label(i)),'FontSize', 18, 'FontWeight','bold')
    
end

function [dy] = fun_lorenz(t,y,par)
beta1 =par(1);
sigma1 =par(2);
rho1 =par(3);
beta2 =par(4);
sigma2 =par(5);
rho2 =par(6); 
mu = par(7);

ydot(1) = sigma1*y(2)-sigma1*y(1);%+ mu*(y(4)-y(1));
ydot(2) = y(1)*rho1-(y(1)*y(3))-y(2);
ydot(3) =( y(1)*y(2)-beta1*y(3));
ydot(4) = sigma2*(y(5))-sigma2*y(4)+ mu*(y(1)-y(4));
ydot(5) = y(4)*rho2-(y(4)*y(6))-y(5);
ydot(6) = (y(4)*y(5)-beta2*y(6));

dy = ydot(:);
end 