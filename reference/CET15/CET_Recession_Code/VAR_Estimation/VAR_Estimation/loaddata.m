%variable names in USdata_new.m
%see Excel file US_data_long_sample.xls for details about the variables

%sample: 1948Q1 to 2008Q4

%GDPnom            (nominal GDP)
%POP               (population)
%PGDP              (GDP deflator)
%CAPUTIL           (capacity utilization)
%WAGEreal          (real wage)
%HOURS_CAPITA      (hours per capita)
%FEDFUNDS          (Federal Funds rate)
%CONS_NDURnom      (nominal nondurable consumption)
%CONS_DURnom       (nominal  durable consumption)
%CONS_SERVnom      (nominal  consumption services)
%CONS_GOVnom       (nominal government consumption)
%INV_PRIVnom       (nominal private investment)
%INV_GOVnom        (nominal government investment)
%PCONS_NDURnom     (price index of nominal nondurable consumption)
%PCONS_DURnom      (price index of nominal  durable consumption)
%PCONS_SERVnom     (price index of nominal  consumption services)
%PINV_PRIVnom      (price index of nominal private investment)
%PINV_GOVnom       (price index of nominal government investment)


cd Data

%load the log, US participation rate (data_part)
participation

%log, civilian employment
employment

%load data
USdata_new

%data
%nominal log GDP
data_GDPnom=log(GDPnom);

%Inflation
data_INFL=400*[0; diff(log(PGDP))];

%log capacity utilization
data_CAPUTIL=log(CAPUTIL);

%log real wage
data_WAGEreal=log(WAGEreal);

%log hours per capita
data_HOURS_CAPITA=log(HOURS_CAPITA);

%federal funds rate
data_FEDFUNDS=FEDFUNDS;

%log nominal consumption
data_CONSnom=log(CONS_NDURnom + CONS_SERVnom );

%log nominal investment
data_INVnom=log(CONS_DURnom + INV_PRIVnom);

%labor productivity growth
data_LAB_PROD_GROWTH=[0;diff(data_GDPnom-log(POP)-log(PGDP)-data_HOURS_CAPITA)];

%labor productivity minus real wage
data_LAB_PROD_WAGE=data_GDPnom-log(POP)-log(PGDP)-data_HOURS_CAPITA-data_WAGEreal;

%log consumption to GDP ratio
data_CONS_GDP=data_CONSnom-data_GDPnom;

%log investment to GDP ratio
data_INV_GDP=data_INVnom-data_GDPnom;


%log gov. spending to GDP ratio (sum of cons+invest)
data_GOVGONS_GDP=log(INV_GOVnom+CONS_GOVnom)-data_GDPnom;
%

%relative price of investment
[aggINVspend,aggINVprice] = makeFisher([PINV_PRIVnom PCONS_DURnom]',[INV_PRIVnom CONS_DURnom]');
INV_PRIVplusCONS_DUR = (aggINVspend./aggINVprice)';
PI=log((INV_PRIVnom+CONS_DURnom)./(PGDP.*(INV_PRIVplusCONS_DUR)));
data_REL_PINV_GROWTH=[0;diff(PI)];

%dates
dates=1948.0:0.25:2008.75;

