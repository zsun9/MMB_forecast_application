%function [vardata] = getdata(pinvestment,money,period,FR,sm,product,hours,vver,latest,nlags)
%latest, if 0 use the data from the first draft, with possible
%modifications as indicated in main.m
%        if 1, use the new data.
latest=1;
nlags=4;
if latest == 0
    %pinvestment: if 1, use deflator for gpdi, if 0 use price of equipment
    %money: if unity, use mzm as measure of money. otherwise, use m2
    %period: if 1, use full data set, 1959:Q2-2001:Q4
    %        if 2, use 1959:Q2-1979:Q4
    %        if 3, use 1980:Q1-2001:Q4
    %        if 4, use 1982:Q1-2001:Q4

    if vver == 0

        nomdata     =   xlsread('section1ALL_xls.xls','101 Qtr');
        realdata    =   xlsread('section1ALL_xls.xls','102 Qtr');

        GDP         =   nomdata(10,8:227)';
        GDPQ        =   realdata(10,4:223)';
        GCD         =   nomdata(12,8:227)';%cons dur
        GCN         =   nomdata(13,8:227)';%cons non dur
        GCS         =   nomdata(14,8:227)';%cons serv
        GPI         =   nomdata(15,8:227)';%investment
        GGE         =   nomdata(29,8:227)';%gov cons

    elseif vver == 1

        nomdata     =   xlsread('section1ALL_xls.xls','101 Qtr','d10:hx33');
        realdata    =   xlsread('section1ALL_xls.xls','102 Qtr','d10:ht34');

        dridata     =   csvread('DRIdata.csv',1,1);
        LBOUTU      =   csvread('LBOUTU.csv',1,1);


        GDP         =   nomdata(10-9,8-3:227-3)';
        GDPQ        =   realdata(10-9,4-3:223-3)';
        GCD         =   nomdata(12-9,8-3:227-3)';
        GCN         =   nomdata(13-9,8-3:227-3)';
        GCS         =   nomdata(14-9,8-3:227-3)';
        GPI         =   nomdata(15-9,8-3:227-3)';
        GGE         =   nomdata(29-9,8-3:227-3)';

    end

    FrancisRamey =  xlsread('ProductivitySeriesFrancisRamey.xls');
    dridata     =   csvread('DRIdata.csv',1,1);
    LBOUTU      =   csvread('LBOUTU.csv',1,1);
    load p_i

    %the following dri data correspond to 1947Q1 to 2001Q4
    LBMNU       =   dridata(1:220,1);%non-farm business hours worked
    LBCPU       =   dridata(1:220,2);%nominal, hourly non-farm business compensation
    LBOUTU      =   dridata(1:220,3);%non-farm business productivity
    FM2         =   dridata(1:220,4);
    FYFF        =   dridata(1:220,5);
    P16         =   dridata(1:220,6);
    IPXMCA      =   dridata(1:220,7);
    LBOUTU      =   LBOUTU(1:220);
    LBOUTU      =   FrancisRamey([1:220],3);


    if FR >= 1
        tt=5:220;
        tt1=6:220;
        subplot(221)
        plot(FrancisRamey(tt,1),log(LBMNU(tt)./FrancisRamey(tt,7)),FrancisRamey(tt,1),log(LBMNU(tt)./P16(tt)),FrancisRamey(tt,1),log(LBMNU(tt)./P16(tt)),'*');
        title('Francis-Ramey measure of total hours, versus the one we use (*)')
        axis tight
        subplot(222)
        plot(FrancisRamey(tt,1),log(FrancisRamey(tt,7)),FrancisRamey(tt,1),log(P16(tt)),FrancisRamey(tt,1),log(P16(tt)),'*');
        title('Francis-Ramey Measure of Population Versus P16 (*)')
        axis tight
        subplot(223)
        plot(FrancisRamey(tt1,1),100*diff(log(FrancisRamey(tt,7))));
        title('Growth Rate, Francis-Ramey Measure of Population')
        ylabel('Log difference, times 100')
        axis([min(FrancisRamey(tt,1)) max(FrancisRamey(tt,1)) -.8 1.4]);
        subplot(224)
        plot(FrancisRamey(tt1,1),100*diff(log(P16(tt))));
        title('Growth Rate, P16 (*)')
        ylabel('Log difference, times 100')
        axis([min(FrancisRamey(tt,1)) max(FrancisRamey(tt,1)) -.8 1.4]);
        P16=FrancisRamey([1:220],7);%Francis and Ramey (2004) suggest deflating by their adjusted measure of population
        figure
    end


    if sm == 1
        tt=5:220;
        tt1=6:220;
        [A,B]=hpmatrix(P16(tt),1600);
        P16c=B*P16(tt);
        P16t=P16(tt)-P16c;
        subplot(211)
        plot(FrancisRamey(tt,1),log(P16t),FrancisRamey(tt,1),log(P16(tt)))
        title('population, P16, HP trend versus original data')
        subplot(212)
        plot(FrancisRamey(tt1,1),100*diff(log(P16t)),FrancisRamey(tt1,1),100*diff(log(P16(tt))))
        P16=[0
            0
            0
            0
            P16t];
        figure
    end
    warning off MATLAB:divideByZero
    percaphours =   LBMNU./P16;                 %per capita hours Non-farm Business

    if FR == 2;%If you're using Francis and Ramey, and want to detrend the resulting percapita hours data....
        trendval=1;
        tt=5:length(percaphours);
        percaphoursdt = detrendrjv(percaphours(tt),trendval,1);
        percaphoursdt=[0
            0
            0
            0
            percaphoursdt];
        percaphourst=percaphours-percaphoursdt;
        %plot(tt,percaphours(tt),tt,percaphourst(tt))
        percaphours=percaphoursdt;
    end

    pgdp        =   GDP./GDPQ;                  %GDP deflator
    ymm         =   (GDP./pgdp)./P16;           %real chain weighted level of output.
    cmm         =   ((GCN+GCS+GGE)./pgdp)./P16; %consumption on nondurables and services and government.
    imm         =   ((GCD + GPI)./pgdp)./P16 ;  %consumption of durables and private investment.
    cmmratio    =   (GCN+GCS+GGE)./GDP;
    immratio    =   (GCD + GPI)./GDP;
    wagez       =   exp(log(LBCPU)-log(pgdp));
    capu        =   IPXMCA;                     %capacity utilization
    warning on MATLAB:divideByZero
    load mzm

    lprod=log(ymm./percaphours);
    dprod=diff(lprod);
    lhours=log(percaphours);

    if product == 1%non farm productivity and hours (taken from Francis and Ramey)
        lprod=log(FrancisRamey([1:220],4));
        dprod=diff(lprod);
        lhours=log(FrancisRamey([1:220],5));
    elseif product == 2%business productivity and hours
        lprod       =   log(FrancisRamey([1:220],2));%LXBA
        dprod       =   diff(lprod);
        lhours      =   log(FrancisRamey([1:220],3));%LXBH
        output      =   exp(lprod+lhours);%business output
        cmm         =   ((GCN+GCS)./pgdp)./P16;%per capita  consumption .... not government
        cmmratio    =   (GCN+GCS)./output;
        immratio    =   (GCD+GPI)./output;
    end

    chngz = [diff(log(p_i)+log(consdef)-log(pgdp)) dprod diff(log(pgdp))];
    if pinvestment == 0
        chngz = [diff(log(p_e)+log(consdef)-log(pgdp)) dprod diff(log(pgdp))];
    end
    levlz = [log(capu)  lhours lprod-log(wagez) log(cmmratio) log(immratio) FYFF/100 log(GDP./FM2)];
    if product == 2
        levlz = [log(capu)  lhours lprod-log(wagez) log(cmmratio) log(immratio) FYFF/100 log(output./FM2)];
    end
    vardata = [chngz levlz(2:end,:)];

    %49 corresponds to 1959Q1, which is the first date on which M2 data are
    %availablez

    vardata =   vardata(49:end,:);
    load mzm

    % Note: removing the spike in the MZM growth rate makes the VAR
    % non-stationary
    % gr=diff(log(MZMsplice));
    % gr(96)=[gr(96) (gr(97)+gr(95))/2]*[.5 .5]';
    % MZMsplice1=exp(log(MZMsplice(1))+[0; cumsum(gr)]);
    % vardata(:,end)  =   log(GDP(50:end)./MZMsplice1(2:172));

    if money == 1
        vardata(:,end)  =   log(GDP(50:end)./MZMsplice(2:172));
        if product == 2
            vardata(:,end)  =   log(output(50:end)./MZMsplice(2:172));
        end
    end

    velocity=exp(vardata(:,end)+vardata(:,end-3));

    %vardata =   vardata(1:147,:);
    if period == 2
        vardata =   vardata(1:83,:); % 1959:Q2-1979:Q4
    elseif period == 3
        vardata =   vardata(84:end,:); % 1980:Q1-2001:Q4
    elseif period == 4
        vardata =   vardata(96:end,:); % 1982:Q1-2001:Q4
    end
else
    newdataUPDACEL
end
% addpath('C:\projects\acel\june2006\data')
% plotto