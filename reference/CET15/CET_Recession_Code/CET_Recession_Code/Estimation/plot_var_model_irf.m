%plot VAR vs. model impulse responses

conflevel=0.95;
factor=-norminv((1-conflevel)/2);
pnstep=horizon;
linewidth=2.5;
fontsize=12;
time=[0:1:pnstep-1];

show_mon=1;
show_ntech=1;
show_itech=1;
show_pinvest=1;


global select_idx
select_idx=1:13;

get_VAR_resp;

%VAR responses and standard deviations
%%Monetary Shock
policyresponse = -IRFFF(1:pnstep,:);
policyresponseHIGH=policyresponse+factor*IRFFFSE(1:pnstep,:);
policyresponseLOW=policyresponse-factor*IRFFFSE(1:pnstep,:);
%convert Inflation, FF to annual percent
policyresponseLOW(:,[2,3])=policyresponseLOW(:,[2,3])*4;
policyresponseHIGH(:,[2,3])=policyresponseHIGH(:,[2,3])*4;
policyresponse(:,[2,3])=policyresponse(:,[2,3])*4;

%%Neutral Tech Shock
zresponse = IRFz(1:pnstep,:);
zresponseHIGH=zresponse+factor*IRFzSE(1:pnstep,:);
zresponseLOW=zresponse-factor*IRFzSE(1:pnstep,:);
%convert Inflation, FF to annual percent
zresponseLOW(:,[2,3])=zresponseLOW(:,[2,3])*4;
zresponseHIGH(:,[2,3])=zresponseHIGH(:,[2,3])*4;
zresponse(:,[2,3])=zresponse(:,[2,3])*4;


%%Invest Tech Shock
uresponse = IRFu(1:pnstep,:);
uresponseHIGH=uresponse+factor*IRFuSE(1:pnstep,:);
uresponseLOW=uresponse-factor*IRFuSE(1:pnstep,:);
%convert Inflation, FF to annual percent
uresponseLOW(:,[2,3])=uresponseLOW(:,[2,3])*4;
uresponseHIGH(:,[2,3])=uresponseHIGH(:,[2,3])*4;
uresponse(:,[2,3])=uresponse(:,[2,3])*4;


reorderidx=[1  10 2 3  5   6 7  12 8 4 13 11  ];
%note that relative price of investment is variable ordered no. 9. Left out
%here. Plotted in last plot below.


if show_itech==1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Investment Tech Shock Plot  %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure('Name','Investment Techn. Shock: VAR vs. Model');
    legend_string={}; %empty cell for legend
    
    for plotindx=1:1:size(policyresponse,2)-1;
        subplot(3,4,plotindx)
        grpyat = [ [(0:pnstep-1)'  -uresponseLOW(:,reorderidx(plotindx))] ; [(pnstep-1:-1:0)'  -uresponseHIGH(pnstep:-1:1,reorderidx(plotindx))]];
        patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on
        plot(time, -uresponse(1:pnstep,reorderidx(plotindx)),'k','LineWidth',linewidth-1.5); hold on
        if options_.bayesian_irf==1,
            plot(time,-model_resp_itech_HPDinf_baseline(reorderidx(plotindx),1:pnstep),'b--','LineWidth',linewidth-1); hold on
            plot(time,-model_resp_itech_Mean_baseline(reorderidx(plotindx),1:pnstep),'b-','LineWidth',linewidth); hold on
            plot(time,-model_resp_itech_HPDsup_baseline(reorderidx(plotindx),1:pnstep),'b--','LineWidth',linewidth-1); hold on
        else
            plot(time,-model_resp_itech_baseline(reorderidx(plotindx),1:pnstep),'b-','LineWidth',linewidth); hold on
        end
        if do_perturb==0
            if options_.bayesian_irf==1,
                legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model 95%',' Model Mean'}; %legend string
            else
                legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model'}; %legend string
            end
        else
            if options_.bayesian_irf==1,
                legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model 95%',' Model Mean',['Model: ',parastring, ' changed from ',num2str(oldparaval),' to ',num2str(newparaval)]}; %legend string
            else
                legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model',['Model: ',parastring, ' changed from ',num2str(oldparaval),' to ',num2str(newparaval)]}; %legend string
            end
        end
        
        if do_perturb==1
            plot(time,-model_resp_itech_perturb(reorderidx(plotindx),1:pnstep),'r--','LineWidth',linewidth); hold on
        end
        hold off
        title(data_varnames(reorderidx(plotindx)),'FontSize',fontsize);
        set(gca,'FontSize',fontsize);
        axis tight
        if plotindx==1  || plotindx==5 || plotindx==6 || plotindx==7
            axis([0 14 -0.75 0.3 ])
        elseif plotindx==8
            axis([0 14 -0.3 0.3 ])
        elseif plotindx==2
            axis([0 14  -0.25 0.25])
        elseif   plotindx==4
            axis([0 14  -0.5 0.45])
        elseif plotindx==3
            axis([0 14 -0.25 0.9 ])
        elseif plotindx==9 || plotindx==10 || plotindx==11
            axis([0 14  -2.1 1.6])
        else
            axis([0 14  -5 3.5])
        end
    end
    % Create super-title
    suptitle('Figure 3: Impulse Responses to Negative Innovation in Investment-Specific Technology');
    legend1=legend(legend_string, 'Orientation','horizontal');
    set(legend1,'Position',[0.319176519097222 0.912648419243481 0.384385850694444 0.0291524459613197],'box','off');
    text('String','Notes: x-axis in quarters.',...
        'Position',[-37.2142857142857 -6.9096574196249 17.3205080756888],...
        'FontSize',12);
    orient landscape;
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperUnits', 'inches');
    set(gcf, 'PaperPosition', [-.8 0 12.25 8.15]);
    
    if do_perturb==0
        print('-depsc','VAR_vs_Model_itech');
        print('-dpdf','VAR_vs_Model_itech');
        saveas(gcf, 'VAR_vs_Model_itech', 'fig');
    else
        print('-depsc','VAR_vs_Model_itech_perturb');
        print('-dpdf','VAR_vs_Model_itech_perturb');
        saveas(gcf, 'VAR_vs_Model_itech_perturb', 'fig');
    end
