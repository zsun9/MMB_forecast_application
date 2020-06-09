%this routine allows you to determine which parameters are to be estimated,
%and which are fixed. 
%II(ii,jj), ii = 1 means estimate this parameter, 0 means keep it fixed
%the value of jj matters if the associated parameter is to be estimated
%jj = 1, restrict to unit interval
%jj = 2, restrict to unit circle
%jj = 3, restrict to be positive
%jj = 4, restrict bigger than unity
%jj = 5, no restriction

%the code takes into account the setting for criterion in main.m (this
%determines whether you want all shocks in the criterion, or just a subset)

II(1,1) = 1;II(1,2)=2;%rho_M  
II(2,1) = 1;II(2,2)=2;%rho_xz  
II(3,1) = 1;II(3,2)=5;%c_z     
II(4,1) = 1;II(4,2)=2;%rho_muz 
II(5,1) = 1;II(5,2)=2;%rho_xups
II(6,1) = 1;II(6,2)=5;%c_ups   
II(7,1) = 1;II(7,2)=2;%rho_muups
II(8,1) = 1;II(8,2)=3;%sig_M    
II(9,1) = 1;II(9,2)=3;%sig_muz  
II(10,1) = 1;II(10,2)=3;%sig_muups
II(11,1) = 1;II(11,2)=3;%epsilon  
II(12,1) = 1;II(12,2)=3;%kappa    
II(13,1) = 1;II(13,2)=1;%xi_w     
II(14,1) = 1;II(14,2)=1;%b        
II(15,1) = 0;II(15,2)=3;%psi_L    
II(16,1) = 0;II(16,2)=1;%bet      
II(17,1) = 0;II(17,2)=3;%mu_ups   
II(18,1) = 0;II(18,2)=3;%mu_z     
II(19,1) = 0;II(19,2)=1;%delta    
II(20,1) = 0;II(20,2)=1;%alph     
II(21,1) = 0;II(21,2)=1;%nu       
II(22,1) = 0;II(22,2)=3;%psi_L    
II(23,1) = 0;II(23,2)=3;%x        
II(24,1) = 0;II(24,2)=3;%V        
II(25,1) = 0;II(25,2)=3;%sigma_L  
II(26,1) = 0;II(26,2)=4;%lambda_f 
II(27,1) = 0;II(27,2)=4;%lambda_w 
II(28,1) = 0;II(28,2)=2;%squig    
II(29,1) = 0;II(29,2)=2;%vartheta
II(30,1) = 1;II(30,2)=3;%sigma_a  
II(31,1) = 0;II(31,2)=3;%eta      
II(32,1) = 0;II(32,2)=5;%theta_M  
II(33,1) = 1;II(33,2)=5;%cp_z     
II(34,1) = 0;II(34,2)=5;%theta_muz
II(35,1) = 1;II(35,2)=5;%cp_ups   
II(36,1) = 0;II(36,2)=5;%theta_muups
II(37,1) = 1;II(37,2)=3;%gam    

if criterion == 1;%money shock only case
    
    II(2,1) = 0;II(2,2)=2;%rho_xz
    II(3,1) = 0;II(3,2)=5;%c_z
    II(4,1) = 0;II(4,2)=2;%rho_muz
    II(5,1) = 0;II(5,2)=2;%rho_xups
    II(6,1) = 0;II(6,2)=5;%c_ups
    II(7,1) = 0;II(7,2)=2;%rho_muups
    II(9,1) = 0;II(9,2)=3;%sig_muz
    II(10,1) = 0;II(10,2)=3;%sig_muups
    II(33,1) = 0;II(33,2)=5;%cp_z
    II(35,1) = 0;II(35,2)=5;%cp_ups
    II(26,1) = 1;II(26,2)=4;%lambda_f 
    
elseif criterion ==2;%embodied technology shocks only case
    
    II(1,1) = 0;II(1,2)=2;%rho_M
    II(2,1) = 0;II(2,2)=2;%rho_xz
    II(3,1) = 0;II(3,2)=5;%c_z
    II(4,1) = 0;II(4,2)=2;%rho_muz    
    II(8,1) = 0;II(8,2)=3;%sig_M
    II(9,1) = 0;II(9,2)=3;%sig_muz    
    II(33,1) = 0;II(33,2)=5;%cp_z
    II(26,1) = 0;II(26,2)=4;%lambda_f 
    
