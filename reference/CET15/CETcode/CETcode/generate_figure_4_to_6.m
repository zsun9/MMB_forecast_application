%plots models vs VAR impulse responses for same estimated parameters

clear all

cd 2a_Nash
load resultsNash
respNash_mon=model_resp_mon_baseline;
respNash_itech=model_resp_itech_baseline;
respNash_ntech=model_resp_ntech_baseline;

load resultsNashfixedpara
respNashperturb_mon=model_resp_mon_baseline;
respNashperturb_itech=model_resp_itech_baseline;
respNashperturb_ntech=model_resp_ntech_baseline;
cd ..

cd 2b_Nash_Dw037estimated
load resultsNashDw037estimated
respNashReest_mon=model_resp_mon_baseline;
respNashReest_itech=model_resp_itech_baseline;
respNashReest_ntech=model_resp_ntech_baseline;
cd ..


%useful variables
horizon=15;
conflevel=0.95;
factor=-norminv((1-conflevel)/2);
pnstep=horizon;
linewidth=2;
fontsize=12;
markersize=5;

time=[0:1:pnstep-1];

%VAR responses and standard deviations
%%Monetary Shock
policyresponse = -IRFFF(1:pnstep,:);
policyresponseHIGH=policyresponse+factor*IRFFFSE(1:pnstep,:);
policyresponseLOW=policyresponse-factor*IRFFFSE(1:pnstep,:);
%annualize
policyresponseLOW(:,[2,3])=policyresponseLOW(:,[2,3])*4;
policyresponseHIGH(:,[2,3])=policyresponseHIGH(:,[2,3])*4;
policyresponse(:,[2,3])=policyresponse(:,[2,3])*4;

%%Neutral Tech Shock
zresponse = IRFz(1:pnstep,:);
zresponseHIGH=zresponse+factor*IRFzSE(1:pnstep,:);
zresponseLOW=zresponse-factor*IRFzSE(1:pnstep,:);
%annualize
zresponseLOW(:,[2,3])=zresponseLOW(:,[2,3])*4;
zresponseHIGH(:,[2,3])=zresponseHIGH(:,[2,3])*4;
zresponse(:,[2,3])=zresponse(:,[2,3])*4;


%%Invest Tech Shock
uresponse = IRFu(1:pnstep,:);
uresponseHIGH=uresponse+factor*IRFuSE(1:pnstep,:);
uresponseLOW=uresponse-factor*IRFuSE(1:pnstep,:);
%annualize
uresponseLOW(:,[2,3])=uresponseLOW(:,[2,3])*4;
uresponseHIGH(:,[2,3])=uresponseHIGH(:,[2,3])*4;
uresponse(:,[2,3])=uresponse(:,[2,3])*4;


reorderidx=[1  10 2 3  5   6 7  9 8 4 12 11  ];

%%%%%%%%%%%%%%%%%%%%%%%%
%Invest. Techn. Shock %%
%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','Invest. Techn. Shock: VAR vs. Model');
legend_string={}; %empty cell for legend
for plotindx=1:1:size(policyresponse,2);
    subplot(3,4,plotindx)
    grpyat = [ [(0:pnstep-1)'  uresponseLOW(:,reorderidx(plotindx))] ; [(pnstep-1:-1:0)'  uresponseHIGH(pnstep:-1:1,reorderidx(plotindx))]];
    patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on
    plot(time, uresponse(1:pnstep,reorderidx(plotindx)),'k','LineWidth',linewidth-1.5); hold on    
    
    plot(time,respNash_itech(reorderidx(plotindx),1:pnstep),'ro-','LineWidth',linewidth,'MarkerSize',4); hold on
    plot(time,respNashperturb_itech(reorderidx(plotindx),1:pnstep),'k--','LineWidth',linewidth); hold on
    plot(time,respNashReest_itech(reorderidx(plotindx),1:pnstep),'g--','LineWidth',linewidth); hold on
    
    if plotindx==1,
        legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean','Nash','Nash (D/w=0.37)','Nash (D/w=0.37,re-estimated)'}; %legend string
    end
    
    hold off
    title(data_varnames(reorderidx(plotindx)),'FontSize',fontsize);
    set(gca,'FontSize',fontsize);
    axis tight
