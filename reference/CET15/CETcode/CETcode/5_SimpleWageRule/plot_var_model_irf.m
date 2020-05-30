%plot VAR vs. model impulse responses

conflevel=0.95;
factor=-norminv((1-conflevel)/2);
pnstep=horizon;
linewidth=2.5;
fontsize=12;
time=[0:1:pnstep-1];

global select_idx
select_idx=1:12;

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


reorderidx=[1 2 3 10 5 6 7 8 12 11 4 9];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Investment Tech Shock Plot  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','Investment Techn. Shock: VAR vs. Model');
legend_string={}; %empty cell for legend


for plotindx=1:1:size(policyresponse,2);
    subplot(3,4,plotindx)
    grpyat = [ [(0:pnstep-1)'  uresponseLOW(:,reorderidx(plotindx))] ; [(pnstep-1:-1:0)'  uresponseHIGH(pnstep:-1:1,reorderidx(plotindx))]];
    patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on
    plot(time, uresponse(1:pnstep,reorderidx(plotindx)),'k','LineWidth',linewidth-1.5); hold on
    plot(time,model_resp_itech_baseline(reorderidx(plotindx),1:pnstep),'b-','LineWidth',linewidth); hold on
    if plotindx==1,
            legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model'}; %legend string
    end
    hold off
    title(data_varnames(reorderidx(plotindx)),'FontSize',fontsize);
    set(gca,'FontSize',fontsize);
    axis tight
end
suptitle('Medium-Sized Model: Impulse Responses to an Investment Specific Technology Shock');
legend1=legend(legend_string, 'Orientation','horizontal');
set(legend1,'Position',[0.319176519097222 0.912648419243481 0.384385850694444 0.0291524459613197],'box','off');
text('String','Notes: x-axis in quarters, y-axis in percent',...
    'Position',[-37.2142857142857 -1.78096574196249 17.3205080756888],...
    'FontSize',12);
orient landscape;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neutral Tech Shock Plot  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','Neutral Techn. Shock: VAR vs. Model');
legend_string={}; %empty cell for legend
for plotindx=1:1:size(policyresponse,2);
    subplot(3,4,plotindx)
    grpyat = [ [(0:pnstep-1)'  zresponseLOW(:,reorderidx(plotindx))] ; [(pnstep-1:-1:0)'  zresponseHIGH(pnstep:-1:1,reorderidx(plotindx))]];
    patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on
    plot(time, zresponse(1:pnstep,reorderidx(plotindx)),'k','LineWidth',linewidth-1.5); hold on
    plot(time,model_resp_ntech_baseline(reorderidx(plotindx),1:pnstep),'b-','LineWidth',linewidth); hold on
    legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model'}; %legend string
    hold off
    title(data_varnames(reorderidx(plotindx)),'FontSize',fontsize);
    set(gca,'FontSize',fontsize);
    axis tight
end
suptitle('Medium-Sized Model: Impulse Responses to a Neutral Technology Shock');
legend1=legend(legend_string, 'Orientation','horizontal');
set(legend1,'Position',[0.319176519097222 0.912648419243481 0.384385850694444 0.0291524459613197],'box','off');
text('String','Notes: x-axis in quarters, y-axis in percent',...
    'Position',[-37.2142857142857 -2.16352841949488 17.3205080756888],...
    'FontSize',12);
orient landscape;


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
    plot(time,model_resp_mon_baseline(reorderidx(plotindx),1:pnstep),'b-','LineWidth',linewidth); hold on
    legend_string={['VAR ',num2str(conflevel*100),'%'],'VAR Mean',' Model'}; %legend string
    hold off
    title(data_varnames(reorderidx(plotindx)),'FontSize',fontsize);
    set(gca,'FontSize',fontsize);
    axis tight
end
suptitle('Medium-Sized Model: Impulse Responses to a Monetary Policy Shock');
legend1=legend(legend_string, 'Orientation','horizontal');
set(legend1,'Position',[0.319176519097222 0.912648419243481 0.384385850694444 0.0291524459613197],'box','off');
text('String','Notes: x-axis in quarters, y-axis in percent',...
    'Position',[-37.0514950166113 -1.01947521703618 17.3205080756888],...
    'FontSize',12);
orient landscape;
 
