%fist, determine if there are two distinct sets of impulse response functions to plot

aa=[modirf1,modirf2,modirf3];
bb=[modirf1_f,modirf2_f,modirf3_f];

pllt=1;
if max(max(abs(aa-bb))) > .1e-10;pllt=2;end

pnstep=20;
varnamz = char('Output','MZM Growth','Inflation','Fed Funds','Capacity Util','Avg Hours','Real Wage', ...
    'Consumption','Investment','Velocity',...
    'p_{I}', 'Total money growth');

%for this software, you can plot exactly four variables per shock....all results go to a single figure
%indicate which four variables you want to plot according to their location in varnamz

grphthis=[1 3 5 9];
grphthis=[1 6 8 9];

if length(grphthis) ~= 4 & length(grphthis) ~= 3
    error('fatal (plotsome) wrong number of variables to plot')
end


figure, orient landscape
ix=0;
ixx=[1 4 7 10];
for zx=grphthis
    ix=ix+1;
    subplot(4,3,ixx(ix))
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
    axis tight
    hold off
end

ix=0;
ixx=[2 5 8 11];
for zx=grphthis
    ix=ix+1;
    subplot(4,3,ixx(ix))
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
    axis tight
    hold off
end

ix=0;
ixx=[3 6 9 12];
for zx=grphthis
    ix=ix+1;
    subplot(4,3,ixx(ix))
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
    axis tight
    hold off
end

if pllt == 1
    suptitle('MONETARY POLICY SHOCK   NEUTRAL TECHNOLOGY SHOCK    EMBODIED TECHNOLOGY SHOCK ');
elseif pllt == 2
    suptitle('MONETARY POLICY SHOCK   NEUTRAL TECHNOLOGY SHOCK    EMBODIED TECHNOLOGY SHOCK (Benchmark (.) alternative (o))');
end