%%  Bidirectional Mismatch Lorenz chain plot
clear all; clc; close all

chain = importdata('Lorenz_bi_chain.mat'); 
case_Label ={'$B$', '$B''$','$B''''$','$C$','$C''$','$D$','$D''$','$D''''$'};
chainplot(chain,case_Label);

function chainplot(chain,case_Label)
colormap winter
ccc=[1 0 0
     1 0 1
     .3 .75 .93
     0 0 1
     0 1 0
     0.47 0.67 0.19
     0 0.67 0     
     1 1 0
     0 1 1
     1 0.4 0.6]; % color code 
Nbins =30;% number of bins for the hist 

for i=1:size(chain,2)
    [counts(:,i),centers(:,i)]=hist(chain{i}(2001:end),Nbins);hold on        
end

MaxBin = max(max(counts));  %  identify the max of all the bins
Counts = counts/MaxBin;  % height normalize all the counts to maximum bin

for i=1:size(chain,2)
    b = bar(centers(:,i),Counts(:,i),'histc'), hold on
    b.FaceColor = ccc(i,:); b.EdgeColor= ccc(i,:);hold on
    set(gca,'FontSize',16,'LineWidth',2);hold on
    b = bar(centers(:,i),Counts(:,i),'histc'), hold on
    b.FaceColor = ccc(i,:); b.EdgeColor= ccc(i,:);hold on
    xlim([0 11]);xticks([0 2 4 6 8 11]);hold on

    ylim([0 1.1]);
    set(gca,'Ytick',([0:0.25:1.1]),'FontSize',16)
    set(gca,'Box','on','LineWidth',2)
    xlabel('$\textbf {Coupling}$ ' ,'Interpreter','latex',...
    'FontSize',16);
    
    [M,ind] = max(Counts(:,i));
    if max(Counts(:,i)) == 1
        text(centers(ind,i),Counts(ind,i)+0.05,sprintf('%s',case_Label{i}),...
            'FontSize',14,'Interpreter','latex');hold on  %-0.1
    else
        text(centers(10,i),Counts(ind,i)+0.02,sprintf('%s',case_Label{i}),...
            'FontSize',14,'Interpreter','latex');hold on %+0.05
    end
end

end

