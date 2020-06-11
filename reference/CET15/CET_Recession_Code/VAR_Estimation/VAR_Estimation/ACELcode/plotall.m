%fist, determine if there are two distinct sets of impulse response functions to plot

aa=[modirf1,modirf2,modirf3];
bb=[modirf1_f,modirf2_f,modirf3_f];

shows=0;%if unity, replace capacity utilization by response of real marginal cost 
pllt=1;
if max(max(abs(aa-bb))) > .1e-10;pllt=2;end

pnstep=20;
varnamz = char('Output','MZM Growth (Q)','Inflation','Federal Funds Rate','Capacity Utilization','Average Hours','Real Wage', ...
    'Consumption','Investment','Velocity',...
    'Investment Good Price', 'Total money growth (M)');


figure, orient landscape
for zx=1:11
    subplot(4,3,zx)
    if zx ~= 5 | (zx == 5 & shows == 0)
        si = squeeze(simimp(1:pnstep,zx,3,:));
        stdirf3(:,zx)    =   std(si,1,2);
        plot(0:pnstep-1,100*impzout(1:pnstep,zx,3),'k-')
        hold on
        grpyat = [(0:pnstep-1)' 100*(impzout(1:pnstep,zx,3)-1.96*std(si,1,2)) ; (pnstep-1:-1:0)' 100*(impzout(pnstep:-1:1,zx,3)+1.96*std(si(pnstep:-1:1,:),1,2))];
        patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]);     
        plot(0:pnstep-1,100*impzout(1:pnstep,zx,3),'k-')
        plot(0:pnstep-1,modirf3((zx-1)*pnstep+1:zx*pnstep),'k.-')
        plot(0:pnstep-1,modirf3_f((zx-1)*pnstep+1:zx*pnstep),'ko-')
        title(varnamz(zx,:));
    elseif zx == 5 & shows == 1
        hold on
        plot(0:pnstep-1,100*(impzout(1:pnstep,7,3)-impzout(1:pnstep,1,3)+impzout(1:pnstep,6,3)),'k-')
        zzz=modirf3((7-1)*pnstep+1:7*pnstep)-modirf3((1-1)*pnstep+1:1*pnstep)+modirf3((6-1)*pnstep+1:6*pnstep)
        plot(0:pnstep-1,zzz,'k.-')
        zzz_=modirf3_f((7-1)*pnstep+1:7*pnstep)-modirf3_f((1-1)*pnstep+1:1*pnstep)+modirf3_f((6-1)*pnstep+1:6*pnstep)
        plot(0:pnstep-1,zzz_,'ko-')
        title('log, real marginal cost')
    end
    if zx >= 10
        xlabel('Quarters')
    end
    axis tight
    hold off
end
subplot(4,3,12),plot(0:pnstep-1,modirf3(end-19:end),'k.-'),title(varnamz(12,:)),xlabel('Quarters')
hold on,plot(0:pnstep-1,modirf3_f(end-19:end),'ko-')
if pllt == 1
    suptitle('Figure 1: Response to a monetary policy shock (o - Model, - VAR, grey area - 95 % Confidence Interval)');
elseif pllt == 2
    suptitle('Benchmark model (.) and alternative model (o) - dynamic response to a monetary policy shock'),