ia=3;
ib=3;
% subplot(ia,ib,1)
% plot(dates,data_HOURS_CAPITA-data_part)
% title('log, hours/labor force')
% axis tight
% subplot(ia,ib,2)
% plot(dates,data_part)
% title('log, labor force per capita')
% axis tight
% subplot(ia,ib,3)
% plot(dates,data_HOURS_CAPITA)
% title('log, hours per capita')
% axis tight
% subplot(ia,ib,4)
% plot(dates,lemp-log(POP))
% title('log per capita civilian employment')
% axis tight
% subplot(ia,ib,5)
% plot(dates,lemp-log(POP)-data_part)
% title('log employment over the labor force')
% axis tight
% hoursworked
% I1=find(dates==1964);
% subplot(ia,ib,6)
% tt=I1:length(dates);
% plot(dates(tt),lhours)
% title('log, average weekly hours, private industries')
% axis tight
% [A,B]=hpmatrix(dates,1600);
% [A1,B1]=hpmatrix(lhours,1600);
% hplemp=B*(lemp-log(POP));
% shpemp=std(hplemp(tt));
% hplhours=B1*lhours;
% shphours=std(hplhours);
% subplot(3,1,3)
% plot(dates,hplemp,dates(tt),hplhours,'*-')
% legend('per capita employment','average weekly hours')
% ss=['hp filtered data, std(emp) = ',num2str(shpemp),', std(avg weekly hours) = ',num2str(shphours)];
% title(ss)
% axis tight
% figure
% %subplot(ia,ib,8)
% plot(dates,hplemp,dates,B*data_HOURS_CAPITA,'*-')
% legend('per capita employment','per capita hours')
% axis tight

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%US Labor Market Data%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%finding and separation rates%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%first, convert monthly to quarterly data
stepsize=3; counter=1;
dates2=1976.0:1/4:2008+3/4; %sample for findings and separations
q_finding_q_vec=size(dates2,2);
q_separation_q_vec=size(dates2,2);
%convert monthly data to quarterly data
for jjj=0:stepsize:size(finding,1)-1,
    
    %convert monthly finding rates to quarterly frequencies
    q_finding_q=finding(jjj+1)+(1-finding(jjj+1))*finding(jjj+2)+(1-(1-finding(jjj+1))*finding(jjj+2))*finding(jjj+3);
    q_finding_q_vec(counter,1)=q_finding_q;
    
    %convert monthly separation rates to quarterly frequencies
    q_separation_q=separation(jjj+1)+(1-separation(jjj+1))*separation(jjj+2)+(1-(1-separation(jjj+1))*separation(jjj+2))*separation(jjj+3);
    q_separation_q_vec(counter,1)= q_separation_q;
    
    counter=counter+1;
end

%get missing observations
[missing_start_observations]=find(dates2(1)==dates);

%fill missing data with NaN
q_separation_q_vec_filled=[NaN*ones(missing_start_observations-1,1)
    q_separation_q_vec
    ];

q_finding_q_vec_filled=[NaN*ones(missing_start_observations-1,1)
    q_finding_q_vec
    ];


%percent deviations from mean for plotting purposes
separation_percent_dev=100*(q_separation_q_vec/mean(q_separation_q_vec)-1);
finding_percent_dev=100*(q_finding_q_vec/mean(q_finding_q_vec)-1);

data_SEPARATIONS= 100*q_separation_q_vec_filled;
data_FINDINGS= 100*q_finding_q_vec_filled ;




%load up spliced Fujita/Ramey and Shimer data
spliced_separation_finding_data

%overwrite
data_SEPARATIONS= 100*spliced_separations;
data_FINDINGS= 100*spliced_findings ;

%%%%%%%%%%%%%%%%%%%
%Unemployment rate%
%%%%%%%%%%%%%%%%%%%
%first, convert to quarterly data
stepsize=3; counter2=1;
unemprate_q=size(dates,2);

%convert monthly data to quarterly data
for jjjj=0:stepsize:size(unemprate,1)-1,
    unemprate_q(counter2,1)=sum(unemprate(jjjj+1:jjjj+stepsize,1))/stepsize;
    counter2=counter2+1;
end

%Data used for estimation
data_UNEMP=unemprate_q;


%%%%%%%%%%%%%%%%%%%
%Help Wanted Index%
%%%%%%%%%%%%%%%%%%%
%first, convert to quarterly data
stepsize=3; counter3=1;
dates4=1951.0:1/4:2008.75; %sample size of help wanted index
help_wanted_q=size(dates4,2);

