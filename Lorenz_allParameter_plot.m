%% supplementary figure 4

clear all; close all; clc
%addpath to the folder mcmcstat
addpath ../mcmcstat
chain = importdata('chain_L3_all_7_1fv.mat');
names = {'\beta','\sigma','\rho','\epsilon'}';
mcmcplot(chain,[],names,'pairs',3);hold on %(2000:end,:)

legend('Posterior distribution','Credible regions: 50%, 90%',...
    'True parameter value'), hold on


%%
