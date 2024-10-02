%%  main text figure 1 a)
clear all; close all; clc
format short g
c_1 = 10;   %model parameter
a_1 = 0.165; f_1 = 0.2; 
c_2 = 10;
a_2 = 0.165; 
f_2 = 0.2; 

tspan =linspace(0,2500,25000);  %total time span
In = [12.106;-3.668;0.24694;3.0161;-3.2914;0.026991];  % initial condition
mu = [0.04];  % coupling parameter 
Label = ['a'];

par = [ a_1 f_1 c_1 a_2 f_2 c_2 mu]; %update model parameter for current mu
[t,sol] = ode45(@rossler,tspan,In,[],par); % solve ode
sol = sol(501:end,:); t = t(501:end,:); % remove 500 data points to remove init perturbation
figure(), hold on
plot(t(end-201:end,:),sol(end-201:end,1),'r','LineStyle','-','LineWidth',1.5),hold on
plot(t(end-201:end,:),sol(end-201:end,4),'b','LineStyle','-','LineWidth',1.5), hold on
plot([t(end-201,:) t(end,:)],[0 0],'k--'), hold on
xlim([2480 2500]),xticks([2480 2490 2500])
ylim([-20 20]),yticks([-20:20:20]);hold on
set(gca, 'FontSize',16,'LineWidth',2); box on, hold on 
% ylabel('x_1,x_2','FontSize', 16), xlabel('Time','FontSize', 16),hold on
text(2481,45,sprintf('(%c)',Label),'FontSize', 16, 'FontWeight','bold');
ylim([-20 50]),yticks([-20:20:50]);hold on
phi1 = unwrap(atan2(sol(:,2),sol(:,1))); 
phi2 = unwrap(atan2(sol(:,5),sol(:,4)));  
h = axes('Parent',gcf,'Position',[.60 .65 .25 .25]); hold on
box on
plot(t(end-201:end,:),abs(phi1(end-201:end,:)- phi2(end-201:end,:)),'r-','LineWidth',2), hold on
set(h,'Xlim',[2480 2500]);
set(h,'Ylim',[0.5 1.5])
ylabel('$\mid \phi_1 - \phi_2 \mid$', 'FontSize', 14,'Interpreter','latex')


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