%convert monthly data to quarterly data
for jjjjj=0:stepsize:size(help_wanted,1)-1,
    help_wanted_q(counter3,1)=sum(help_wanted(jjjjj+1:jjjjj+stepsize,1))/stepsize;
    counter3=counter3+1;
end

%get missing observations
[missing_start_observations2]=find(dates4(1)==dates);
[missing_end_observations2]=find(dates4(end)==dates);

%fill missing data with NaN
help_wanted_q_filled=[NaN*ones(missing_start_observations2-1,1)
    help_wanted_q
    NaN*ones(size(dates,2)-missing_end_observations2,1)
    ];

%Data used for estimation
data_VACANCIES=log(help_wanted_q_filled);



%hours worked per capita diveded by labor force over population
%(participation rate)
data_HOURS_LABFORCE=data_HOURS_CAPITA-data_part;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%put together matrix of data for estimation     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardata=[data_REL_PINV_GROWTH data_LAB_PROD_GROWTH data_INFL data_UNEMP data_CAPUTIL ...
    data_HOURS_CAPITA data_LAB_PROD_WAGE data_CONS_GDP data_INV_GDP  ...
    data_VACANCIES data_HOURS_LABFORCE data_SEPARATIONS data_FINDINGS data_FEDFUNDS];
%data_GOVGONS_GDP



raw_data_varnames=[ ...
    {'investment price deflator growth'}
    {'labor productivity growth (realY per capita/hours per capita)'}
    {'inflation'}
    {'unemployment rate'}
    {'log capacity utilization'}
    {'log hours per capita'}
    {'log(productivity per capita / real wage per capita)'}
    {'log(nom C / nom Y )'}
    {'log(nom I / nom Y )'}
    {'vacancies'}
    {'log(hours /labor force)'}
    {'job separation rate'}
    {'job finding rate'}
    %{'log(nom G / nom Y )'}
    {'federal funds rate'}
    ];

%Note that the FEDFUNDS Rate will be ordered last which is important for
%identification. In particular, we use a Choleski decomposition and
%with FEDFUNDS ordered last this implies that all other variables do
%not move on impact.

%here, we enter the date when we want the estimation to start
III=find(dates==startdate);
vardata=vardata(III+1:end,:);
dates=dates(III+1:end);

for ii = 1:size(vardata,1)
    if any(isnan(vardata(ii,:))==1)
        error('fatal (loaddata) nan in the data, make the start date later');
    end
end

%if pltt = 1, then graph the data....