end


if show_ntech==1,
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Neutral Tech Shock Plot  %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure('Name','Neutral Techn. Shock: VAR vs. Model');
    legend_string={}; %empty cell for legend
    for plotindx=1:1:size(policyresponse,2)-1;
        subplot(3,4,plotindx)
        grpyat = [ [(0:pnstep-1)'  -zresponseLOW(:,reorderidx(plotindx))] ; [(pnstep-1:-1:0)'  -zresponseHIGH(pnstep:-1:1,reorderidx(plotindx))]];
        patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on
        plot(time, -zresponse(1:pnstep,reorderidx(plotindx)),'k','LineWidth',linewidth-1.5); hold on
        if options_.bayesian_irf==1,
            plot(time,-model_resp_ntech_HPDinf_baseline(reorderidx(plotindx),1:pnstep),'b--','LineWidth',linewidth-1); hold on
            plot(time,-model_resp_ntech_Mean_baseline(reorderidx(plotindx),1:pnstep),'b-','LineWidth',linewidth); hold on
            plot(time,-model_resp_ntech_HPDsup_baseline(reorderidx(plotindx),1:pnstep),'b--','LineWidth',linewidth-1); hold on
        else
            plot(time,-model_resp_ntech_baseline(reorderidx(plotindx),1:pnstep),'b-','LineWidth',linewidth); hold on
        end
        if do_perturb==0
            if options_.bayesian_irf==1,
                legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model 95%',' Model Mean'}; %legend string
            else
                legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model'}; %legend string
            end
        else
            if options_.bayesian_irf==1,
                legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model 95%',' Model Mean',['Model: ',parastring, ' changed from ',num2str(oldparaval),' to ',num2str(newparaval)]}; %legend string
            else
                legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model',['Model: ',parastring, ' changed from ',num2str(oldparaval),' to ',num2str(newparaval)]}; %legend string
            end
        end
        
        if do_perturb==1
            plot(time,-model_resp_ntech_perturb(reorderidx(plotindx),1:pnstep),'r--','LineWidth',linewidth); hold on
        end
        hold off
        title(data_varnames(reorderidx(plotindx)),'FontSize',fontsize);
        set(gca,'FontSize',fontsize);
        axis tight
        
        if plotindx==1  || plotindx==5 || plotindx==6 || plotindx==7
            axis([0 14 -0.85 0.25 ])
        elseif plotindx==8
            axis([0 14 -0.6 0.25 ])
        elseif plotindx==2
            axis([0 14 -0.25 0.25 ])
        elseif   plotindx==4
            axis([0 14 -0.25 0.45 ])
        elseif plotindx==3
            axis([0 14  -0.25 0.9])
        elseif plotindx==9 || plotindx==10 || plotindx==11
            axis([0 14  -2.1 1.6])
        else
            axis([0 14 -4 3.5 ])
        end
        
        
    end
    % Create super-title
    %suptitle('Figure 2: Impulse Responses to a Negative Permanent Neutral Technology Shock');
    suptitle('Figure 2: Impulse Responses to Negative Innovation in Neutral Technology');
    legend1=legend(legend_string, 'Orientation','horizontal');
    set(legend1,'Position',[0.319176519097222 0.912648419243481 0.384385850694444 0.0291524459613197],'box','off');
    text('String','Notes: x-axis in quarters.',...
        'Position',[-37.2142857142857 -5.56352841949488 17.3205080756888],...
        'FontSize',12);
    orient landscape;
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperUnits', 'inches');
    set(gcf, 'PaperPosition', [-.8 0 12.25 8.15]);
    if do_perturb==0
        print('-depsc','VAR_vs_Model_ntech');
        print('-dpdf','VAR_vs_Model_ntech');
        saveas(gcf, 'VAR_vs_Model_ntech', 'fig');
    else
        print('-depsc','VAR_vs_Model_ntech_perturb');
        print('-dpdf','VAR_vs_Model_ntech_perturb');
        saveas(gcf, 'VAR_vs_Model_ntech_perturb', 'fig');
    end
