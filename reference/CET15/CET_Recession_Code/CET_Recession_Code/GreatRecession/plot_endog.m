choice_idx=[1 2 3 4 5 6 8 7 9 11 10 ]; %13 TFP
plt=0;
figure('name','ZLB Simulations (Baseline)')
for kk=choice_idx, subplot(ia,ib,plt+1), 
    plt=plt+1;
    
    nanidx=max(cumsum(isfinite(min_range_mat(kk,:))));
    grpyat = [ [time(1:nanidx)' min_range_mat(kk,1:nanidx)'] ; [time(nanidx:-1:1)'  max_range_mat(kk,nanidx:-1:1)']];
    patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]); hold on
    
    plot(time, mean_range_mat(kk,:),'k-','LineWidth',1.25,'MarkerSize',4); hold on  %mean of min-max range
                   
    if kk~=13,
        plot(time,resp_mat_ZLB(kk,1:show_horz),'b-' ,'LineWidth',2.5,'MarkerSize',4); hold on
    else
        analyze_tfp;
        plot(time, tfphand(1:show_horz),'b-' ,'LineWidth',2.5,'MarkerSize',4); hold on 
    end
    if plt==1,
        plot(time,0*time+0.01,'k:' ,'LineWidth',2,'MarkerSize',4); hold on
    else
        plot(time,0*time,'k:' ,'LineWidth',2,'MarkerSize',4); hold on
    end        

    axis tight;

    if kk~=13,
        title(varnamez_2(kk),'Fontsize',ftsize-1);
    else
        title('TFP (%)','Fontsize',ftsize-1);
    end
    

    set(gca,'XTick',[2009, 2011, 2013, 2015]);
    set(gca,'FontSize',ftsize-1);            
end

suptitle('Figure 8: The U.S. Great Recession: Data vs. Model');
legend_string={'Data (Min-Max Range)','Data (Mean)','Model'};
legend1=legend(legend_string, 'Orientation','horizontal');
set(legend1,'FontSize',ftsize-1,'Position',[0.338837157162458 0.91926774429668 0.329337539432177 0.024353430451683],'box','off');

orient landscape;
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [-.85 -.25 12.25 8.35]);
print -dpdf SimulationZLB_baseline; print -depsc SimulationZLB_baseline; saveas(gcf, 'SimulationZLB_baseline','fig');