pltt=0;
if pltt==1
    n1=5;
    n2=3;
    for ii = 1:14
        subplot(n1,n2,ii)
        plot(dates,vardata(:,ii))
        title(raw_data_varnames(ii,:))
        axis tight
    end
    
    
    
    %ACEL, log labor share 1954Q1-2008Q3
    timeACEL=1954:1/4:2008+2/4;
    lshare=[-0.519206705
        -0.510869495
        -0.502172619
        -0.501665469
        -0.492254466
        -0.49512561
        -0.4969858
        -0.505761901
        -0.521931938
        -0.529502715
        -0.529217999
        -0.531345422
        -0.526496289
        -0.529921218
        -0.522677377
        -0.525698457
        -0.522911504
        -0.507801915
        -0.504247119
        -0.501483393
        -0.507788768
        -0.510934237
        -0.512924923
        -0.515092627
        -0.515734391
        -0.524929159
        -0.519600615
        -0.524665462
        -0.519740275
        -0.510627843
        -0.504791833
        -0.500941813
        -0.497005204
        -0.502983
        -0.496185531
        -0.493596539
        -0.494055805
        -0.491068491
        -0.483414937
        -0.487280942
        -0.479909663
        -0.481100641
        -0.483013532
        -0.492484325
        -0.482583436
        -0.481442579
        -0.470345393
        -0.464144567
        -0.465172229
        -0.478843621
        -0.480505942
        -0.474209746
        -0.472610889
        -0.477284443
        -0.476909089
        -0.477126721
        -0.475437863
        -0.474351759
        -0.481173333
        -0.488897233
        -0.485114084
        -0.49454096
        -0.496617927
        -0.504839557
        -0.50672174
        -0.494556098
        -0.489683259
        -0.490674382
        -0.473280384
        -0.473280272
        -0.469650247
        -0.477255647
        -0.480225995
        -0.471157299
        -0.471490831
        -0.472897582
        -0.477046019
        -0.476070082
        -0.48799995
        -0.485436371
        -0.494533342
        -0.497062117
        -0.502563744
        -0.485680584
        -0.470853526
        -0.459081702
        -0.450862458
        -0.455541441
        -0.460494803
        -0.463453286
        -0.470836215
        -0.47195484
        -0.471617324
        -0.476353154
        -0.476649262
        -0.483031699
        -0.497988598
        -0.487215353
        -0.488016362
        -0.489788674
        -0.504745719
        -0.504295365
        -0.506237574
        -0.510498596
        -0.512704753
        -0.519476545
        -0.519945435
        -0.513115297
        -0.499542012
        -0.506324715
        -0.498361519
        -0.503605767
        -0.51566281
        -0.510442595
        -0.508286934
        -0.50062743
        -0.49586749
        -0.485814395
        -0.480925948
        -0.482573181
        -0.482291139
        -0.479612388
        -0.480203787
        -0.479905205
        -0.480042432
        -0.480171188
        -0.477166747
        -0.485139914
        -0.482506959
        -0.479470765
        -0.478937396
        -0.491433415
        -0.490097875
        -0.488976652
        -0.489639395
        -0.487684388
        -0.490970327
        -0.494261558
        -0.491881734
        -0.488384039
        -0.480063207
        -0.470580766
        -0.466779512
        -0.470462859
        -0.46833693
        -0.470158565
        -0.469732695
        -0.473431317
        -0.464426687
        -0.463708943
        -0.461364673
        -0.460957524
        -0.458676585
        -0.455435397
        -0.457913766
        -0.452382049
        -0.453765396
        -0.458591472
        -0.458020453
        -0.451181131
        -0.450281626
        -0.447775981
        -0.447118394
        -0.442430893
        -0.447838793
        -0.448711087
        -0.452369451
        -0.450229981
        -0.44522639
        -0.443154879
        -0.446902096
        -0.446406017
        -0.449588383
        -0.446215626
        -0.445809811
        -0.457308528
        -0.468188541
        -0.47785511
        -0.480737793
        -0.481092108
        -0.487206373
        -0.486319249
        -0.486585758
        -0.488037631
        -0.515343201
        -0.498534495
        -0.513943757
        -0.506331488
        -0.514239719
        -0.498834858
        -0.491822713
        -0.478477846
        -0.475064573
        -0.478407314
        -0.470846543
        -0.465856818
        -0.463106599
        -0.464467045
        -0.455884621
        -0.45728089
        -0.444700263
        -0.440197292
        -0.445860984
        -0.449624136
        -0.440431865
        -0.44008555
        -0.438205395
        -0.440802673
        -0.441272868
        -0.432276821
        -0.434293615
        -0.450630983
        -0.450040426
        -0.43942021
        -0.431251005
        -0.434609271
        -0.431299147
        -0.421535964
        -0.415491328];
    
    figure
    subplot(n1,n2,1)
    plot(timeACEL,lshare,dates,vardata(:,7)+mean(lshare)-mean(vardata(:,7)),'*-')
    legend('ACEL labor share','our labor share',2)
    axis tight
    
    [A,B]=hpmatrix(vardata(:,1),1600);
    sep=B*log(vardata(:,11));
    y=B*log(GDPnom(III+1:end)./PGDP(III+1:end));
    subplot(n1,n2,2)
    plot(dates,sep,dates,y,'*-')
    legend('HP log, separation','HP log real GDP',3)
    axis tight
    
    print -dpdf data
end

cd ..