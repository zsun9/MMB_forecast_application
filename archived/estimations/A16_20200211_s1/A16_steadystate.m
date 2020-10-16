function [stst,check] = Ajello_JMP_notax_steadystate(stst,exe)

global M_ options_
check = 0;
     
options = optimset('MaxIter',10^6,'MaxFunEvals', 10^6,'Algorithm','sqp','TolFun',10^-4,'TolX',10^-20,'TolCon',10^-6,'Display','off'); % use if using fmincon
     
par_ss(1)  = get_param_by_name('gam_s');
par_ss(2)  = get_param_by_name('bet_s');
par_ss(3)  = get_param_by_name('delta');
par_ss(4)  = get_param_by_name('l_ss');
par_ss(5)  = get_param_by_name('nu');
par_ss(6)  = get_param_by_name('eta');
par_ss(7)  = get_param_by_name('gs_ss');
par_ss(8) = get_param_by_name('pis');
par_ss(9) = get_param_by_name('lambda_w');
par_ss(10) = get_param_by_name('etau_q_ss');
par_ss(11) = get_param_by_name('lambda_p');
par_ss(12) = get_param_by_name('h');
par_ss(13) = get_param_by_name('sg_ss');
par_ss(14) = get_param_by_name('mu_ss');
par_ss(15) = get_param_by_name('theta');
par_ss(16) = get_param_by_name('fgs_param');
par_ss(17) = get_param_by_name('Bs_ss');
par_ss = real(par_ss);


flag_i = 0;

ie = 1;

while flag_i < 1 && ie <= 20
    
    try
        
        try
            load x_init1 x0
            
            [x,~,flag_i] = fmincon(@(x) obj_dummy(x,par_ss),x0,[],[],[],[],[],[],@(x) SS_Ajello_AER16(x,par_ss),options);
            
        catch me
            
            filename = [ 'x_init' num2str(ie) '.mat' ];
            load(filename,'x0');
            
            load params_m1
            n_trial = 50;
            diff_params = ((par_ss - par_ss_m1))/n_trial;
            for ii = 1:n_trial
               par_ss = par_ss_m1 + diff_params;
               if ii == 1 || flag_i == 0
                   x = x0;
               end
                    [x,~,flag_i] = fmincon(@(x) obj_dummy(x,par_ss),x,[],[],[],[],[],[],@(x) SS_Ajello_AER16(x,par_ss),options);
                 par_ss_m1 = par_ss;
            end
            
        end
        
    catch me
       
        flag_i = 0;       
        ie     = ie + 1;
        
    end
    
end

if flag_i >= 1
    par_ss_m1 = par_ss;
    save params_m1 par_ss_m1
    
    x0 = x;
    
    filename = [ 'x_init' num2str(1) '.mat' ];
    save(filename,'x0');

end

[~,~,stst] = SS_Ajello_AER16(x0,par_ss);

stst = stst';