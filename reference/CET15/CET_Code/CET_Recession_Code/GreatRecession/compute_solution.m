%compute stochastic simulation (imposing certainty equivalence)


global M_ oo_

sim_mat=[oo_.steady_state];
ZLBperiods_remain_vec=[];
oo_endo_simul_old=[];

do_load_results=M_.params(loc(M_.param_names,'do_load_results'));
horz=M_.params(loc(M_.param_names,'horz'));

if do_load_results~=1,
    disp(' ');
    
    for jj=1:1:horz,
        
        disp(['jj=',num2str(jj),', ' ,num2str(time(jj))]);
        
        %financial wedge
        OmFsignal=[max_range_mat(12,1);min_range_mat(12,2)*0.95;max_range_mat(12,3)*0.975;max_range_mat(12,4:11)';ones(9,1)*max_range_mat(12,11)*0.975];
        
        %flight to safety
        deltabFsignal= [mean_range_mat(15,1)/4, mean_range_mat(15,2)/4, mean_range_mat(15,3:10)/4, ones(1,10)*mean_range_mat(15,10)/4*0.975];
        
        %neutral technology
        muzFsignal=M_.params(loc(M_.param_names,'ini_ntech'));
        for zz=2:1:jj,
            muzFsignal(zz)=muzFsignal(zz-1)*M_.params(loc(M_.param_names,'rhomuzP'));
        end;
        
        %gov. spending    
        gFsignalRAW=median_range_mat(14,1:jj);%ZLB target data
        
        %difference between percent deviations and log-deviations of G and
        %data targets
        adj_vec=[-0.0091   -0.0007    0.0102   -0.0100   -0.0045   -0.0105   -0.0142   -0.0443   -0.0587   -0.0667   -0.1020   -0.1210   -0.1418   -0.1616   -0.2112   -0.2194   -0.1922   -0.2978   -0.3914   -0.4203];
        gFsignalRAW=gFsignalRAW+adj_vec(1:jj);
        
        nGFhand(1)=-muzFsignal(1);
        if jj>1,
            for kk=2:1:length(gFsignalRAW),
                nGFhand(kk)=(1-M_.params(loc(M_.param_names(:,:),'thetaG')))*nGFhand(kk-1)-muzFsignal(kk);
            end
        end
        gFsignal=(gFsignalRAW-cumsum(muzFsignal)-nGFhand); %adjust target for neutral tech. change        

        
        %get AR(1) & AR(2) coefs
        groot1=M_.params(loc(M_.param_names,'groot1'));
        groot2=M_.params(loc(M_.param_names,'groot2'));
        
        broot1=M_.params(loc(M_.param_names,'broot1'));
        broot2=M_.params(loc(M_.param_names,'broot2'));
        
        oroot1=M_.params(loc(M_.param_names,'oroot1'));
        
        %compute innovations to AR(2) processes
        if jj==1,
            g_val=gFsignal(jj);
            Om_val=OmFsignal(jj);
            deltab_val=deltabFsignal(jj);
        elseif jj==2
            g_val=gFsignal(jj)-(groot1+groot2)*gFsignal(jj-1);
            Om_val=OmFsignal(jj)-(oroot1)*OmFsignal(jj-1);
            deltab_val=deltabFsignal(jj)-(broot1+broot2)*deltabFsignal(jj-1);
        elseif jj>=3,
            g_val=gFsignal(jj)-(groot1+groot2)*gFsignal(jj-1)+(groot1*groot2)*gFsignal(jj-2);
            Om_val=OmFsignal(jj)-(oroot1)*OmFsignal(jj-1);
            deltab_val=deltabFsignal(jj)-(broot1+broot2)*deltabFsignal(jj-1)+(broot1*broot2)*deltabFsignal(jj-2);
        end
        
        muz_val=muzFsignal(jj);
        
        cet_steadystate;
        
        %SHOCKS instructions
        make_ex_;
        set_shocks(0,1,     1, muz_val);    %neutral technology
        set_shocks(0,1,     2, deltab_val); %flight to safety shock:  
        set_shocks(0,1,     3, g_val);      %gov. spending
        set_shocks(0,1,     4, Om_val);     %GZ spread
        set_shocks(0,1,     5, 1);          %switch
        set_shocks(0,1,     6, 0);
        
        if jj==1,
            simul;
        else
            make_y_;
            oo_.endo_simul(:,1:end-1)=oo_endo_simul_old(:,2:end);
            sim1;
            dyn2vec;
        end
        
        
        
        if jj>=13 && jj<=18, %date based forward guidance from 2011Q3 to 2012Q4
            if jj==13,
                disp(' ');
                disp('Starting Date-based Forward Guidance');
                disp(' ');
            end
            
            set_shocks(0,1:8,6,-1);
            make_y_;
            oo_.endo_simul(:,1:end-1)=oo_endo_simul_old(:,2:end);
            sim1;
            dyn2vec;
        end
        
        
        if jj>=19, %threshold based forward guidance from 2013Q1 to 2013Q2
            
            if jj==19,
                disp(' ');
                disp('Starting Threshold-based Forward Guidance');
                disp(' ');
            end
            
            
            idxUnemp=strmatch('unempF',M_.endo_names,'exact');
            idxR=strmatch('RF',M_.endo_names,'exact');
            idxpi=strmatch('pi4F',M_.endo_names,'exact');
            
            unempSIM=exp(oo_.endo_simul(idxUnemp,2:end));
            rSIM=exp(oo_.endo_simul(idxR,2:end));
            piSIM=exp(oo_.endo_simul(idxpi,2:end));
            
            ZLBnum=1.007675465877143+.00000001;
            
            unum=0.065;
            pinum=1.025;
            ZLBperiods_ini=min(find(rSIM>=ZLBnum))-1;
            uthres_ini=min(find(unempSIM<=unum));
            
            ZLBperiods=ZLBperiods_ini;
            uthres=uthres_ini;
            
            counterr=0;
            set_shocks(0,1:199,     6, 0);
            
            figure
            
            while ZLBperiods<uthres,
                
                disp(['Unemp. threshold violated. ZLB binds for ',num2str(ZLBperiods),' quarters while unemp. is above 6.5 percent for ',num2str(uthres),' quarters']);
                
                
                subplot(3,1,1)
                plot(unempSIM(1:20)); title('Unemployment Rate');hold on;
                plot(unum*ones(1,20),'k--');hold on;
                axis([1 20 0.0525 0.09])
                
                subplot(3,1,3)
                plot(rSIM(1:20));
                title('Gross Nominal Interest Rate');hold on;
                axis([1 20 1.0065 1.014])
                
                subplot(3,1,2)
                plot(piSIM(1:20));
                plot(pinum*ones(1,20),'k--');hold on;
                title('Gross Annual Inflation Rate');hold on;
                axis([1 20 1.0065 1.05])
                
                
                
                drawnow
                %pause
                
                counterr=counterr+1;
                
                set_shocks(0,1:ZLBperiods_ini+counterr,     6, -1);
                
                make_y_;
                oo_.endo_simul(:,1:end-1)=oo_endo_simul_old(:,2:end);
                sim1;
                dyn2vec;
                
                unempSIM=exp(oo_.endo_simul(idxUnemp,2:end));
                
                rSIM=exp(oo_.endo_simul(idxR,2:end));
                piSIM=exp(oo_.endo_simul(idxpi,2:end));
                
                ZLBperiods=min(find(rSIM>=ZLBnum))-1;
                
                uthres=min(find(unempSIM<=unum));
                
                if ZLBperiods>=uthres
                    disp(['Unemp. threshold satisfied. ZLB binds for ',num2str(ZLBperiods),' quarters while unemp. is above 6.5 percent for ',num2str(uthres),' quarters']);
                    close all
                end
            end
        end
        
        
        %record expected ZLB periods
        idxR=strmatch('RF',M_.endo_names,'exact');
        rSIM=exp(oo_.endo_simul(idxR,2:end));
        ZLBnum=1.007675465877143+.00000001;
        
        %figure;
        %plot(rSIM(1:20)); hold on;
        %pause;
        
        ZLBperiods_remain=min(find(rSIM>=ZLBnum+6.250000000000000e-04))-1;
        
        ZLBperiods_remain_vec=[ZLBperiods_remain_vec,ZLBperiods_remain];
        
        sim_mat=[sim_mat,oo_.endo_simul(:,2)];
        M_.endo_histval=oo_.endo_simul(:,2);
        all_mat(:,:,jj)=[NaN*ones(size(sim_mat,1),jj-1),oo_.endo_simul(:,1:end-jj-1)];
        oo_endo_simul_old=oo_.endo_simul;
        
    end;
    
    sim_mat=[sim_mat,oo_.endo_simul(:,3:end)];
    
    oo_.endo_simul=sim_mat;
    
    get_responses_detsim;
    
    resp_mat_ZLB=resp_mat;
    
else
    load results_baseline
end