%plots models vs VAR impulse responses for model-specific estimated
%parameters

clear all

cd 5_SimpleWageRule
load resultsSimpleWRule
respSimpleWageRule_mon=model_resp_mon_baseline;
respSimpleWageRule_itech=model_resp_itech_baseline;
respSimpleWageRule_ntech=model_resp_ntech_baseline;
cd ..

cd 6_GeneralWageRule
load resultsGeneralWRule
respGeneralWageRule_mon=model_resp_mon_baseline;
respGeneralWageRule_itech=model_resp_itech_baseline;
respGeneralWageRule_ntech=model_resp_ntech_baseline;
cd ..


cd 1_AOB
load resultsAltOffer
respAltOfferHiring_mon=model_resp_mon_baseline;
respAltOfferHiring_itech=model_resp_itech_baseline;
respAltOfferHiring_ntech=model_resp_ntech_baseline;
cd ..


%some useful variables
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

reorderidx=[10 2  6 10 2  6 10 2  6];

pp=0;

figure('Name','VAR vs. Model');
legend_string={}; %empty cell for legend

for plt=1:9,
    pp=pp+1;
    
    subplot(3,3,plt)
    
    if plt<=3,
        grpyat = [ [(0:pnstep-1)'  policyresponseLOW(:,reorderidx( pp))] ; [(pnstep-1:-1:0)'  policyresponseHIGH(pnstep:-1:1,reorderidx( pp))]];
        patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on
        plot(time, policyresponse(1:pnstep,reorderidx( pp)),'k','LineWidth',linewidth-1.5); hold on
        
        plot(time,respAltOfferHiring_mon(reorderidx( pp),1:pnstep),'b-o','LineWidth',linewidth,'MarkerSize',4); hold on
        plot(time,respSimpleWageRule_mon(reorderidx( pp),1:pnstep),'r-s','LineWidth',linewidth,'MarkerSize',4); hold on
        plot(time,respGeneralWageRule_mon(reorderidx( pp),1:pnstep),'y--','LineWidth',linewidth,'MarkerSize',4); hold on
        plot(time,respAltOfferHiring_mon(reorderidx( pp),1:pnstep),'b-o','LineWidth',linewidth,'MarkerSize',4); hold on
                
        if plt==1,
            ylabel('Monetary Policy Shock','FontSize',10,'FontWeight','bold');
        end
    elseif plt>3 && plt<=6,
        
        grpyat = [ [(0:pnstep-1)'  zresponseLOW(:,reorderidx( pp))] ; [(pnstep-1:-1:0)'  zresponseHIGH(pnstep:-1:1,reorderidx( pp))]];
        patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on
        plot(time, zresponse(1:pnstep,reorderidx( pp)),'k','LineWidth',linewidth-1.5); hold on
        
        plot(time,respAltOfferHiring_ntech(reorderidx( pp),1:pnstep),'b-o','LineWidth',linewidth,'MarkerSize',4); hold on
        plot(time,respSimpleWageRule_ntech(reorderidx( pp),1:pnstep),'r-s','LineWidth',linewidth,'MarkerSize',4); hold on
        plot(time,respGeneralWageRule_ntech(reorderidx( pp),1:pnstep),'y--','LineWidth',linewidth,'MarkerSize',4); hold on
        plot(time,respAltOfferHiring_ntech(reorderidx( pp),1:pnstep),'b-o','LineWidth',linewidth,'MarkerSize',4); hold on
                
        if plt==4,
            ylabel('Neutral Technology Shock','FontSize',10,'FontWeight','bold');
        end
        
    elseif plt>6,
        
        grpyat = [ [(0:pnstep-1)'  uresponseLOW(:,reorderidx( pp))] ; [(pnstep-1:-1:0)'  uresponseHIGH(pnstep:-1:1,reorderidx( pp))]];
        patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on
        plot(time, uresponse(1:pnstep,reorderidx( pp)),'k','LineWidth',linewidth-1.5); hold on
                
        plot(time,respAltOfferHiring_itech(reorderidx( pp),1:pnstep),'b-o','LineWidth',linewidth,'MarkerSize',4); hold on
        plot(time,respSimpleWageRule_itech(reorderidx( pp),1:pnstep),'r-s','LineWidth',linewidth,'MarkerSize',4); hold on
        plot(time,respGeneralWageRule_itech(reorderidx( pp),1:pnstep),'y--','LineWidth',linewidth,'MarkerSize',4); hold on
        plot(time,respAltOfferHiring_itech(reorderidx( pp),1:pnstep),'b-o','LineWidth',linewidth,'MarkerSize',4); hold on
                
        if plt==7,
            ylabel('Invest. Technology Shock','FontSize',10,'FontWeight','bold');
        end        
    end
    
    hold off
    title(data_varnames(reorderidx( pp)),'FontSize',fontsize);
    set(gca,'FontSize',fontsize);
    axis tight
end

legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Alternating Offer Bargaining',' Simple Wage Rule',' General Wage Rule'};


suptitle('Figure 7: Impulse Responses to Shocks: Simple and General Wage Rules');
legend1=legend(legend_string, 'Orientation','horizontal');
set(legend1,'Position',[0.319176519097222 0.912648419243481 0.384385850694444 0.0291524459613197],'box','off');
text(-20, -.45,'Notes: x-axis: quarters, y-axis: percent','FontSize',12);
orient landscape;
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [-1 -0.1 13 8.4]);