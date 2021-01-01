%% load raw data

data_september2012;
data0812(end-14:end,:)=[];

%%% pick the data, transform in logs and per capita if necessary
real_gdp_per_cap=data0812(:,3)./100;
priv_cons_per_cap=data0812(:,1)./100;
priv_inv_per_cap=data0812(:,2)./100;


inflation=data0812(:,14);
fedfund=data0812(:,13);

tax_rev_per_cap=data0812(:,10)./100;
lab_tax=log(data0812(:,11));
cap_tax=log(data0812(:,12));

gov_trans_per_cap=data0812(:,8)./100;
gov_per_cap=data0812(:,4)./100;

debt_per_cap=data0812(:,9)./100;
	
w_per_cap=data0812(:,15);
labor_per_cap=data0812(:,16);

raw_data=[real_gdp_per_cap priv_cons_per_cap priv_inv_per_cap cap_tax lab_tax ...
         tax_rev_per_cap gov_trans_per_cap inflation gov_per_cap fedfund debt_per_cap w_per_cap labor_per_cap];
     
     
final_data=raw_data(112:end,:);
 
y=diff(final_data(:,1));
y_obs=y-mean(y);

c=diff(final_data(:,2));
c_obs=c-mean(c);

I=diff(final_data(:,3)); 
I_obs=I-mean(I);

tau_k=final_data(:,4);
tau_k=tau_k(2:end,:)-mean(tau_k(2:end,:));

tau_w=final_data(:,5);
tau_w=tau_w(2:end,:)-mean(tau_w(2:end,:));

tax=diff(final_data(:,6));
tax_obs=tax-mean(tax);

tr=diff(final_data(:,7));
tr_obs=tr-mean(tr);

inf_p=final_data(:,8);
inf_p=inf_p(2:end,:)-mean(inf_p(2:end,:));

g=diff(final_data(:,9));
g_obs=g-mean(g);


R=final_data(:,10);
R=R(2:end,:)-mean(R(2:end,:));

B=diff(final_data(:,11));
b_obs=B-mean(B);

W=diff(final_data(:,12));
w_obs=W-mean(W);

L=final_data(:,13);
lp=L(2:end,:)-mean(L(2:end,:));

% %% stylized Facts
% % nominal Interest Rate annual
% exp(mean(final_data(:,10))*4)
% 
% % Inflation annual
% exp(mean(final_data(:,8))*4)
% 
% % Consumption output ratio
% exp(mean(final_data(:,2)))/exp(mean(final_data(:,1)))
% 
% % investment output ratio
% exp(mean(final_data(:,3)))/exp(mean(final_data(:,1)))
% 
% % gov transfer output ratio
% exp(mean(final_data(:,7)))/exp(mean(final_data(:,1)))
% 
% % debt/output ratio
% exp(mean(final_data(:,11)))/exp(mean(final_data(:,1)))/4
% 
% % gov exp./output ratio
% exp(mean(final_data(:,9)))/exp(mean(final_data(:,1)))
% 
% 
% % capital tax
% exp(mean(final_data(:,4)))
% 
% % labor tax
% exp(mean(final_data(:,5)))

