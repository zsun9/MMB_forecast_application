%This file is the main file for the VAR sensitivity analysis, i.e. it produces 
%Figure 1 in 'On DSGE Models' by Christiano,Eichenbaum and Trabandt (2018)

%Our VAR estimation code is an adaption of Altig, Christiano, Eichenbaum and
%Linde (2011, RED, ACEL) used in Christiano, Trabandt and Walentin (2011, 
%Handbook of Monetary Economics). The ACEL code is available in the folder named ACELcode.


clear all; clc; close all;
format long;

addpath('ACELcode');

global cut_jobdata
cut_jobdata=0;

%set startdate for loaddata, needed there
startdate=1951;
%load VAR data
loaddata

%Further VAR specs
nvars= size(vardata,2); %number of variables
nsteps=20;              %number of steps for impulse responses
hascon=1;               %constant in VAR
%identify a price of investment shock, a tech shock and a fed funds shock.
%(Fed Funds is the last variable in the VAR.)
ffshk = nvars;

%ranges of specifications
startdate_vec=[1951.0 : 0.25 : 1985.75];
lag_vec=[1:1:5];

%store responses in matrices
neutral_shk_resp=NaN*zeros(nsteps,nvars,size(startdate_vec,2)*size(lag_vec,2));
invest_shk_resp=NaN*zeros(nsteps,nvars,size(startdate_vec,2)*size(lag_vec,2));
monetary_shk_resp=NaN*zeros(nsteps,nvars,size(startdate_vec,2)*size(lag_vec,2));

counterrr=0;

for startdate=startdate_vec
    
    startdate;
    
    %load VAR data
    loaddata
    
    close all
    
    for nlags=lag_vec
        counterrr=counterrr+1
        
        nlags;
        
        %estimate VAR and get responses etc
        [impzout,vdout,simdataout,erzout,azeroout,a0betazout,var_explode,V,D] = mkimplrnew(vardata,nlags,nsteps,hascon,[],[],ffshk,'sortlp',1);
        
        %check whether VAR is explosive
        if var_explode>0
            disp('sorry (main) estimated VAR has explosive roots!')
        else            
            invest_shk_resp(:,:,counterrr)=impzout(:,:,1);
            neutral_shk_resp(:,:,counterrr)=impzout(:,:,2);
            monetary_shk_resp(:,:,counterrr)=impzout(:,:,3);
        end        
    end    
end

save var_spec_sensitivity_results;

%output
data_varnames=[...
    {'Real GDP (%)'}
    {'Inflation (APR)'}
    {'Federal Funds Rate (APR)'}
    {'Capacity Utilization (%)'}
    {'Hours Worked Per Capita (%)'}
    {'Real Wage (%)'}
    {'Real Consumption (%)'}
    {'Real Investment (%)'}
    {'Rel. Price of Investment (%)'}
    ];

select_vec=[1 2 3 7 8 6];
horz=15;
fontsize=12;

load VAR_IRFsAndSEs.mat %load baseline VAR impies

warning off

ccounter=0;
%monetary shock
figure('Name','Nominal Interest Rate Shock: VAR Specification Sensitivity');
for vv=[select_vec]
    ccounter=ccounter+1;
    subplot(2,3,ccounter)
    
    if ccounter==2 || ccounter==3
        plot(0:1:horz-1,-IRFFF(1:horz,vv)/100,'b-','MarkerSize',4,'LineWidth',2.5); hold on
        plot(0:1:horz-1,squeeze(-monetary_shk_resp(1:horz,vv,:)),'Color',[0.6 0.6 0.6],'LineWidth',.1); hold on
        plot(0:1:horz-1,-IRFFF(1:horz,vv)/100+1.96/100*(-IRFFFSE(1:horz,vv)),'b--','LineWidth',2); hold on
        plot(0:1:horz-1,-IRFFF(1:horz,vv)/100-1.96/100*(-IRFFFSE(1:horz,vv)),'b--','LineWidth',2); hold on
        plot(0:1:horz-1,-IRFFF(1:horz,vv)/100,'b-','MarkerSize',4,'LineWidth',2.5); hold on
        box off
    else
        plot(0:1:horz-1,-IRFFF(1:horz,vv),'b-','MarkerSize',4,'LineWidth',2.5)
        plot(0:1:horz-1,squeeze(-100*monetary_shk_resp(1:horz,vv,:)),'Color',[0.6 0.6 0.6],'LineWidth',.1); hold on
        plot(0:1:horz-1,-IRFFF(1:horz,vv)+1.96*(-IRFFFSE(1:horz,vv)),'b--','LineWidth',2); hold on
        plot(0:1:horz-1,-IRFFF(1:horz,vv)-1.96*(-IRFFFSE(1:horz,vv)),'b--','LineWidth',2); hold on
        plot(0:1:horz-1,-IRFFF(1:horz,vv),'b-','MarkerSize',4,'LineWidth',2.5)
        box off
    end
    
    if ccounter==2        
        legend1=legend('Baseline VAR used in Estimation of \newlineMedium-Sized DSGE Model (Mean, 95%)','Alternative VAR Specifications (All Combinations of VAR \newlineLags 1,..,5 and Sample Starts 1951Q1,...,1985Q4) (Mean)');%,'Orientation','horizontal');
        set(legend1,'Orientation','horizontal','Position',[0.192474467966152 0.82696382767909 0.622415669205658 0.035675082327113],'box','off');     
    end
    
    if ccounter>3
        xlabel('Quarters','FontSize',fontsize);
    end
    
    title(data_varnames(vv,:),'FontSize',fontsize);
    set(gca,'FontSize',fontsize);
    %drawnow
    axis tight
end

%text(-40,-0.3,'Notes: All data are expressed in deviations from what would have happened in the absence of the shock. \newlineThe units are given in the titles of the subplots. % means percent deviation from unshocked path. APR means annualized percentage rate deviation from unshocked path.','FontSize',11);

suptitle('Figure 1: VAR Impulse Responses to a Monetary Policy Shock');

orient landscape
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 0.7 10.5 7.88]);

print -dpdf var_specification_sensitivity_monetary_shk



