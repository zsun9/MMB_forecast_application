choice_idx=[12 15 13 14]; 
iae=2;ibe=2;

plt=0;
figure('name','ZLB Simulations (Baseline)')
for kk=choice_idx, 

subplot(iae,ibe,plt+1), 
    plt=plt+1; 
    
    if kk~=13,
        nanidx=max(cumsum(isfinite(min_range_mat(kk,:))));
        grpyat = [ [time(1:nanidx)' min_range_mat(kk,1:nanidx)'] ; [time(nanidx:-1:1)'  max_range_mat(kk,nanidx:-1:1)']];
        patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on

        plot(time, mean_range_mat(kk,:),'k-','LineWidth',1.25,'MarkerSize',5); hold on  %mean of min-max range

        plot(time,resp_mat_ZLB(choice_idx(plt),1:show_horz),'b-o' ,'LineWidth',2.5,'MarkerSize',5); hold on
        
        plot(time, mean_range_mat(kk,:),'k-','LineWidth',1.25,'MarkerSize',5); hold on  %mean of min-max range
        
    else
        nanidx=max(cumsum(isfinite(min_range_mat(kk,:))));
        grpyat = NaN*[ [time(1:nanidx)' min_range_mat(kk,1:nanidx)'] ; [time(nanidx:-1:1)'  max_range_mat(kk,nanidx:-1:1)']];
        patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on

        plot(time, NaN*mean_range_mat(kk,:),'k-','LineWidth',1.25,'MarkerSize',5); hold on  %mean range

        plot(time,cumsum(resp_mat_ZLB(choice_idx(plt),1:show_horz)),'b-o' ,'LineWidth',2.5,'MarkerSize',5); hold on
        
        plot(time, NaN*mean_range_mat(kk,:),'k-','LineWidth',1.25,'MarkerSize',5); hold on  %mean range
    end
        
    if plt==1,
        plot(time,0*time+0.01,'k:' ,'LineWidth',2.5,'MarkerSize',4); hold on
    else
        plot(time,0*time,'k:' ,'LineWidth',2.5,'MarkerSize',4); hold on
    end

    axis tight;
        
    title(varnamez_2(choice_idx(plt)),'Fontsize',ftsize-1);

    set(gca,'XTick',[2009, 2011, 2013, 2015]);
    set(gca,'FontSize',ftsize-1);           
end

suptitle('Figure 7: The U.S. Great Recession: Exogenous Variables');

legend_string={'Data (Min-Max Range)','Data (Mean)','Model'};
legend1=legend(legend_string, 'Orientation','horizontal');
set(legend1,'FontSize',ftsize-1,'Position',[0.34119826827357 0.916770865395307 0.329337539432177 0.024353430451683],'box','off');


orient landscape;
%set(gcf, 'PaperPositionMode', 'manual');
%set(gcf, 'PaperUnits', 'inches');
%set(gcf, 'PaperPosition', [-.85 -.25 12.25 8.35]);
print -dpdf SimulationZLB_baselineExog; print -depsc SimulationZLB_baselineExog; saveas(gcf, 'SimulationZLB_baselineExog','fig');   