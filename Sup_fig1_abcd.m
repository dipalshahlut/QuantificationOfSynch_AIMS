%%  Supplementary text figure 1
clear all; close all; clc
tspan =linspace(0,2500,2500);   % total time span
y = 0.001*randn(1,6)+ [3.9022,6.2365,16.4244,3.9031,6.2381,16.4213]; % initial condition
theta=[8/3;10;28;   % model parameter
    8/3;10;28];
mu = [0, 1, 6, 8];  %  coupling parameter
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