end
suptitle('Figure 6: Responses to an Investment Specific Technology Shock: Nash Bargaining');
legend1=legend(legend_string, 'Orientation','horizontal');
set(legend1,'Position',[0.319176519097222 0.912648419243481 0.384385850694444 0.0291524459613197],'box','off');
text(-35, -4.5+1.15,'Notes: x-axis: quarters, y-axis: percent','FontSize',12);
orient landscape;
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [-1.25 -0.4 13.4 8.75]);



%%%%%%%%%%%%%%%%%%%%%%%%
%Neutral Techn. Shock %%
%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','Neutral Techn. Shock: VAR vs. Model');
legend_string={}; %empty cell for legend
for plotindx=1:1:size(policyresponse,2);
    subplot(3,4,plotindx)
    grpyat = [ [(0:pnstep-1)'  zresponseLOW(:,reorderidx(plotindx))] ; [(pnstep-1:-1:0)'  zresponseHIGH(pnstep:-1:1,reorderidx(plotindx))]];
    patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on
    plot(time, zresponse(1:pnstep,reorderidx(plotindx)),'k','LineWidth',linewidth-1.5); hold on
    
    plot(time,respNash_ntech(reorderidx(plotindx),1:pnstep),'ro-','LineWidth',linewidth,'MarkerSize',4); hold on    
    plot(time,respNashperturb_ntech(reorderidx(plotindx),1:pnstep),'k--','LineWidth',linewidth); hold on
    plot(time,respNashReest_ntech(reorderidx(plotindx),1:pnstep),'g--','LineWidth',linewidth); hold on   
    
    if plotindx==1,        
        legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean','Nash','Nash (D/w=0.37)','Nash (D/w=0.37,re-estimated)'}; %legend string
    end
    hold off
    title(data_varnames(reorderidx(plotindx)),'FontSize',fontsize);
    set(gca,'FontSize',fontsize);
    axis tight   
    
end

suptitle('Figure 5: Responses to a Neutral Technology Shock: Nash Bargaining');

legend1=legend(legend_string, 'Orientation','horizontal');
set(legend1,'Position',[0.319176519097222 0.912648419243481 0.384385850694444 0.0291524459613197],'box','off');
text(-35, -5.5+1.25,'Notes: x-axis: quarters, y-axis: percent','FontSize',12);
orient landscape;
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [-1.25 -0.4 13.4 8.75]);



%%%%%%%%%%%%%%%%%%%%%%%%
%Monetary Shock Plot  %%
%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','Nominal Interest Rate Shock: VAR vs. Model');
legend_string={}; %empty cell for legend
for plotindx=1:1:size(policyresponse,2);
    subplot(3,4,plotindx)
    grpyat = [ [(0:pnstep-1)'  policyresponseLOW(:,reorderidx(plotindx))] ; [(pnstep-1:-1:0)'  policyresponseHIGH(pnstep:-1:1,reorderidx(plotindx))]];
    patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on
    plot(time, policyresponse(1:pnstep,reorderidx(plotindx)),'k','LineWidth',linewidth-1.5); hold on  
    
    plot(time,respNash_mon(reorderidx(plotindx),1:pnstep),'ro-','LineWidth',linewidth,'MarkerSize',4); hold on    
    plot(time,respNashperturb_mon(reorderidx(plotindx),1:pnstep),'k--','LineWidth',linewidth); hold on
    plot(time,respNashReest_mon(reorderidx(plotindx),1:pnstep),'g--','LineWidth',linewidth); hold on
    
    if plotindx==1,
        legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean','Nash','Nash (D/w=0.37)','Nash (D/w=0.37,re-estimated)'}; %legend string
        
    end
    hold off
    title(data_varnames(reorderidx(plotindx)),'FontSize',fontsize);
    set(gca,'FontSize',fontsize);
    axis tight
end

suptitle('Figure 4: Responses to a Monetary Policy Shock: Nash Bargaining');
legend1=legend(legend_string, 'Orientation','horizontal');
set(legend1,'Position',[0.319176519097222 0.912648419243481 0.384385850694444 0.0291524459613197],'box','off');
text(-35, -4+1.15,'Notes: x-axis: quarters, y-axis: percent','FontSize',12);
orient landscape;
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [-1.25 -0.4 13.4 8.75]);