end


if show_mon==1,
    %%%%%%%%%%%%%%%%%%%%%%%%
    %Monetary Shock Plot  %%
    %%%%%%%%%%%%%%%%%%%%%%%%
    figure('Name','Nominal Interest Rate Shock: VAR vs. Model');
    legend_string={}; %empty cell for legend
    for plotindx=1:1:size(policyresponse,2)-1;
        subplot(3,4,plotindx)
        grpyat = [ [(0:pnstep-1)'  policyresponseLOW(:,reorderidx(plotindx))] ; [(pnstep-1:-1:0)'  policyresponseHIGH(pnstep:-1:1,reorderidx(plotindx))]];
        patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on
        plot(time, policyresponse(1:pnstep,reorderidx(plotindx)),'k','LineWidth',linewidth-1.5); hold on
        if options_.bayesian_irf==1,
            plot(time,model_resp_mon_HPDinf_baseline(reorderidx(plotindx),1:pnstep),'b--','LineWidth',linewidth-1); hold on
            plot(time,model_resp_mon_Mean_baseline(reorderidx(plotindx),1:pnstep),'b-','LineWidth',linewidth); hold on
            plot(time,model_resp_mon_HPDsup_baseline(reorderidx(plotindx),1:pnstep),'b--','LineWidth',linewidth-1); hold on
        else
            plot(time,model_resp_mon_baseline(reorderidx(plotindx),1:pnstep),'b-','LineWidth',linewidth); hold on
        end
        if do_perturb==0
            if options_.bayesian_irf==1,
                legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model 95%',' Model Mean'}; %legend string
            else
                legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model'}; %legend string
            end
        else
            if options_.bayesian_irf==1,
                legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model 95%',' Model Mean',['Model: ',parastring, ' changed from ',num2str(oldparaval),' to ',num2str(newparaval)]}; %legend string
            else
                legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model',['Model: ',parastring, ' changed from ',num2str(oldparaval),' to ',num2str(newparaval)]}; %legend string
            end
        end
        if do_perturb==1
            plot(time,model_resp_mon_perturb(reorderidx(plotindx),1:pnstep),'r--','LineWidth',linewidth); hold on
        end
        hold off
        title(data_varnames(reorderidx(plotindx)),'FontSize',fontsize);
        set(gca,'FontSize',fontsize);
        axis tight
        
        
        if plotindx==1  || plotindx==5 || plotindx==6 || plotindx==7
            axis([0 14 -0.25 0.46])
        elseif plotindx==3 || plotindx==2
            axis([0 14 -0.25 0.25])
        elseif plotindx==4
            axis([0 14 -0.8 0.25])
        elseif plotindx==9 || plotindx==10 || plotindx==11
            axis([0 14 -1 1.75])
        elseif plotindx==8
            axis([0 14 -0.1 0.2])
        else
            axis([0 14 -2 5])
        end
        
        
    end
    % Create super-title
    suptitle('Figure 1: Impulse Responses to an Expansionary Monetary Policy Shock');
    legend1=legend(legend_string, 'Orientation','horizontal');
    set(legend1,'Position',[0.319176519097222 0.912648419243481 0.384385850694444 0.0291524459613197],'box','off');
    text('String','Notes: x-axis in quarters.',...
        'Position',[-37.0514950166113 -4.01947521703618 17.3205080756888],...
        'FontSize',12);
    orient landscape;
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperUnits', 'inches');
    set(gcf, 'PaperPosition', [-.8 0 12.25 8.15]);
    if do_perturb==0
        print('-depsc','VAR_vs_Model_mon');
        print('-dpdf','VAR_vs_Model_mon');
        saveas(gcf, 'VAR_vs_Model_mon', 'fig');
    else
        print('-depsc','VAR_vs_Model_mon_perturb');
        print('-dpdf','VAR_vs_Model_mon_perturb');
        saveas(gcf, 'VAR_vs_Model_mon_perturb', 'fig');
    end
