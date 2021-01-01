%load simul_final_backup.mat
load simul_final.mat

simul_base(251:end,:)=[];


tau_k=simul_base(:,13);
tau_w=simul_base(:,14);

eQ_obs=simul_base(:,18);
eI_obs=simul_base(:,19);

eC_obs=simul_base(:,21);


tau_w(1)=[];
tau_w_obs=tau_w-mean(tau_w);

tau_k(1)=[];
tau_k_obs=tau_k-mean(tau_k);


eQ_obs(1)=[];
eI_obs(1)=[];

eC_obs(1)=[];

