clear all; close all; clc 
N = 200; %number of oscillators
dt = 0.05; %time increment
T = 2500; %time horizon
W = rand(N,1);%-1/2; %frequencies drawn from a uniform distribution
dK = 0.03; %coupling strength increment
K = []; %declare array for values of K to be used
k = 25;%51; %number of values of K to be used
r = []; %declare array for values of r to be obtained

tic
for i = 1:k
K(i,1) = i*dK-dK; %coupling strengths run from 0 to 1.5
X = zeros(N,1); %initialize phases to zero
for t = 1:T
real_part = 1/N*sum(arrayfun(@(y) cos(y),X)); %determine real part
%of order parameter
imag_part = 1/N*sum(arrayfun(@(y) sin(y),X)); %determine imag part
%of order parameter
r(i,t) = sqrt((real_part)^2+(imag_part)^2);
psi = 2*atan(imag_part/(r(i,t)+real_part));
A = arrayfun(@(x,y) K(i,1)*r(i,t)*sin(psi-x)+y,X,W(:,1));
X = X + A*dt; %update X according to Euler method
end

figure(1), hold all
plot(r(i,:),'.-b'), hold on
end
% figure
% plot(K,mean(r,2)), hold on
toc
figure
errorbar(K,mean(r(1:k,1500:2500),2),std(r(1:k,1500:2500),0,2),'.k')
axis([0 1.5 0 1])
xlabel('K')
ylabel('r')

%%
function  [xx,yy,zz] = torus(r,n,a)

%TORUS Generate a torus

%      torus(r,n,a) generates a plot of a torus with central

%      radius  a  and lateral radius  r.  n  controls the number

%      of facets on the surface.  These input variables are optional

%      with defaults  r = 0.5, n = 20, a = 1.

%

%      [x,y,z] = torus(r,n,a) generates three (n+1)-by-(2n+1)

%      matrices so that surf(x,y,z) will produce the torus.



if nargin < 3, a = 1; end

if nargin < 2, n = 20; end

if nargin < 1, r = 0.5; end

theta = pi*(0:2*n)/n;
phi   = 2*pi*(0:n)'/n;
x = (a + r*cos(phi))*cos(theta);
y = (a + r*cos(phi))*sin(theta);
z = r*sin(phi)*ones(size(theta));

if nargout == 0
   surf(x,y,z)
   ar = (a + r)/sqrt(2);
   axis([-ar,ar,-ar,ar,-ar,ar])
else
    xx = x; yy = y; zz = z;
end
end
