%load VAR impulse responses from Christiano, Trabandt and Walentin 
%Handbook of Monetary Economics Chapter( see main text for reference).
load  VAR_IRFsAndSEs

IRFFF=IRFFF(:,[1:11,14]);  %cut responses of labor force, separation rate
IRFFFSE=IRFFFSE(:,[1:11,14]);

IRFz=IRFz(:,[1:11,14]);  %cut responses of labor force, separation rate 
IRFzSE=IRFzSE(:,[1:11,14]);

IRFu=IRFu(:,[1:11,14]);  %cut responses of labor force, separation rate 
IRFuSE=IRFuSE(:,[1:11,14]);


%rescale
IRFFF(:,[10,12])=IRFFF(:,[10,12])/100;
IRFFFSE(:,[10,12])=IRFFFSE(:,[10,12])/100;
IRFFF(:,[2,3])=IRFFF(:,[2,3])/400;
IRFFFSE(:,[2,3])=IRFFFSE(:,[2,3])/400;

IRFz(:,[10,12])=IRFz(:,[10,12])/100;
IRFzSE(:,[10,12])=IRFzSE(:,[10,12])/100;
IRFz(:,[2,3])=IRFz(:,[2,3])/400;
IRFzSE(:,[2,3])=IRFzSE(:,[2,3])/400;

IRFu(:,[10,12])=IRFu(:,[10,12])/100;
IRFuSE(:,[10,12])=IRFuSE(:,[10,12])/100;
IRFu(:,[2,3])=IRFu(:,[2,3])/400;
IRFuSE(:,[2,3])=IRFuSE(:,[2,3])/400;


global horizon logdetVhat Vhat inv_Vhat psihat data_varnames horizon mod_var_list mod_shock_list doMonetaryShockonly

horizon=15; %Horizon of impulse responses to match

doMonetaryShockonly=0; %if =0 all shocks used in estimation

data_varnames=[...
    {'GDP'}
    {'Inflation'}
    {'Federal Funds Rate'}
    {'Capacity Utilization'}
    {'Hours'}
    {'Real Wage'}
    {'Consumption'}
    {'Investment'}
    {'Rel. Price Investment'}
    {'Unemployment Rate'}
    {'Vacancies'}
    {'Job Finding Rate'}
    ];

mod_var_list=[{'GDPAGG'} {'piAGG'} {'RAGG'}  {'ukAGG'} {'lAGG'} {'wAGG'}  {'cAGG'}  {'iAGG'} {'pinvestAGG'}  {'unempAGG'} {'vTotAGG'} {'fAGG'} {'muF'} {'mupsiF'}];
mod_shock_list=[{'epsR_eps'} {'muz_eps'} {'mupsi_eps'} ]; %monetary, neutral tech, invest tech shocks


%select data for model estimation; if=1, data is used; if=0, data not used;
select_vec=[
    1  %GDP
    1  %Inflation
    1  %FFR
    1  %Cap.Util
    1  %Hours
    1  %rWage
    1  %Cons.
    1  %Invest.
    1  %Rel.Price Invest.
    1  %Unempl. Rate
    1  %Vacancies
    1  %Job Find. Rate
    ]';


global select_idx
if isempty(select_idx),
    select_idx=find(select_vec==1);
end

%put together selected data with desired horizon
IRFFF=IRFFF(1:horizon,select_idx);
IRFz=IRFz(1:horizon,select_idx);
IRFu=IRFu(1:horizon,select_idx);
IRFFFSE=IRFFFSE(1:horizon,select_idx);
IRFzSE=IRFzSE(1:horizon,select_idx);
IRFuSE=IRFuSE(1:horizon,select_idx);

if doMonetaryShockonly==1
    %mean impulse responses from VAR
    psihat=[-IRFFF ];
    %variances of VAR impulse responses
    Vhat=[IRFFFSE.^2 ];
else
    %mean impulse responses from VAR
    psihat=[-IRFFF, IRFz, IRFu];
    %variances of VAR impulse responses
    Vhat=[IRFFFSE.^2,IRFzSE.^2,IRFuSE.^2];
end

%vectorize
psihat=psihat(:);
Vhat=Vhat(:); %i.e. use only the diagonal part of full covariance matrix

%find non_zero entries
indx=find(psihat(:)~=0);

%cut out zero elements in Vhat and psihat (due to information restictions i.e. zero
%impact
psihat=psihat(indx);
Vhat=Vhat(indx);

%create diagonal matrices
Vhat=diag(Vhat);
inv_Vhat=inv(Vhat);

%need log det of Vhat later. To save CPU time, do it here already and not for
%every step in the estimation.
logdetVhat=logdet(Vhat);