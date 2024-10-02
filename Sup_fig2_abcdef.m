%%  supplementary text figure 2
clear all; close all; clc
c_1 = 10;
a_1 = 0.165; f_1 = 0.2; 
c_2 = 10;
a_2 = 0.165; 
f_2 = 0.2; 

tspan =linspace(0,2500,2500);
In=[6.5539,3.8583,0.068843,-9.3519,-12.424,0.010047];
In=In.*(1+randn(1,6).*0.01);
mu = [0.01, 0.04, 0.14, 0.2, 0.24, 0.35];
Label = ['a', 'b', 'c', 'd', 'e', 'f'];
for i = 1:length(mu)
    par = [ a_1 f_1 c_1 a_2 f_2 c_2 mu(i)];
    [t,sol] = ode45(@rossler,tspan,In,[],par); 
    sol = sol(501:end,:); t = t(501:end,:);
    figure;
    plot3(sol(:,1),sol(:,2),sol(:,3),'.r'), hold on
    plot3(sol(:,4),sol(:,5),sol(:,6),'.b')
    set(gca, 'FontSize',16,'LineWidth',2);
    xlim([-20 20]),xticks([-20:20:20]);
    ylim([-20 20]),yticks([-20:20:20]);
    zlim([0 50]),zticks([0:25:50]);
    text(-18,18,45,sprintf('(%c)',Label(i)),'FontSize', 18, 'FontWeight','bold')%,'Interpreter','latex')
    set(gca,'LineWidth',2);
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
