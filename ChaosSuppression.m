clear all; close all; clc

par0 = [ 0.165     0.2     10    0.165     0.2      10  0.255  ];
tspan =linspace(0,10000,2500);
for K=1:10;   
    par = par0.*(1+randn(1,7)*1e-3);
    In = rand(1,6);

    [t,sol] = ode45(@rossler,tspan,In,[],par);  % ode solver
    ind = 1001;
    sol = sol(ind:end,:); t = t(ind:end,:);  % remove inital perturbation

    plot3(sol(:,1),sol(:,2),sol(:,3),'.r'), hold on
    plot3(sol(:,4),sol(:,5),sol(:,6),'.b'); hold off
    set(gca, 'FontSize',16,'LineWidth',2);
    pause
end

function [dy] = rossler(t,y,par)
a_1 = par(1);
f_1 = par(2);
c_1 = par(3);
a_2 = par(4);
f_2 = par(5);
c_2 = par(6);
mu = par(7);
omega = 0.97+0.02;
w = 0.97-0.02;

ydot(1) = -omega*y(2)-y(3) + mu*(y(4)-y(1)); 
ydot(2) = omega*y(1)+a_1*y(2);
ydot(3) = f_1+y(3)*(y(1)-c_1);
ydot(4) = -w*y(5)-y(6) + mu*(y(1)-y(4));
ydot(5) = w*y(4)+a_2*y(5);
ydot(6) = f_2+y(6)*(y(4)-c_2);

dy = ydot(:);
end
