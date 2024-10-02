%% Lorenz chain plot
clear all; clc; close all
%%% Position vector
chain = importdata('Lorenz_S_chain.mat'); 

%%% Residual vector
chain = importdata('Lorenz_R_chain.mat'); 

%%% Position-Residual vector
chain = importdata('Lorenz_SR_chain.mat'); 

case_Label ={'$B$', '$B''$', '$C$', '$C''$', '$D$'};
chainplot(chain,case_Label);

%% Rossler chain plot
clear all; clc; close all
%%% Position vector
% chain = importdata('Rossler_S_chain.mat'); 

%%% Residual vector
% chain = importdata('Rossler_R_chain.mat'); 

%%% Position-Residual vector
% chain = importdata('Rossler_SR_chain.mat'); 

% case_Label ={'$A$','$B$','$C$','$D$','$E$','$F$','$F''$'};
% chainplot(chain,case_Label);

%%  Bidirectional Mismatch Lorenz chain plot
clear all; clc; close all

chain = importdata('Lorenz_bi_chain.mat'); 
case_Label ={'$B$', '$B''$','$B''''$','$C$','$C''$','$D$','$D''$','$D''''$'};
Coupling = [1 3 5 6 7 8 9 10];
chainplot(chain,case_Label,Coupling);