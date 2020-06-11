%stack model responses suitably

%selected variables
varnamez=[{'GDPF'}; {'pi4F'}; {'RF'}; {'unempF'}; {'lF'}; {'LF'}; {'cF'}; {'iF'};{'wF'};{'fF'}; {'vTotF'}; {'OmF'}; {'muzF'};{'gF'}; {'deltabF'};];

%indicies for transformations below
var_indic=[1 6 5 6 6 6 1 1 1 6 1 4 1 1 5];

varnamez_2=[...
    {'GDP (%)'}
    {'Inflation (p.p., y-o-y)'}
    {'Federal Funds Rate (ann. p.p.)'}
    {'Unemployment Rate (p.p.)'}
    {'Employment (p.p.)'}
    {'Labor Force (p.p.)'}
    {'Consumption (%)'}
    {'Investment (%)'}
    {'Real Wage (%)'}
    {'Job Finding Rate (p.p.)'}
    {'Vacancies (%)'}
    {'G-Z Corporate Bond Spread (annualized p.p.)'}
    {'Neutral Technology Level (%)'}
    {'Government Consumption & Investment (%)'}
    {'Consumption Wedge (annualized p.p.)'}];


%1= percent deviations from steady state
%2= level in annual percent points
%3= level in percent
%4= level times 100
%5= absolute deviations in annual percent points
%6= absolute deviations

resp_mat=[];

for hh=1:1:size(varnamez,1),
    steady_state_mat(hh,:)=exp(oo_.steady_state(loc(M_.endo_names(:,:),char(varnamez(hh,:)))));
    if var_indic(hh)==1,
        resp_mat(hh,1:show_horz)=100*( exp((oo_.endo_simul(loc(M_.endo_names(:,:),char(varnamez(hh,:))),2:show_horz+1)))-(steady_state_mat(hh,:)))/(steady_state_mat(hh,:));
    elseif var_indic(hh)==2,
        resp_mat(hh,1:show_horz)=400*(exp(oo_.endo_simul(loc(M_.endo_names(:,:),char(varnamez(hh,:))),2:show_horz+1))-1);
    elseif var_indic(hh)==3,
        resp_mat(hh,1:show_horz)=100*(exp(oo_.endo_simul(loc(M_.endo_names(:,:),char(varnamez(hh,:))),2:show_horz+1)));
    elseif var_indic(hh)==4,
        resp_mat(hh,1:show_horz)=100*((oo_.endo_simul(loc(M_.endo_names(:,:),char(varnamez(hh,:))),2:show_horz+1)));
    elseif var_indic(hh)==5,
        resp_mat(hh,1:show_horz)=400*(exp(oo_.endo_simul(loc(M_.endo_names(:,:),char(varnamez(hh,:))),2:show_horz+1))-steady_state_mat(hh,:));
    elseif var_indic(hh)==6,
        resp_mat(hh,1:show_horz)=100*(exp(oo_.endo_simul(loc(M_.endo_names(:,:),char(varnamez(hh,:))),2:show_horz+1))-steady_state_mat(hh,:));
    end
end

%unscale variables y, w and c etc
muF_dev=100*((oo_.endo_simul(loc(M_.endo_names,'muF'),2:show_horz+1))-oo_.steady_state(loc(M_.endo_names,'muF'),:));
nGF_dev=100*((oo_.endo_simul(loc(M_.endo_names,'nGF'),2:show_horz+1))-oo_.steady_state(loc(M_.endo_names,'nGF'),:));
resp_mat(loc(char(varnamez),'GDPF'),:)=resp_mat(loc(char(varnamez),'GDPF'),:)+cumsum(muF_dev); %y
resp_mat(loc(char(varnamez),'wF'),:)=resp_mat(loc(char(varnamez),'wF'),:)+cumsum(muF_dev); %w
resp_mat(loc(char(varnamez),'cF'),:)=resp_mat(loc(char(varnamez),'cF'),:)+cumsum(muF_dev); %c
resp_mat(loc(char(varnamez),'iF'),:)=resp_mat(loc(char(varnamez),'iF'),:)+cumsum(muF_dev); %i
resp_mat(loc(char(varnamez),'gF'),:)=resp_mat(loc(char(varnamez),'gF'),:)+cumsum(muF_dev)+(nGF_dev); %g




