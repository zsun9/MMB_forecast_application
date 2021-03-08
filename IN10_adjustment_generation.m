clear all; clc
objective_model = "IN10";
target_copy_model = "DS04";


pthis.vintage = ["20201110"];%,"20010512","20010815","20011114","20080807","20081110","20090210","20090512","20200211","20200512","20200812"];
pthis.scenario = ["s1","s2","s3","s4"];
pthis.suffix_of_model = ""; % suffix that ALREADY EXIST!!!
pthis.suffix_of_target_copy = "";
pthis.suffix_that_wish_to_add = "_adj";

pthis.path.root = convertCharsToStrings(pwd);
pthis.path.estimations = pthis.path.root + "\\estimations";
cd(pthis.path.root)

for ii = 1:length(pthis.vintage)
    vintage= pthis.vintage(ii);
    for kk = 1:length(pthis.scenario) 
        scenario = pthis.scenario(kk);
        cd(pthis.path.root)

        tthis.name.objective_modelworkingpath = objective_model + "_" + strrep(vintage, "-", "") + "_" + scenario +pthis.suffix_of_model ;
        tthis.name.targetcopyworkingpath = target_copy_model + "_" + strrep(vintage, "-", "") + "_" + scenario + pthis.suffix_of_target_copy;
        tthis.path.objective_modelworking = pthis.path.estimations + "\\" + tthis.name.objective_modelworkingpath;
        tthis.path.targetcopyworking = pthis.path.estimations + "\\" + tthis.name.targetcopyworkingpath;
        
        % netvigate to objective model (IN10 here) and extract the data
        cd(tthis.path.objective_modelworking);

        fname =    strcat(objective_model,".json");
        stru.objective_model = jsondecode(fileread(fname));
        
        %calculate the trends
        load('workspace.mat');

        TRENDK = TREND_AC + 1/(1-MUC)*TREND_AK ;
        TRENDY = TREND_AC + MUC/(1-MUC)*TREND_AK;  
        TRENDH = (1-MUH-KAPPA-MUBB)*TREND_AH + (MUH+MUBB)*TREND_AC + MUC*(MUH+MUBB)/(1-MUC)*TREND_AK ;
        TRENDQ = (1-MUH-MUBB)*TREND_AC + MUC*(1-MUH-MUBB)/(1-MUC)*TREND_AK - (1-MUH-KAPPA-MUBB)*TREND_AH ;

        llEXPTRENDY = exp ( TRENDY ) ;  
        llEXPTRENDK = exp ( TRENDK ) ;
        llEXPTRENDQ = exp ( TRENDQ ) ;
        llEXPTRENDH = exp ( TRENDH ) ;
        llgamma_k = exp ( TREND_AK );

        llr = 1 / BETA ;
        llr1 =  llr / llEXPTRENDY - 1 ;

        llZETA0 = BETA*llEXPTRENDK*MUC/(llgamma_k-BETA*(1-DKC))/X_SS ;
        llZETA1 = BETA*llEXPTRENDY*MUH/(1-BETA*(1-DKH));
        llZETA2 = JEI/(1-BETA*llEXPTRENDQ*(1-DH)) ;
        llZETA3 = JEI/(1-BETA1*llEXPTRENDQ*(1-DH)-llEXPTRENDQ*(BETA-BETA1)*M) ;
        llZETA4 = (llr/llEXPTRENDY-1)*M*llEXPTRENDQ/llr ;

        llDH1 = 1 - (1-DH)/llEXPTRENDH ;
        llDKC1 = 1 - (1-DKC)/llEXPTRENDK ;
        llDKH1 = 1 - (1-DKH)/llEXPTRENDY ;

        llCHI1 = 1+llDH1*llZETA2*(1-llr1*llZETA1-KAPPA-ALPHA*(1-MUH-KAPPA-MUBB)) ;
        llCHI2 = (llr1*llZETA1+KAPPA+ALPHA*(1-MUH-KAPPA-MUBB))*llDH1*llZETA3+llZETA4*llZETA3 ;
        llCHI3 = (X_SS-1+llr1*llZETA0*X_SS+ALPHA*(1-MUC))/X_SS ;
        llCHI4 = 1+llDH1*llZETA3*(1-(1-ALPHA)*(1-MUH-KAPPA-MUBB))+llZETA4*llZETA3 ;
        llCHI5 = (1-ALPHA)*(1-MUH-KAPPA-MUBB)*llDH1*llZETA2 ;
        llCHI6 = (1-ALPHA)*(1-MUC)/X_SS ;

        llCY = (llCHI3*llCHI4+llCHI2*llCHI6)/(llCHI1*llCHI4-llCHI2*llCHI5) ;
        llCYPRIME = (llCHI1*llCHI6+llCHI3*llCHI5)/(llCHI1*llCHI4-llCHI2*llCHI5) ;
        llQIY = llDH1*llZETA2*llCY + llDH1*llZETA3*llCYPRIME ;

        llRATION = (1-MUH-KAPPA-MUBB)/(1-MUC)*X_SS*llQIY  ;
        llNHNC = llRATION^(1/(1-NU)) ;
        llNHNC1 = llRATION^(1/(1-NU1)) ;

        llnc = ( ((1-MUC)*ALPHA/llCY/X_SS/XW_SS)/(1+llRATION)^((ETA+NU)/(1-NU)) )^(1/(1+ETA)) ;
        llnh = llNHNC*llnc ;

        llnc1 = ( ((1-MUC)*(1-ALPHA)/llCYPRIME/X_SS/XW_SS)/(1+llRATION)^((ETA1+NU1)/(1-NU1)) )^(1/(1+ETA1)) ;
        llnh1 = llNHNC1*llnc1 ;

        llY = (llnc^ALPHA)*(llnc1^(1-ALPHA)) *  llZETA0^(MUC/(1-MUC)) / llEXPTRENDK^(MUC/(1-MUC)) ;

        llI = (llnh^(ALPHA*(1-MUH-KAPPA-MUBB))) * (llnh1^((1-ALPHA)*(1-MUH-KAPPA-MUBB))) * llZETA1^MUH * (llY*llQIY)^MUH / llEXPTRENDY^(MUH) * (MUBB*llY*llQIY)^MUBB ;

        llq = llQIY*llY / llI ;

        llQI = llQIY*llY ;

        llkc = llZETA0*llY ;

        llkh = llZETA1*llQI ;

        llc = llCY*llY ;
        llc1 = llCYPRIME*llY ;

        llh = llZETA2*llc/llq ;
        llh1 = llZETA3*llc1/llq ;

        llb = M*llq*llEXPTRENDQ*llh1/llr ;

        llCC = llc + llc1 ;
        llIH = llI  ;
        llIK = llDKC1 * llkc + llDKH1* llkh  ;

        llikc = llDKC1 * llkc ;
        llikh = llDKH1 * llkh ;
        IKC_SS = log(llikc) ;
        IKH_SS = log(llikh) ;

        BB_SS = log(llb) ;
        CC_SS = log(llCC) ;
        IH_SS = log(llIH) ;
        IK_SS = log(llIK) ;
        QQ_SS = log(llq) ;
        RR_SS = log(llr) ;
        NC_SS = ALPHA*log(llnc) + (1-ALPHA)*log(llnc1) ;
        NH_SS = ALPHA*log(llnh) + (1-ALPHA)*log(llnh1) ;

        trend = (exp(CC_SS)/(exp(CC_SS)+exp(QQ_SS+IH_SS)+exp(IK_SS)))*(TRENDY) + (exp(IK_SS)/(exp(CC_SS)+exp(QQ_SS+IH_SS)+exp(IK_SS)))*(TRENDK) + (exp(QQ_SS+IH_SS)/(exp(CC_SS)+exp(QQ_SS+IH_SS)+exp(IK_SS)))*(TRENDH);
        trend = trend*400;
        
        % netvigate to target copy model and perform adjustments
        cd(tthis.path.targetcopyworking);

        fname =     strcat(target_copy_model,".json");
        stru.target_copy_model = jsondecode(fileread(fname));   

        %adjusted_gdp =  stru.objective_model.forecast.gdp + (stru.target_copy_model.forecast.gdp(1) - stru.objective_model.forecast.gdp(1));
        adjusted_gdp =   stru.objective_model.forecast.gdp+trend;
        adjusted_gdp(1) = stru.target_copy_model.forecast.gdp(1);

        adjstruc = stru.objective_model;
        adjstruc.forecast.gdp = adjusted_gdp;

        cd(pthis.path.estimations)
        eval(strcat("mkdir", " " ,objective_model,  "_" ,strrep(vintage, "-", ""), "_" , scenario, pthis.suffix_that_wish_to_add))
        cd(pthis.path.estimations + "\\" + strcat(objective_model,  "_" ,strrep(vintage, "-", ""), "_" , scenario, pthis.suffix_that_wish_to_add));
            JSONOutput = jsonencode(adjstruc);
            JSONFile = fopen(objective_model + ".json",'w');
            fwrite(JSONFile, JSONOutput, 'char');
            fclose(JSONFile);
        cd(pthis.path.root);
        clear tthis
    end
end