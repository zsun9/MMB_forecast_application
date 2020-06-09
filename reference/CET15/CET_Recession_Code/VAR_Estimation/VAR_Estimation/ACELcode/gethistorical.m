function gethistorical(simdataout)
yr=1854:1:2002;
for i=1:length(yr),year(1+4*(i-1):4*i,1)=yr(i)*ones(4,1);month(1,1+4*(i-1):4*i)=1:3:10;end
month=month';
dates=datenum(year,month,ones(size(month)));
through =   zeros(size(date));
through(4)      =   1;
through(20)     =   1;
through(31)     =   1;
through(53)     =   1;
through(68)     =   1;
through(101)    =   1;
through(126)    =   1;
through(137)    =   1;
through(150)    =   1;
through(162)    =   1;
through(174)    =   1;
through(188)    =   1;
through(203)    =   1;
through(218)    =   1;
through(236)    =   1;
through(244)    =   1;
through(261)    =   1;
through(271)    =   1;
through(283)    =   1;
through(296)    =   1;
through(317)    =   1;
through(338)    =   1;
through(368)    =   1;
through(384)    =   1;
through(402)    =   1;
through(418)    =   1;
through(429)    =   1;
through(468)    =   1;
through(485)    =   1;
through(507)    =   1;
through(516)    =   1;
through(549)    =   1;


peak            =   zeros(size(date));
peak(14)        =   1;
peak(27)        =   1;
peak(45)        =   1;
peak(62)        =   1;
peak(79)        =   1;
peak(113)       =   1;
peak(134)       =   1;
peak(147)       =   1;
peak(157)       =   1;
peak(168)       =   1;
peak(183)       =   1;
peak(196)       =   1;
peak(214)       =   1;
peak(225)       =   1;
peak(237)       =   1;
peak(259)       =   1;
peak(265)       =   1;
peak(278)       =   1;
peak(291)       =   1;
peak(303)       =   1;
peak(334)       =   1;
peak(365)       =   1;
peak(380)       =   1;
peak(398)       =   1;
peak(415)       =   1;
peak(426)       =   1;
peak(464)       =   1;
peak(480)       =   1;
peak(505)       =   1;
peak(511)       =   1;
peak(547)       =   1;
peak(589)       =   1;

initvar =   592-size(simdataout,1)+1;
endvar  =   592;
[i,j,s]=find(through);
j  =  [j, length(dates)];
[ii,jj,ss]=find(peak);
varnamz = char('Output','MZM Growth','Inflation','Fed Funds','Capacity Util','Avg Hours','Real Wage','Consumption','Investment','Velocity','Price of Inv.');

figure, orient landscape
for zx=1:11
    subplot(4,3,zx)
    var1    =   100*simdataout(:,zx,5);
    var2    =   100*simdataout(:,zx,1);  
    if zx==4
        var1    =   simdataout(:,zx,5);
        var2    =   simdataout(:,zx,1);  
    end
    maxvar  =   1.05*max(max(var1),max(var2));
    minvar1=min(var1)-.05*abs(min(var1));
    minvar2=min(var2)-.05*abs(min(var2));
    minvar  =   min(minvar1,minvar2);
    hold on;
    for ll=1:length(jj)
        area([dates(jj(ll)) dates(j(ll+1))],[1.01 1.01]*maxvar,minvar,'FaceColor',[ 0.75 0.75 0.75 ])
    end
    axis([dates(initvar) dates(endvar) minvar maxvar])
    plot(dates(initvar:endvar),var1,'k','LineWidth',1.5)
    plot(dates(initvar:endvar),var2,'k')
    hold off
    set(gca,'XtickLabel',datestr(dates(initvar:40:endvar),17))
    set(gca,'Xtick',dates(initvar:40:endvar))
    set(gca,'FontSize',9)
    set(gca,'FontName','Times New Roman')
    title(varnamz(zx,:));
end
suptitle('Figure 8: Historical decomposition - embodied technology shocks only')
print -dps2 figure8

