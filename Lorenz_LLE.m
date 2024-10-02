clear all; close all; clc

init1=0.001*randn(1,6)+[1.3536,2.4149,11.541,-3.8652,-9.4223,12.679];
init1 =[-9.8585;-2.6758;35.715;-10.01;-3.0352;35.729];
%[3.9022,6.2365,16.4244,3.9031,6.2381,16.4213];
% init2=0.01*randn(1,6)+[3.9022,6.2365,16.4244,3.9031,6.2381,16.4213];
%[1.3536,2.4149,11.541,-3.8652,-9.4223,12.679];
tspan = linspace(0,2500,25000);   % total time span
mu = [7.0:0.1:8]';

for ind = 1:length(mu)
% relative tolerance for ode solver step size 
options=odeset('RelTol',1.0e-6);

Mu = mu(ind);
% integrate lorentz equations with different initial conditions
[t,x1]=ode45(@fun_lorenz,tspan,init1,[],Mu);
% [t,y1]=ode45(@fun_lorenz,tspan,init2,options,Mu);

% calculate time array size
N=length(t);

N4=round(N/4); % first quartile
N2=round(N/2); % second quartile (median)

% calculate L2-norm of difference
for i=1:N
    z(i)=norm(x1(i,1:3)-x1(i,4:6)); % find L2 norm
end

% normalize differences
Z=z'/z(1);

% restrict interval to second quartile of data
a=t(N4:N2);
b=log(Z(N4:N2));

% the slope of this curve is the maximal lyapunov exponent
res=polyfit(a,b,1);
lyapunov_exponent(ind)=res(1);
clear z
clear Z
clear res
end
figure; plot(mu,lyapunov_exponent(:),'rs-'), hold on
plot([mu(1) mu(end)],[0 0],'k--'), hold on

function [dy] = fun_lorenz(t,y,c)
beta1 =8/3;
sigma1 =10;
rho1 =28;
beta2 =8/3;
sigma2 =10;
rho2 =28; 
ydot(1) = sigma1*y(2)-sigma1*y(1);%+ mu*(y(4)-y(1));
ydot(2) = y(1)*rho1-(y(1)*y(3))-y(2);
ydot(3) =( y(1)*y(2)-beta1*y(3));
ydot(4) = sigma2*(y(5))-sigma2*y(4)+ c*(y(1)-y(4));
ydot(5) = y(4)*rho2-(y(4)*y(6))-y(5);
ydot(6) = (y(4)*y(5)-beta2*y(6));

dy = ydot(:);
end

