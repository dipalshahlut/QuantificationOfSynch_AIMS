%% Kuramoto chain plot
clear all; clc; close all
%%% Order-std vector
chain = importdata('Kuramoto_OS_chain.mat');
True_param = {0.1, 0.3,0.5002, 0.8033, 2.5033, 5.5033};
case_Label ={'(a)', '(b)', '(c)', '(d)', '(e)', '(f)'};
chainplot(chain,case_Label,True_param);
 file save
saveas(gcf,['..\Article_fig\Kura_500N_OS.eps'],'epsc')

%%
function chainplot(chain,case_Label,True_param)
colormap winter
ccc=[0 1 0
        1 0 0
        0 0.3 1
        1 0 1
        0 1 1
        0 0.5 0 
        .3 .75 .93
        1 1 0
        0 1 1
        1 0.4 0.6];   % color code
Nbins =30;% number of bins for the hist 

for i=1:size(chain,2)
    [counts(:,i),centers(:,i)]=hist(chain{i}(3001:end),Nbins);hold on        
end

MaxBin = max(max(counts));  %  identify the max of all the bins
Counts = counts./MaxBin;  % height normalize all the counts to maximum bin
for i=1:size(chain,2)
  
    if i <= 4
    ind = 1;
    subplot(1,3,ind)
    b = bar(centers(:,i),Counts(:,i),'histc'), hold on   
    b.FaceColor = ccc(i,:); b.EdgeColor= ccc(i,:);hold on
%     set(gca,'Box','off')
%     set(b,'Position', [0.03 0.06 .03 .03])
    ylim([0 1.1]); 
    xlim([0 1]); 
    set(gca,'Ytick',([0:0.25:1.1]),'FontSize',16)
    set(gca,'Xtick',([0 0.5 1 ]),'FontSize',16)
%     set(gca, 'color', 'none'),
    set(gca,'YAxisLocation', 'left', 'XAxisLocation', 'bottom')
%      set(gca, 'Ycolor', 'none',  'XAxisLocation', 'bottom') 
    set(gca,'FontSize',16,'LineWidth',2);hold on
   %     xlabel('Coupling' ,'FontSize',18)%'Interpreter','latex');
%     plot([1 1], [0 1.1],'w','LineWidth',7), hold on
%     set(gcf,'color','w');
%     [M,ind] = max(Counts(:,i));
    elseif i == 5
     ind = 2;subplot(1,3,ind)
%     set(subplot(1,3,ind), 'Position', [-0.4941    0.0312, 0.4863    0.6111])
    b = bar(centers(:,i),Counts(:,i),'histc'), hold on   
    b.FaceColor = ccc(i,:); b.EdgeColor= ccc(i,:);hold on
    
    ylim([0 1.1]);hold on
    set(gca,'FontSize',16,'LineWidth',2);hold on
    set(gca,'YTickLabel', [],'YTick',[])
    xlim([2 3]), hold on
    set(gca,'Xtick',([2 2.5 3]),'FontSize',16)
%     set(gca, 'Ycolor', 'none',  'XAxisLocation', 'bottom')
%     set(gca,'Xtick',([2 3]),'FontSize',16)
%     [M,ind] = max(Counts(:,i));
    
    else 
    ind = 3;subplot(1,3,ind)
%     set(subplot(1,3,ind), 'Position', [-0.4941    0.0312, 0.4863    0.6111])
    b = bar(centers(:,i),Counts(:,i),'histc'), hold on   
    b.FaceColor = ccc(i,:); b.EdgeColor= ccc(i,:);hold on
%     set(b,'Position', [0.3 0.3 .3 .3])
    set(gca,'FontSize',16,'LineWidth',2);hold on
    ylim([0 1.1]);hold on
      set(gca,'YTickLabel', [],'YTick',[])
    xlim([5 6]); 
%     set(gca, 'Ycolor', 'none',  'XAxisLocation', 'bottom')  
    set(gca,'Xtick',([5 5.5 6]),'FontSize',16)

    end
    
end

end

