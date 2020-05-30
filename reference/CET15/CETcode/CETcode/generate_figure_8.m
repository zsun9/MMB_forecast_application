%plot results of unemployment benefit experiment

cd 7_AOB_UnempBenefitsSimulation
load simulation_results

%some plotting options
ia=2; ib=3; ftsize=11; show_horz=18;
linwdt=3;

pltlb=3.5;pltub=7;
time=0:0.25:show_horz/4-0.25;

figure;
subplot(ia,ib,1)
plot(time,NaN*unemp.case1b(2:show_horz+1),'r-.','Linewidth',linwdt); hold on
plot(time,unemp.case1a(2:show_horz+1),'Linewidth',linwdt); hold on
plot(time,unemp.case1b(2:show_horz+1),'r-.','Linewidth',linwdt); hold on
plot(time,unemp.case1a(1)*ones(1,show_horz),'k--'); hold on
title('Unemployment Rate (%)','FontSize',ftsize);
ylabel('Estimated Price Stickiness (\xi=0.75)','FontSize',ftsize+2,'FontWeight','bold','Interpreter','Tex');
axis([0 4 pltlb pltub ]);
set(gca,'FontSize',ftsize);
leg=legend('Benefits AR(1)=0.90','Benefits AR(1)=0.75',4);
set(leg,...
    'Position',[0.196688988095238 0.627294621479738 0.0744791666666667 0.0351681957186544]);
legend boxoff;

subplot(ia,ib,4)
plot(time,unemp.case2a(2:show_horz+1),'Linewidth',linwdt);hold on
plot(time,unemp.case2b(2:show_horz+1),'r-.','Linewidth',linwdt); hold on
plot(time,unemp.case1a(1)*ones(1,show_horz),'k--'); hold on
title('Unemployment Rate (%)','FontSize',ftsize);
ylabel('More Flexible Prices (\xi=0.5)','FontSize',ftsize+2,'FontWeight','bold','Interpreter','Tex');
xlabel('Years','FontSize',ftsize);
axis([0 4  pltlb pltub ]);
set(gca,'FontSize',ftsize);

subplot(ia,ib,2)
plot(time,unemp.case3a(2:show_horz+1),'Linewidth',linwdt); hold on
plot(time,unemp.case3b(2:show_horz+1),'r-.','Linewidth',linwdt); hold on
plot(time,unemp.case1a(1)*ones(1,show_horz),'k--'); hold on
title('Unemployment Rate (%)','FontSize',ftsize);
axis([0 4  pltlb pltub ]);
set(gca,'FontSize',ftsize);

subplot(ia,ib,5)
plot(time,unemp.case4a(2:show_horz+1),'Linewidth',linwdt);hold on
plot(time,unemp.case4b(2:show_horz+1),'r-.','Linewidth',linwdt); hold on
plot(time,unemp.case1a(1)*ones(1,show_horz),'k--'); hold on
title('Unemployment Rate (%)','FontSize',ftsize);
xlabel('Years','FontSize',ftsize);
axis([0 4  pltlb pltub  ]);
set(gca,'FontSize',ftsize);

subplot(ia,ib,3)
plot(time,unemp.case5a(2:show_horz+1),'Linewidth',linwdt); hold on
plot(time,unemp.case5b(2:show_horz+1),'r-.','Linewidth',linwdt); hold on
plot(time,unemp.case1a(1)*ones(1,show_horz),'k--'); hold on
title('Unemployment Rate (%)','FontSize',ftsize);
axis([0 4  pltlb pltub  ]);
set(gca,'FontSize',ftsize);

subplot(ia,ib,6)
plot(time,unemp.case6a(2:show_horz+1),'Linewidth',linwdt);hold on
plot(time,unemp.case6b(2:show_horz+1),'r-.','Linewidth',linwdt); hold on
plot(time,unemp.case1a(1)*ones(1,show_horz),'k--'); hold on
title('Unemployment Rate (%)','FontSize',ftsize);
xlabel('Years','FontSize',ftsize);
axis([0 4  pltlb pltub  ]);
set(gca,'FontSize',ftsize);

suptitle('Figure 8: Dynamic Effects of a Rise in Unemployment Benefits');

text(-9.5,13.4-.75,'Normal Times','FontSize',ftsize+2,'FontWeight','bold');
text(-4.1,13.4-.75,'1 Year ZLB','FontSize',ftsize+2,'FontWeight','bold');
text(1,13.4-.75,'2 Years ZLB','FontSize',ftsize+2,'FontWeight','bold');

text(-11,2.25+.5,'Notes: 1pp rise in unemployment benefits relative to steady state wage. Normal Times: Taylor rule. 1 or 2 Years ZLB: 1 or 2 years constant nominal interest rate.');

orient landscape;
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [-1 -0.1 13 8.4]);