function plt_identplots2


clear all
clc

load sensitivity_results_backup;

siJ=prctile(Sensitivity_wrt_para,[25 50 75],3);

siJmean1=siJ(:,[1,3:9],:);
siJmean2=siJ(:,[10,12:end],:);


nparam=size(para_names,1);
disp(' ');
disp('Tax Rate on Labor Income:')
disp('----------------------------------------------- ');
for ii=1:size(siJmean1,2);
disp(sprintf('%s \t %1.4f \t %1.4f \t %1.4f', para_names(ii,:), siJmean1(1,ii,2)', siJmean1(1,ii,1)', siJmean1(1,ii,3)'))
end
disp('---------------------------------------------')
disp(' ');

disp('Tax Rate on Capital Income:')
disp('--------------------------------------------- ');
for ii=1:size(siJmean2,2);
disp(sprintf('%s \t %1.4f \t %1.4f \t %1.4f', para_names(ii+size(siJmean1,2),:), siJmean2(2,ii,2)', siJmean2(2,ii,1)', siJmean2(2,ii,3)'))
end
disp('---------------------------------------------')

%% calculate biggest entry per tax instrument and variable per draw

t1_labor=Sensitivity_wrt_para(:,[1,3:9],:);
t1_capital=Sensitivity_wrt_para(:,[10,12:end],:);

[a,b,c]=size(t1_labor);
t2_labor=zeros(a,b,c);
t2_capital=zeros(a,b,c);

t2s_labor=zeros(a,b,c);
t2s_capital=zeros(a,b,c);


for i=1:c
    for j=1:a
   th1_labor=max(t1_labor(j,:,i));
   t2_labor(j,:,i)=t1_labor(j,:,i)./th1_labor;
   th1_capital=max(t1_capital(j,:,i));
   t2_capital(j,:,i)=t1_capital(j,:,i)./th1_capital;
 
    [h1,  IDX]=sort(t2_labor(j,:,i));
    [h1,  IDX2]=sort(t2_capital(j,:,i));
    
    for nn=1:max(IDX)
       
      t2s_labor(j,nn,i)=find(IDX==nn);
      
      t2s_capital(j,nn,i)=find(IDX2==nn);
    end
   
   
    end
      
end




%nn=0;
for i=[1]
%nn=nn+1;
%subplot(2,1,nn)
figure('Name','Sensitivity Labor tax rate','Position',[50 50 600 200]);
tt=permute(t2_labor(i,:,:),[2 3 1]);
myboxplot(tt')
set(gca,'ylim',[0 1.05])
set(gca,'xticklabel','')
for ip=1:nparam/2,
    text(ip,-0.1,deblank(para_names(ip,:)),'HorizontalAlignment','center','interpreter','none')
end
end
set(gcf,'PaperPositionMode','auto')
print -depsc2 sensitivity_labor_fm.eps;



for i=[2]

figure('Name','Sensitivity capital tax rate','Position',[50 50 600 200]);

tt=permute(t2_capital(i,:,:),[2 3 1]);
myboxplot(tt')
set(gca,'ylim',[0 1.05])
set(gca,'xticklabel','')
for ip=nparam/2+1:nparam,
    text(ip-nparam/2,-0.1,deblank(para_names(ip,:)),'HorizontalAlignment','center','interpreter','none')
end
end
set(gcf,'PaperPositionMode','auto')
print -depsc2 sensitivity_capital_fm.eps;
% 