figure, orient landscape
for zx=1:11
    subplot(4,3,zx)
    var1    =   100*simdataout(:,zx,5);
    var2    =   100*simdataout(:,zx,2);  
    if zx==4
        var1    =   simdataout(:,zx,5);
        var2    =   simdataout(:,zx,2);  
    end
    maxvar  =   1.05*max(max(var1),max(var2));
    minvar1=min(var1)-.05*abs(min(var1));
    minvar2=min(var2)-.05*abs(min(var2));
    minvar  =   min(minvar1,minvar2);
    hold on;
    for ll=1:length(jj)
        area([dates(jj(ll)) dates(j(ll+1))],[1.01 1.01]*maxvar,minvar,'FaceColor',[ 0.75 0.75 0.75 ])
    end
    axis([dates(initvar) dates(endvar) minvar maxvar])
    plot(dates(initvar:endvar),var1,'k','LineWidth',1.5)
    plot(dates(initvar:endvar),var2,'k')
    hold off
    set(gca,'XtickLabel',datestr(dates(initvar:40:endvar),17))
    set(gca,'Xtick',dates(initvar:40:endvar))
    set(gca,'FontSize',9)
    set(gca,'FontName','Times New Roman')
    title(varnamz(zx,:));
end
suptitle('Figure 7: Historical decomposition - neutral technology shocks only')
print -dps2 figure7

figure, orient landscape
for zx=1:11
    subplot(4,3,zx)
    var1    =   100*simdataout(:,zx,5);
    var2    =   100*simdataout(:,zx,3);  
    if zx==4
        var1    =   simdataout(:,zx,5);
        var2    =   simdataout(:,zx,3);  
    end
    maxvar  =   1.05*max(max(var1),max(var2));
    minvar1=min(var1)-.05*abs(min(var1));
    minvar2=min(var2)-.05*abs(min(var2));
    minvar  =   min(minvar1,minvar2);
    hold on;
    for ll=1:length(jj)
        area([dates(jj(ll)) dates(j(ll+1))],[1.01 1.01]*maxvar,minvar,'FaceColor',[ 0.75 0.75 0.75 ])
    end
    axis([dates(initvar) dates(endvar) minvar maxvar])
    plot(dates(initvar:endvar),var1,'k','LineWidth',1.5)
    plot(dates(initvar:endvar),var2,'k')
    hold off
    set(gca,'XtickLabel',datestr(dates(initvar:40:endvar),17))
    set(gca,'Xtick',dates(initvar:40:endvar))
    set(gca,'FontSize',9)
    set(gca,'FontName','Times New Roman')
    title(varnamz(zx,:));
end
suptitle('Figure 6: Historical decomposition - monetary policy shocks only')
print -dps2 figure6

figure, orient landscape
for zx=1:11
    subplot(4,3,zx)
    var1    =   100*simdataout(:,zx,5);
    var2    =   100*simdataout(:,zx,4);  
    if zx==4
        var1    =   simdataout(:,zx,5);
        var2    =   simdataout(:,zx,4);  
    end
    maxvar  =   1.05*max(max(var1),max(var2));
    minvar1=min(var1)-.05*abs(min(var1));
    minvar2=min(var2)-.05*abs(min(var2));
    minvar  =   min(minvar1,minvar2);
    hold on;
    for ll=1:length(jj)
        area([dates(jj(ll)) dates(j(ll+1))],[1.01 1.01]*maxvar,minvar,'FaceColor',[ 0.75 0.75 0.75 ])
    end
    axis([dates(initvar) dates(endvar) minvar maxvar])
    plot(dates(initvar:endvar),var1,'k','LineWidth',1.5)
    plot(dates(initvar:endvar),var2,'k')
    hold off
    set(gca,'XtickLabel',datestr(dates(initvar:40:endvar),17))
    set(gca,'Xtick',dates(initvar:40:endvar))
    set(gca,'FontSize',9)
    set(gca,'FontName','Times New Roman')
    title(varnamz(zx,:));
end
suptitle('Figure 9: Historical decomposition - monetary policy and technology shocks')
print -dps2 figure9