end;



if show_pinvest==1,
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Response of Relative Price of Investment to the 3 Shocks %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    hh=figure('Name','Relative Price of Investment: VAR vs. Model');
    
    legend_string={}; %empty cell for legend
    plotindx=9;
    
    
    %itech
    subplot(2,2,3)
    grpyat = [ [(0:pnstep-1)'  -uresponseLOW(:,plotindx)] ; [(pnstep-1:-1:0)'  -uresponseHIGH(pnstep:-1:1,plotindx)]];
    patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on
    plot(time, -uresponse(1:pnstep,plotindx),'k','LineWidth',linewidth-1.5); hold on
    plot(time,-model_resp_itech_baseline(plotindx,1:pnstep),'b-','LineWidth',linewidth); hold on
    if do_perturb==0
        legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model'}; %legend string
    else
        legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model',['Model: ',parastring, ' changed from ',num2str(oldparaval),' to ',num2str(newparaval)]}; %legend string
    end
    
    if do_perturb==1
        plot(time,-model_resp_itech_perturb(plotindx,1:pnstep),'r--','LineWidth',linewidth); hold on
    end
    hold off
    title('Response to Investment-Specific Tech. Shock','FontSize',fontsize);
    set(gca,'FontSize',fontsize);
    axis tight
    axis([0 14 0 0.9  ])
    
    text('String','Notes: x-axis in quarters, y-axis in percent',...
        'Position',[10 -1.1 1],...
        'FontSize',12);
    
    
    %ntech
    subplot(2,2,2)
    grpyat = [ [(0:pnstep-1)'  -zresponseLOW(:,plotindx)] ; [(pnstep-1:-1:0)'  -zresponseHIGH(pnstep:-1:1,plotindx)]];
    patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on
    plot(time, -zresponse(1:pnstep,plotindx),'k','LineWidth',linewidth-1.5); hold on
    plot(time,-model_resp_ntech_baseline(plotindx,1:pnstep),'b-','LineWidth',linewidth); hold on
    
    if do_perturb==1
        plot(time,-model_resp_ntech_perturb(plotindx,1:pnstep),'r--','LineWidth',linewidth); hold on
    end
    hold off
    title('Response to Neutral Tech. Shock','FontSize',fontsize);
    set(gca,'FontSize',fontsize);
    axis tight
    axis([0 14  -0.2 0.5 ])
    
    
    %mon
    subplot(2,2,1)
    grpyat = [ [(0:pnstep-1)'  -policyresponseLOW(:,plotindx)] ; [(pnstep-1:-1:0)'  -policyresponseHIGH(pnstep:-1:1,plotindx)]];
    patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on
    plot(time, -policyresponse(1:pnstep,plotindx),'k','LineWidth',linewidth-1.5); hold on
    plot(time,-model_resp_mon_baseline(plotindx,1:pnstep),'b-','LineWidth',linewidth); hold on
    if do_perturb==1
        plot(time,-model_resp_mon_perturb(plotindx,1:pnstep),'r--','LineWidth',linewidth); hold on
    end
    hold off
    title('Response to Monetary Policy Shock','FontSize',fontsize);
    set(gca,'FontSize',fontsize);
    axis tight
    axis([0 14 -0.3 0.1 ])
    %set(gcf, 'PaperPosition', [-.7 0 12.25 8.25]);
    text('String','Notes: x-axis in quarters, y-axis in percent',...
        'Position',[1 -.95],...
        'FontSize',12);
    
    
    
    % Create super-title
    suptitle('Figure 4: Impulse Responses of the Relative Price of Investment');
    legend1=legend(legend_string, 'Orientation','horizontal');
    set(legend1,'Position',[0.319176519097222 0.912648419243481 0.384385850694444 0.0291524459613197],'box','off');
    
    orient landscape;
    %set(gcf, 'PaperPositionMode', 'manual');
    %set(gcf, 'PaperUnits', 'inches');
    %set(gcf, 'PaperPosition', [-.7 0 12.25 8.15]);
    if do_perturb==0
        print('-depsc','VAR_vs_Model_PinvestResp');
        print('-dpdf','VAR_vs_Model_PinvestResp');
        saveas(gcf, 'VAR_vs_Model_PinvestResp', 'fig');
    else
        print('-depsc','VAR_vs_Model_PinvestResp_perturb');
        print('-dpdf','VAR_vs_Model_PinvestResp_perturb');
        saveas(gcf, 'VAR_vs_Model_PinvestResp_perturb', 'fig');
    end
end


 



