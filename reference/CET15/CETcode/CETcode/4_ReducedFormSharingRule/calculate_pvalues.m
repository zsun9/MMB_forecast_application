%get p_values for bet1,bet2,bet3 for AOB and Nash vs. reduced form sharing rule
%Table 4, panel C in manuscript

clear all;

do_calcs=0; %=1 will do all calculations. Note that this requires allmcmcdata.mat 
            %(raw MCMC data, >500 MB, available upon request). If =0, load
            %results from disk. 

if do_calcs==1,
    
    load resultsAltOffer
    load cet_mode
    load allmcmcdata
    
    ndraws=1050000;
    
    nburn=ndraws*.5;
    allpara_mat=allpara_mat(nburn+1:end,:,:);
    
    C = permute(allpara_mat,[1 3 2]);
    allpara_mat2D = reshape(C,[],size(allpara_mat,2),1);
    
    bet1_larger_0066=find(allpara_mat2D(:,end-1)>0.06);
    pbet1_0066=length(bet1_larger_0066)/size(allpara_mat2D,1)
    
    bet1_larger_048=find(allpara_mat2D(:,end-1)>0.48);
    pbet1_048=length(bet1_larger_048)/size(allpara_mat2D,1)
    
    
    bet3_larger_047=find(allpara_mat2D(:,end)>0.47);
    pbet3_047=length(bet3_larger_047)/size(allpara_mat2D,1)
    
    
    bet3_larger_0=find(allpara_mat2D(:,end)>0);
    pbet3_0=length(bet3_larger_0)/size(allpara_mat2D,1)
    
    
    do_mean=0;
    
    randomdraws=10000;
    
    for ee=1:1:randomdraws,
        
        if do_mean==1,
            para_draw=mean(allpara_mat2D)';
            
        else
            rnum = randi([1 size(allpara_mat2D,1)],1,1);
            para_draw=(allpara_mat2D(rnum,:))';
            
        end
        
        global M_
        for ii=1:1:length(para_draw)
            para_idx=loc(M_.param_names,char(parameter_names(ii)));
            M_.params(para_idx)=para_draw(ii);
        end
        
        
        cet_steadystate;
        bet2gam_vec(ee,1)=M_.params(loc(M_.param_names,'bet2'))*M_.params(loc(M_.param_names,'gamma'));
        bet1_vec(ee,1)=M_.params(loc(M_.param_names,'bet1'));
        bet2_vec(ee,1)=M_.params(loc(M_.param_names,'bet2'));
        gamma_vec(ee,1)=M_.params(loc(M_.param_names,'gamma'));
    end
    
    bet2gamma_larger_028=find(bet2gam_vec>0.28);
    pbet2gamma_028=length(bet2gamma_larger_028)/randomdraws
    
    bet2gamma_larger_0=find(bet2gam_vec>0);
    pbet2gamma_0=length(bet2gamma_larger_0)/randomdraws
    
    save pvalues pbet1_0066 pbet1_048 pbet2gamma_028 pbet2gamma_0 pbet3_047 pbet3_0 
    
else
    
     
    load pvalues
    
    %p_values as in panel C of table 4
    
    pbet1_0066
    
    pbet1_048    
        
    pbet2gamma_028
   
    pbet2gamma_0 
    
    pbet3_047
    
    pbet3_0    
    
end


