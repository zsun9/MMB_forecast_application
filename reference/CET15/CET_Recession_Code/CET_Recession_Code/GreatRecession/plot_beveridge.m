%Beveridge Curve
time_str={'2008Q3',	'2008Q4',	'2009Q1',	'2009Q2',	'2009Q3',	'2009Q4',	'2010Q1',	'2010Q2',	'2010Q3',	'2010Q4',	'2011Q1',	'2011Q2',	'2011Q3',	'2011Q4',	'2012Q1',	'2012Q2',	'2012Q3',	'2012Q4',	'2013Q1',	'2013Q2'};
figure('name','Beveridge Curve');
plot(dat2001_mat(4,1:20),dat2001_mat(11,1:20),'rs-','LineWidth',2,'MarkerSize',5); hold on
plot(resp_mat_ZLB(4,1:20),resp_mat_ZLB(11,1:20),'bo-','LineWidth',2.5,'MarkerSize',5);
set(gca,'FontSize',12);
for ss=[1 3],
    text(dat2001_mat(4,ss)+.1,dat2001_mat(11,ss),time_str(ss))
end
for ss=[6 9 14 20],
    text(dat2001_mat(4,ss)-.5,dat2001_mat(11,ss),time_str(ss))
end
axis([.5 5.5 -60 -10])
xlabel('Unemployment Rate (p.p. dev. from 2008Q2 data or model steady state)','FontSize',12);
ylabel('Vacancies (% dev. from data trend or model steady state)','FontSize',12);
title('Figure 9: Beveridge Curve: Data vs. Model','FontSize',16);
legend('Data','Model');
legend boxoff;
set(gca,'FontSize',12);
print -dpdf Model_vs_data_beveridge_curve; print -depsc Model_vs_data_beveridge_curve; saveas(gcf, 'Model_vs_data_beveridge_curve','fig');