end
figure, orient landscape
for zx=1:11
    subplot(4,3,zx)
    if zx ~= 5 | (zx == 5 & shows == 0)
        si = squeeze(simimp(1:pnstep,zx,2,:));
        stdirf2(:,zx)    =   std(si,1,2);
        plot(0:pnstep-1,100*impzout(1:pnstep,zx,2),'k-')
        hold on
        grpyat = [(0:pnstep-1)' 100*(impzout(1:pnstep,zx,2)-1.96*std(si,1,2)) ; (pnstep-1:-1:0)' 100*(impzout(pnstep:-1:1,zx,2)+1.96*std(si(pnstep:-1:1,:),1,2))];
        patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]);     
        plot(0:pnstep-1,100*impzout(1:pnstep,zx,2),'k-')
        plot(0:pnstep-1,modirf2((zx-1)*pnstep+1:zx*pnstep),'k.-')
        plot(0:pnstep-1,modirf2_f((zx-1)*pnstep+1:zx*pnstep),'ko-')
        title(varnamz(zx,:));    
    elseif zx == 5 & shows == 1
        hold on
        plot(0:pnstep-1,100*(impzout(1:pnstep,7,2)-impzout(1:pnstep,1,2)+impzout(1:pnstep,6,2)),'k-')
        zzz=modirf2((7-1)*pnstep+1:7*pnstep)-modirf2((1-1)*pnstep+1:1*pnstep)+modirf2((6-1)*pnstep+1:6*pnstep)
        plot(0:pnstep-1,zzz,'k.-')
        zzz_=modirf2_f((7-1)*pnstep+1:7*pnstep)-modirf2_f((1-1)*pnstep+1:1*pnstep)+modirf2_f((6-1)*pnstep+1:6*pnstep)
        plot(0:pnstep-1,zzz_,'ko-')
        title('log, real marginal cost')
    end
    if zx >= 10
        xlabel('Quarters')
    end
    axis tight
    hold off
end
subplot(4,3,12),plot(0:pnstep-1,modirf2(end-19:end),'k.-'),title(varnamz(12,:)),xlabel('Quarters')
hold on,plot(0:pnstep-1,modirf2_f(end-19:end),'ko-')
if pllt == 1
    suptitle('Figure 2: Response to a neutral technology shock (o - Model, - VAR, grey area - 95 % Confidence Interval)');
elseif pllt == 2
    suptitle('Benchmark model (.) and alternative model (o) - dynamic response to a neutral technology shock'),
end

figure, orient landscape
for zx=1:11
    subplot(4,3,zx)
    if zx ~= 5 | (zx == 5 & shows == 0)
        si = squeeze(simimp(1:pnstep,zx,1,:));
        stdirf1(:,zx)    =   std(si,1,2);
        plot(0:pnstep-1,100*impzout(1:pnstep,zx,1),'k-')
        hold on
        grpyat = [(0:pnstep-1)' 100*(impzout(1:pnstep,zx,1)-1.96*std(si,1,2)) ; (pnstep-1:-1:0)' 100*(impzout(pnstep:-1:1,zx,1)+1.96*std(si(pnstep:-1:1,:),1,2))];
        patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]);     
        plot(0:pnstep-1,100*impzout(1:pnstep,zx,1),'k-')
        plot(0:pnstep-1,modirf1((zx-1)*pnstep+1:zx*pnstep),'k.-')
        plot(0:pnstep-1,modirf1_f((zx-1)*pnstep+1:zx*pnstep),'ko-')
        title(varnamz(zx,:));        
    elseif zx == 5 & shows == 1
        hold on
        plot(0:pnstep-1,100*(impzout(1:pnstep,7,1)-impzout(1:pnstep,1,1)+impzout(1:pnstep,6,1)),'k-')
        zzz=modirf1((7-1)*pnstep+1:7*pnstep)-modirf1((1-1)*pnstep+1:1*pnstep)+modirf1((6-1)*pnstep+1:6*pnstep)
        plot(0:pnstep-1,zzz,'k.-')
        zzz_=modirf1_f((7-1)*pnstep+1:7*pnstep)-modirf1_f((1-1)*pnstep+1:1*pnstep)+modirf1_f((6-1)*pnstep+1:6*pnstep)
        plot(0:pnstep-1,zzz_,'ko-')
        title('log, real marginal cost')
    end
    if zx >= 10
        xlabel('Quarters')
    end
    axis tight
    hold off
end
subplot(4,3,12),plot(0:pnstep-1,modirf1(end-19:end),'k.-'),title(varnamz(12,:)),xlabel('Quarters')
hold on,plot(0:pnstep-1,modirf1_f(end-19:end),'ko-')

if pllt == 1
    suptitle('Figure 3: Response to an embodied technology shock (o - Model, - VAR, grey area - 95 % Confidence Interval)');
elseif pllt == 2
    suptitle('Benchmark model (.) and alternative model (o) - dynamic response to an embodied technology shock'),
end