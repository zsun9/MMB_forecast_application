%load simul_final_backup.mat
load simul_final.mat


simul_base(1:2000,:)=[];
%               1      2  3     4      5        6       7      8    9
%               10
%simul_base=[c_obs y_obs I_obs R_obs inf_p_obs lp_obs k_obs w_obs tax_obs b_obs tr_obs cg_obs tau_k_obs tau_w_obs welf_obs z_P eps_z eps_q eps_i];


c=simul_base(:,1);
y=simul_base(:,2);
I=simul_base(:,3);
R=simul_base(:,4);
inf_p=simul_base(:,5);
lp=simul_base(:,6);
k=simul_base(:,7);
w=simul_base(:,8);
tax=simul_base(:,9);
b=simul_base(:,10);
tr=simul_base(:,11);
cg=simul_base(:,12);
tau_k=simul_base(:,13);
tau_w=simul_base(:,14);
Welf=simul_base(:,15);


% 
% c_obs=diff(c)-mean(diff(c));
% y_obs=diff(y)-mean(diff(y));
% I_obs=diff(I)-mean(diff(I));
% lp_obs=diff(lp)-mean(diff(lp));
% w_obs=diff(w)-mean(diff(w));
% k_obs=diff(k)-mean(diff(k));
% tax_obs=diff(tax)-mean(diff(tax));
% b_obs=diff(b)-mean(diff(b));
% tr_obs=diff(tr)-mean(diff(tr));
% cg_obs=diff(cg)-mean(diff(cg));
% 
% tau_w_obs=diff(tau_w)-mean(diff(tau_w));
% tau_k_obs=diff(tau_k)-mean(diff(tau_k));


inf_p(1)=[];
inf_p_obs=inf_p-mean(inf_p);

R(1)=[];
R_obs=R-mean(R);

y(1)=[];
y_obs=y-mean(y);

c(1)=[];
c_obs=c-mean(c);

I(1)=[];
I_obs=I-mean(I);

lp(1)=[];
lp_obs=lp-mean(lp);

w(1)=[];
w_obs=w-mean(w);

tax(1)=[];
tax_obs=tax-mean(tax);

tau_w(1)=[];
tau_w_obs=tau_w-mean(tau_w);

tau_k(1)=[];
tau_k_obs=tau_k-mean(tau_k);

Welf(1)=[];
welf_obs=Welf-mean(Welf);


k(1)=[];
k_obs=k-mean(k);

b(1)=[];
b_obs=b-mean(b);


%simul_ramsey=[c_obs y_obs I_obs R_obs inf_p_obs lp_obs w_obs tau_k_obs tau_w_obs welf_obs];
simul_ramsey=[c_obs y_obs I_obs R_obs inf_p_obs lp_obs w_obs welf_obs];


load simul_final2.mat

%simul_base(1:2000,:)=[];
simul_base2=simul_base;
%simul_base=[c_obs y_obs I_obs R_obs inf_p_obs lp_obs k_obs w_obs tax_obs b_obs tr_obs cg_obs tau_k_obs tau_w_obs welf_obs z_P eps_z eps_q eps_i];



c=simul_base2(:,1);
y=simul_base2(:,2);
I=simul_base2(:,3);
R=simul_base2(:,4);
inf_p=simul_base2(:,5);
lp=simul_base2(:,6);
k=simul_base2(:,7);
w=simul_base2(:,8);
tax=simul_base2(:,9);
b=simul_base2(:,10);
tr=simul_base2(:,11);
cg=simul_base2(:,12);
tau_k=simul_base2(:,13);
tau_w=simul_base2(:,14);
Welf=simul_base2(:,15);




inf_p(1)=[];
inf_p_obs2=inf_p-mean(inf_p);

R(1)=[];
R_obs2=R-mean(R);

y(1)=[];
y_obs2=y-mean(y);

c(1)=[];
c_obs2=c-mean(c);

I(1)=[];
I_obs2=I-mean(I);

lp(1)=[];
lp_obs2=lp-mean(lp);

w(1)=[];
w_obs2=w-mean(w);

tax(1)=[];
tax_obs2=tax-mean(tax);

tau_w(1)=[];
tau_w_obs2=tau_w-mean(tau_w);

tau_k(1)=[];
tau_k_obs2=tau_k-mean(tau_k);

Welf(1)=[];
welf_obs2=Welf-mean(Welf);


k(1)=[];
k_obs2=k-mean(k);

b(1)=[];
b_obs2=b-mean(b);




% 

%simul_comp=[c_obs2 y_obs2 I_obs2 R_obs2 inf_p_obs2 lp_obs2  w_obs2  tau_k_obs2 tau_w_obs2 welf_obs2];
simul_comp=[c_obs2 y_obs2 I_obs2 R_obs2 inf_p_obs2 lp_obs2  w_obs2   welf_obs2];






varname='consum';
varname=Str2mat(varname,'output');
varname=Str2mat(varname,'investment');
varname=Str2mat(varname,'interest rate');
varname=Str2mat(varname,'inflation');
varname=Str2mat(varname,'labor');
varname=Str2mat(varname,'real wage');
%varname=Str2mat(varname,'capital tax');
%varname=Str2mat(varname,'wage tax');
varname=Str2mat(varname,'welfare');


% var_list='y';
% var_list=Str2mat(var_list,'y');
% var_list=Str2mat(var_list,'I');
% var_list=Str2mat(var_list,'R');
% var_list=Str2mat(var_list,'inf_p');
% var_list=Str2mat(var_list,'lp');
% var_list=Str2mat(var_list,'w');
% var_list=Str2mat(var_list,'welf');
% %var_list=Str2mat(var_list,'tau_k');
% %var_list=Str2mat(var_list,'tau_w');


nvar=size(varname,1);
hor=size(simul_comp,1);


% simul_comp(:,8:9)=[];
% simul_ramsey(:,8:9)=[];
% simul_ramsey(:,1)=[];
% simul_comp(:,1)=[];


figure;%('Position',[50 50 1000 150]);
for i=1:8
    
 subplot(8,1,i)
    
    %comp_irf_mean=eval(deblank(['m1.PosteriorIRF.dsge.Mean.' deblank(var_list(nn,:)) '_' deblank(shock_sc(i,:))]));
    var_comp=simul_comp(:,i);
   
   
    var_ramsey=simul_ramsey(:,i);
    
    bas_val=min([min(var_comp),min(var_ramsey)]);
    top_val=max([max(var_comp),max(var_ramsey)]);
  
    
      plot(1:hor,var_comp,'-k','linewidth',2) 
    
    
    hold on
   
   
     hh = plot(1:hor,var_ramsey,'--r','linewidth',2);
    %set(hh,'color',[0.7 0.7 0.7]);
    % plot(1:hor,comp_irf_mode,'-g','linewidth',2) 
    ylim([bas_val top_val])
    %xlim([0 255])
   title(deblank(varname(i,:)))
    hold off
  
   
end
legend_handle = legend('optimzed rules extra long','optimal policy extra long','Orientation', 'horizontal');
    %legend_handle = legend('new feedback rules long','old feedback rules long','Orientation', 'horizontal' );
    set(legend_handle,'Box', 'off', 'FontSize', 12)
    set(legend_handle,'Position',[0.3775 -0.05 0.2857 0.1444]); 

