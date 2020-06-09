%This file is the main file for the estimation of the baseline VAR impulse
%responses used in Figures 1 and 2 in 'On DSGE Models' by Christiano,
%Eichenbaum and Trabandt (2018)

%Our VAR estimation code is an adaption of Altig, Christiano, Eichenbaum and
%Linde (2011, RED, ACEL) used in Christiano, Trabandt and Walentin (2011, 
%Handbook of Monetary Economics). The ACEL code is available in the folder named ACELcode.

clear all; clc; close all;
format long;

addpath('ACELcode');

global cut_jobdata

startdate=1951;%first observation of the data set to be used in estimation 

loaddata %load data
 
cut_jobdata=0; %if cut_jobdata=1, drop separation and finding rates.
if cut_jobdata == 1    
    vardata=vardata(:,[1:11,14]); 
end

% raw_data_varnames=[ ...
%     {'investment price deflator growth'}
%     {'labor productivity growth (realY per capita/hours per capita)'}
%     {'inflation'}
%     {'unemployment rate'}
%     {'log capacity utilization'}
%     {'log hours per capita'}
%     {'log(productivity per capita / real wage per capita)'}
%     {'log(nom C / nom Y )'}
%     {'log(nom I / nom Y )'} 
%     {'vacancies'}
%     {'log(hours /labor force)'}
%     {'job separation rate'}
%     {'job finding rate'}  
%     {'federal funds rate'}
%     ];

nvars   = size(vardata,2);
%identify a price of investment shock, a tech shock and a fed funds shock. (Fed Funds is the last variable in the VAR.)
ffshk = nvars;
nlags=2;
nsteps=20;
hascon=1;
[impzout,vdout,simdataout,erzout,azeroout,a0betazout,var_explode,V,D] = mkimplrnew(vardata,nlags,nsteps,hascon,[],[],ffshk,'sortlp',1);

if var_explode>0
    error('sorry (main) estimated VAR has explosive roots!')
end

%mkimplrnew produces:
%azeroout*y(t) = A(L)* y(t-1) + erzout(t), erzout has diagonal var covar matrix, V
%a0betazout=inv(azeroout)*A(L)

%write the system as 
%y(t) = a0betazout*y(t-1) + C * erzz(t), erzz has var covar matrix, I.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   go after impulse response functions               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Compute Bootstrap confidence intervals for impulse response functions and graph the results
%   output is saved to var20pi_yunits.mat and compare20pi_yunits.mat
%PortStatData 3xlength(PortmanteauLags) vector with the actual statistics in the first row, asymptotic p-value in second, and dof in third
%PortStatSim ndrawsxlength(PortmanteauLags) matrix with the simulated statistics
%see documentation on getvardecomp.m for a definition of the output of
%gimpulses

ndraws=100;%number of bootstrap simulations
PortmanteauLags = [4 6 8 10];%var lag lengths for which multivariate q statistics are desired
a           = 8;     % component with shortest period for band pass filter to let through
b           = 32;    % component with longest period for band pass filter.
lam         = 1600;  % parameter for HP filter.
%the following places estimated impulse responses and standard errors in
%the mat file, VAR_IRFsAndSEs.mat. See gimpulses for explanation
gimpulses(vardata,impzout,nlags,nsteps,hascon,ffshk,ndraws,PortmanteauLags,a,b,lam);