elseif criterion == 3;%neutral technology shocks only case
    
    II(1,1) = 0;II(1,2)=2;%rho_M
    II(5,1) = 0;II(5,2)=2;%rho_xups
    II(6,1) = 0;II(6,2)=5;%c_ups
    II(7,1) = 0;II(7,2)=2;%rho_muups
    II(8,1) = 0;II(8,2)=3;%sig_M    
    II(10,1) = 0;II(10,2)=3;%sig_muups
    II(35,1) = 0;II(35,2)=5;%cp_ups
    II(26,1) = 1;II(26,2)=4;%lambda_f 
    
end

name(1,:)   =   'rho_M      ';
name(2,:)   =   'rho_xz     ';
name(3,:)   =   'c_z        ';
name(4,:)   =   'rho_muz    ';
name(5,:)   =   'rho_xups   ';
name(6,:)   =   'c_ups      ';
name(7,:)   =   'rho_muups  ';
name(8,:)   =   'sig_M      ';
name(9,:)   =   'sig_muz    ';
name(10,:)  =   'sig_muups  ';
name(11,:)  =   'epsilon    ';
name(12,:)  =   'kappa      ';
name(13,:)  =   'xi_w       ';
name(14,:)  =   'b          ';

name(15,:)  =   'psi_L      ';
name(16,:)  =   'bet        ';
name(17,:)  =   'mu_ups     ';
name(18,:)  =   'mu_z       ';
name(19,:)  =   'delta      ';
name(20,:)  =   'alph       ';
name(21,:)  =   'nu         ';
name(22,:)  =   'psi_L      ';
name(23,:)  =   'x          ';
name(24,:) =    'V          ';
name(25,:) =    'sigma_L    ';
name(26,:) =    'lambda_f   '; 
name(27,:) =    'lambda_w   ';
name(28,:) =    'squig      ';
name(29,:) =    'vartheta   ';
name(30,:) =    'sigma_a    ';
name(31,:) =    'eta        ';
name(32,:) =    'theta_M    ';
name(33,:) =    'cp_z       ';
name(34,:) =    'theta_muz  ';
name(35,:) =    'cp_ups     ';
name(36,:) =    'theta_muups';
name(37,:) =    'gam        ';

%jj = 1, restrict to unit interval
%jj = 2, restrict to unit circle
%jj = 3, restrict to be positive
%jj = 4, restrict to be larger than one
%jj = 5, no restriction

inunitcircle=[];
nonneg=[];
unrestr=[];
inzeroone=[];
morethanoneohone=[];

ix=0;
[n,m]=size(II);
for ii = 1:n
    if II(ii,1) == 1
        ix=ix+1;
        if II(ii,2)== 1
            inzeroone=[inzeroone,ix];
        elseif II(ii,2) == 2
            inunitcircle=[inunitcircle, ix];            
        elseif II(ii,2) == 3
            nonneg=[nonneg, ix];
        elseif II(ii,2) == 4
            morethanoneohone=[morethanoneohone, ix];   
        elseif II(ii,2) == 5
            unrestr=[unrestr, ix];
        end
    end
end
        
save restr inzeroone inunitcircle nonneg morethanoneohone unrestr 

fid=fopen('do.m','w');
ix=0;
for ii = 1:n
    if II(ii,1) == 1
        ix=ix+1;
        dd=['xx(%d)  =  ',name(ii,:),';\n'];
        fprintf(fid,dd,ix);
    end
end
ix=0;
for ii = 1:n
    if II(ii,1) == 0
        ix=ix+1;
        dd=['par(%d)  =  ',name(ii,:),';\n'];
        fprintf(fid,dd,ix);
    end
end
fclose(fid);
fid=fopen('undo.m','w');
ix=0;
for ii = 1:n
    if II(ii,1) == 1
        ix=ix+1;
        dd=[name(ii,:),'  =  xx(%d) ;\n'];
        fprintf(fid,dd,ix);
    end
end
ix=0;
for ii = 1:n
    if II(ii,1) == 0
        ix=ix+1;
        dd=[name(ii,:),'  =  par(%d) ;\n'];
        fprintf(fid,dd,ix);
    end
end
fclose(fid);