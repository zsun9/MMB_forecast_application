

close all
clear all

clc

load 'model_baseline_results_backup.mat'
m1=oo_;

load 'model_ext_results_backup.mat'
m2=oo_;



%%% Printing Table with Posterior statistics %%%%%%%%

paranames1= [   'sigma_c';
                'sigma_l';
                'h      ';
                'gamma_p';
                'gamma_w';
                'nu     ';
                'sigma_u';
                'rho_R  ';
                'rho_pi ';
                'rho_y  ';
                'rho_w  ';
                'etaWb  ';
                'rho_k  ';
                'etaKb  '
                 ] ;
            
 paranames3= [  'etaWy  ';
                'etaKy  ';
                'etaWh  ';
                'etaKI  ' ] ;           
                      
 paranames2= [  'rho_tr   ';
                'rho_eps_i';
                'rho_eps_z';
                'rho_eps_q';
                'rho_P    ';
                'rho_cg   '];
                     
 np1=size(paranames1,1);
 np2=size(paranames2,1);
             
 exoparaname = ['e_i     ';
                'e_z     ';
                'e_q     ';
                'eps_m   ';
                'eps_tauw';
                'eps_tauk';
                'eps_cg  ';
                'eps_tr  ';
                'e_P     ';
                'e_L     ';
                'eps_y   ';
                 ]; 
             
  nx=size(exoparaname,1); 
  
  addnames= [   'tax_obs' ];
  
    na=size(addnames,1); 
    
disp('Table: MCMC results');
 disp('-------------------------------------------------------------------------');
 disp(' ');
 disp(sprintf('Parameter \t \t Baseline Model \t \t \t \t \t \t Recommended Model '));
 disp(' ');
 disp(sprintf('\t \t     \t mode median  5%%  95%% \t \t \t \t mode median  5%% 95%% '));
 disp(' ');
 disp('-------------------------------------------------------------------------');

 
 for i=1:np1
 
 
  
       
   pmode1=eval(['m1.posterior_mode.parameters.' deblank(paranames1(i,:))]);
 pmean1=eval(['m1.posterior_median.parameters.' deblank(paranames1(i,:))]);
 HPDinf1=eval(['m1.posterior_hpdinf.parameters.' deblank(paranames1(i,:))]);
 HPDsup1=eval(['m1.posterior_hpdsup.parameters.' deblank(paranames1(i,:))]);

 pmode2=eval(['m2.posterior_mode.parameters.' deblank(paranames1(i,:))]);
 pmean2=eval(['m2.posterior_median.parameters.' deblank(paranames1(i,:))]);    
 HPDinf2=eval(['m2.posterior_hpdinf.parameters.' deblank(paranames1(i,:))]);
 HPDsup2=eval(['m2.posterior_hpdsup.parameters.' deblank(paranames1(i,:))]);
        
  disp(sprintf('%s \t \t %1.4f  %1.4f  %1.4f  %1.4f \t  %1.4f %1.4f  %1.4f  %1.4f', paranames1(i,:),pmode1, pmean1,HPDinf1,HPDsup1, pmode2,pmean2,HPDinf2,HPDsup2));    
  
 end
 
  for i=1:np2
 
 pmode1=eval(['m1.posterior_mode.parameters.' deblank(paranames2(i,:))]);
 pmean1=eval(['m1.posterior_median.parameters.' deblank(paranames2(i,:))]);
 HPDinf1=eval(['m1.posterior_hpdinf.parameters.' deblank(paranames2(i,:))]);
 HPDsup1=eval(['m1.posterior_hpdsup.parameters.' deblank(paranames2(i,:))]);

 pmode2=eval(['m2.posterior_mode.parameters.' deblank(paranames2(i,:))]);
 pmean2=eval(['m2.posterior_median.parameters.' deblank(paranames2(i,:))]);    
 HPDinf2=eval(['m2.posterior_hpdinf.parameters.' deblank(paranames2(i,:))]);
 HPDsup2=eval(['m2.posterior_hpdsup.parameters.' deblank(paranames2(i,:))]);
    
  
  disp(sprintf('%s \t \t %1.4f  %1.4f  %1.4f  %1.4f \t  %1.4f %1.4f  %1.4f  %1.4f', paranames2(i,:),pmode1, pmean1,HPDinf1,HPDsup1, pmode2,pmean2,HPDinf2,HPDsup2));    
  
   
 end
 
  for i=1:2
 
 
  
       
   pmode1=eval(['m1.posterior_mode.parameters.' deblank(paranames3(i,:))]);
 pmean1=eval(['m1.posterior_median.parameters.' deblank(paranames3(i,:))]);
 HPDinf1=eval(['m1.posterior_hpdinf.parameters.' deblank(paranames3(i,:))]);
 HPDsup1=eval(['m1.posterior_hpdsup.parameters.' deblank(paranames3(i,:))]);

 pmode2=eval(['m2.posterior_mode.parameters.' deblank(paranames3(i+2,:))]);
 pmean2=eval(['m2.posterior_median.parameters.' deblank(paranames3(i+2,:))]);    
 HPDinf2=eval(['m2.posterior_hpdinf.parameters.' deblank(paranames3(i+2,:))]);
 HPDsup2=eval(['m2.posterior_hpdsup.parameters.' deblank(paranames3(i+2,:))]);
        
  disp(sprintf('%s \t \t %1.4f  %1.4f  %1.4f  %1.4f \t  -\t\t -\t\t  - \t\t -', paranames3(i,:),pmode1, pmean1,HPDinf1,HPDsup1));    
  disp(sprintf('%s \t \t - \t\t - \t\t - \t\t - \t\t\t  %1.4f %1.4f  %1.4f  %1.4f', paranames3(i+2,:), pmode2,pmean2,HPDinf2,HPDsup2));    
  
 end
 
 



for i=1:nx
 
 pmode1=eval(['m1.posterior_mode.shocks_std.' deblank(exoparaname(i,:))]);
 pmean1=eval(['m1.posterior_median.shocks_std.' deblank(exoparaname(i,:))]);
 HPDinf1=eval(['m1.posterior_hpdinf.shocks_std.' deblank(exoparaname(i,:))]);
 HPDsup1=eval(['m1.posterior_hpdsup.shocks_std.' deblank(exoparaname(i,:))]);

 pmode2=eval(['m2.posterior_mode.shocks_std.' deblank(exoparaname(i,:))]);
 pmean2=eval(['m2.posterior_median.shocks_std.' deblank(exoparaname(i,:))]);    
 HPDinf2=eval(['m2.posterior_hpdinf.shocks_std.' deblank(exoparaname(i,:))]);
 HPDsup2=eval(['m2.posterior_hpdsup.shocks_std.' deblank(exoparaname(i,:))]);
    
  
  disp(sprintf('%s \t \t %1.4f  %1.4f  %1.4f  %1.4f \t  %1.4f %1.4f  %1.4f  %1.4f', exoparaname(i,:),pmode1, pmean1,HPDinf1,HPDsup1, pmode2,pmean2,HPDinf2,HPDsup2));    
  
   
 end

for i=1:na
 
 pmode1=eval(['m1.posterior_mode.measurement_errors_std.' deblank(addnames(i,:))]);
 pmean1=eval(['m1.posterior_median.measurement_errors_std.' deblank(addnames(i,:))]);
 HPDinf1=eval(['m1.posterior_hpdinf.measurement_errors_std.' deblank(addnames(i,:))]);
 HPDsup1=eval(['m1.posterior_hpdsup.measurement_errors_std.' deblank(addnames(i,:))]);

 pmode2=eval(['m2.posterior_mode.measurement_errors_std.' deblank(addnames(i,:))]);
 pmean2=eval(['m2.posterior_median.measurement_errors_std.' deblank(addnames(i,:))]);    
 HPDinf2=eval(['m2.posterior_hpdinf.measurement_errors_std.' deblank(addnames(i,:))]);
 HPDsup2=eval(['m2.posterior_hpdsup.measurement_errors_std.' deblank(addnames(i,:))]);
    
  
  disp(sprintf('%s \t \t %1.4f  %1.4f  %1.4f  %1.4f \t  %1.4f %1.4f  %1.4f  %1.4f', addnames(i,:),pmode1, pmean1,HPDinf1,HPDsup1, pmode2,pmean2,HPDinf2,HPDsup2));    
  
   
 end

 disp(' ');
 disp('-------------------------------------------------------------------------');
 disp(sprintf('log data density: \t \t  %4.3f  \t \t \t \t %4.3f ', m1.MarginalDensity.ModifiedHarmonicMean, m2.MarginalDensity.ModifiedHarmonicMean));    
 disp(' ');
 disp('-------------------------------------------------------------------------');

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Comparision of posterior distributions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
    
figure;
exoparaname1 = ['sigma_c';
                'sigma_l';
                'h      ';
                'gamma_p'
                'gamma_w';
                'sigma_u';
                'nu     '
                 ];
             
             
 
set(gcf, 'PaperType', 'USLegal');
set(gcf, 'PaperPositionMode', 'auto');
                 
for i=1:size(exoparaname1,1)
    subplot(3,3,i)
     name = deblank(exoparaname1(i,:));
     
    eval(['x1 = m1.posterior_density.parameters.' name '(:,1);'])
    eval(['f1 = m1.posterior_density.parameters.' name '(:,2);'])
     eval(['x2 = m1.prior_density.parameters.' name '(:,1);'])
    eval(['f2 = m1.prior_density.parameters.' name '(:,2);'])
     eval(['x3 = m2.posterior_density.parameters.' name '(:,1);'])
    eval(['f3 = m2.posterior_density.parameters.' name '(:,2);'])
    top1 = max(f1);
    top2 = max(f2);
    top3 = max(f3);
    top0 = max([top1;top2;top3]);
    binf1 = x1(1);
    bsup1 = x1(end);
    binf2 = x2(1);
    bsup2 = x2(end);
    binf3 = x3(1);
    bsup3 = x3(end);
   
    
    borneinf = min([binf1,binf2,binf3]);
    bornesup = max([bsup1,bsup2,binf3]);
    
    
    hh = plot(x2,f2,'-k','linewidth',2);
    set(hh,'color',[0.7 0.7 0.7]);
    hold on;
    plot(x1,f1,'-k','linewidth',2);
    plot(x3,f3,'-.r','linewidth',1.5);
    box on;
    axis([borneinf bornesup 0 1.1*top0]);
    title(name,'Interpreter','none');
    hold off
    
    
end
legend_handle = legend('Prior  ','Posterior Baseline','Posterior Recomended','Orientation', 'horizontal');
    %legend_handle = legend('new feedback rules long','old feedback rules long','Orientation', 'horizontal' );
    set(legend_handle,'Box', 'off', 'FontSize', 11)
    set(legend_handle,'Position',[0.3775 -0.05 0.2857 0.1444]); 

 
figure;
exoparaname1 = ['rho_R    ';
                'rho_pi   ';
                'rho_y    ';
                'rho_eps_i';
                'rho_eps_z';
                'rho_eps_q';
                'rho_tr   ';
                'rho_cg   ';
                'rho_P    '
                 ];
             
             
 

                 
for i=1:size(exoparaname1,1)
    subplot(3,3,i)
     name = deblank(exoparaname1(i,:));
     
    eval(['x1 = m1.posterior_density.parameters.' name '(:,1);'])
    eval(['f1 = m1.posterior_density.parameters.' name '(:,2);'])
     eval(['x2 = m1.prior_density.parameters.' name '(:,1);'])
    eval(['f2 = m1.prior_density.parameters.' name '(:,2);'])
     eval(['x3 = m2.posterior_density.parameters.' name '(:,1);'])
    eval(['f3 = m2.posterior_density.parameters.' name '(:,2);'])
    top1 = max(f1);
    top2 = max(f2);
    top3 = max(f3);
    top0 = max([top1;top2;top3]);
    binf1 = x1(1);
    bsup1 = x1(end);
    binf2 = x2(1);
    bsup2 = x2(end);
    binf3 = x3(1);
    bsup3 = x3(end);
   
    borneinf = min([binf1,binf2,binf3]);
    bornesup = max([bsup1,bsup2,binf3]);
    
    
    hh = plot(x2,f2,'-k','linewidth',2);
    set(hh,'color',[0.7 0.7 0.7]);
    hold on;
    plot(x1,f1,'-k','linewidth',2);
    plot(x3,f3,'-.r','linewidth',1.5);
    box on;
    axis([borneinf bornesup 0 1.1*top0]);
    title(name,'Interpreter','none');
    hold off
    
    
end
legend_handle = legend('Prior  ','Posterior Baseline','Posterior Recomended','Orientation', 'horizontal');
    %legend_handle = legend('new feedback rules long','old feedback rules long','Orientation', 'horizontal' );
    set(legend_handle,'Box', 'off', 'FontSize', 11)
    set(legend_handle,'Position',[0.3775 -0.05 0.2857 0.1444]);     
    

figure('Position',[50 200 560 660]);

exoparaname1 = ['e_i     ';
                'e_z     ';
                'e_q     ';
                'eps_m   ';
                'eps_tauw';
                'eps_tauk';
                'eps_cg  ';
                'eps_tr  ';
                'e_P     ';
                'e_L     ';
                'eps_y   ';
                'tax_obs ';
                 ];
             
             

%stderr tax,0.01, inv_gamma_pdf, 0.01, 4;

                 
for i=1:size(exoparaname1,1)
    subplot(4,3,i)
     name = deblank(exoparaname1(i,:));
     
    if i==12
       eval(['x1 = m1.posterior_density.measurement_errors_std.' name '(:,1);'])
    eval(['f1 = m1.posterior_density.measurement_errors_std.' name '(:,2);'])
     eval(['x2 = m1.prior_density.measurement_errors_std.' name '(:,1);'])
    eval(['f2 = m1.prior_density.measurement_errors_std.' name '(:,2);'])
     eval(['x3 = m2.posterior_density.measurement_errors_std.' name '(:,1);'])
    eval(['f3 = m2.posterior_density.measurement_errors_std.' name '(:,2);']) 
    else
    eval(['x1 = m1.posterior_density.shocks_std.' name '(:,1);'])
    eval(['f1 = m1.posterior_density.shocks_std.' name '(:,2);'])
     eval(['x2 = m1.prior_density.shocks_std.' name '(:,1);'])
    eval(['f2 = m1.prior_density.shocks_std.' name '(:,2);'])
     eval(['x3 = m2.posterior_density.shocks_std.' name '(:,1);'])
    eval(['f3 = m2.posterior_density.shocks_std.' name '(:,2);'])
    
    end
    top1 = max(f1);
    top2 = max(f2);
    top3 = max(f3);
    top0 = max([top1;top2;top3]);
    binf1 = x1(1);
    bsup1 = x1(end);
    binf2 = x2(1);
    bsup2 = x2(end);
    binf3 = x3(1);
    bsup3 = x3(end);
   
    if i==4
    borneinf = min([binf1,binf3]);
    bornesup = max([bsup1,binf3]);
    bornesup=0.0075;
    else
    borneinf = min([binf1,binf2,binf3]);
    bornesup = max([bsup1,bsup2,binf3]);
    end
    
    hh = plot(x2,f2,'-k','linewidth',2);
    set(hh,'color',[0.7 0.7 0.7]);
    hold on;
    plot(x1,f1,'-k','linewidth',2);
    plot(x3,f3,'-.r','linewidth',1.5);
    box on;
    axis([borneinf bornesup 0 1.1*top0]);
    title(name,'Interpreter','none');
    hold off
    
    
end
legend_handle = legend('Prior  ','Posterior Baseline','Posterior Recomended','Orientation', 'horizontal');
    %legend_handle = legend('new feedback rules long','old feedback rules long','Orientation', 'horizontal' );
    set(legend_handle,'Box', 'off', 'FontSize', 11)
    set(legend_handle,'Position',[0.3775 -0.05 0.2857 0.1444]);     
    

figure('Position',[50 400 700 300]);
exoparaname1 = [%'rho_w ';
                %'etaWb ';
                'etaWy ';
                %'rho_k ';
                %'etaKb ';
                'etaKy ';
                 ];
                 
for i=1:size(exoparaname1,1)
    subplot(2,3,i)
     name = deblank(exoparaname1(i,:));
     
    eval(['x1 = m1.posterior_density.parameters.' name '(:,1);'])
    eval(['f1 = m1.posterior_density.parameters.' name '(:,2);'])
     eval(['x2 = m1.prior_density.parameters.' name '(:,1);'])
    eval(['f2 = m1.prior_density.parameters.' name '(:,2);'])
    top1 = max(f1);
    top2 = max(f2);
    top0 = max([top1;top2]);
    binf1 = x1(1);
    bsup1 = x1(end);
    binf2 = x2(1);
    bsup2 = x2(end);
   
    borneinf = min([binf1,binf2]);
    bornesup = max([bsup1,bsup2]);
    
    
    hh = plot(x2,f2,'-k','linewidth',2);
    set(hh,'color',[0.7 0.7 0.7]);
    hold on;
    plot(x1,f1,'-k','linewidth',2);
    box on;
    axis([borneinf bornesup 0 1.1*top0]);
    title(name,'Interpreter','none');
    hold off
    
    
end

set(gcf,'PaperPositionMode','auto')
print -depsc2 tax_rules_bench_fm.eps;

figure('Position',[50 400 700 300]);
exoparaname1 = [%'rho_w ';
                %'etaWb ';
                'etaWh ';
                %'rho_k ';
                %'etaKb ';
                'etaKI ';
                 ];
                 
for i=1:size(exoparaname1,1)
    subplot(2,3,i)
     name = deblank(exoparaname1(i,:));
     
    eval(['x1 = m2.posterior_density.parameters.' name '(:,1);'])
    eval(['f1 = m2.posterior_density.parameters.' name '(:,2);'])
     eval(['x2 = m2.prior_density.parameters.' name '(:,1);'])
    eval(['f2 = m2.prior_density.parameters.' name '(:,2);'])
    top1 = max(f1);
    top2 = max(f2);
    top0 = max([top1;top2]);
    binf1 = x1(1);
    bsup1 = x1(end);
    binf2 = x2(1);
    bsup2 = x2(end);
   
    borneinf = min([binf1,binf2]);
    bornesup = max([bsup1,bsup2]);
    
    
    hh = plot(x2,f2,'-k','linewidth',2);
    set(hh,'color',[0.7 0.7 0.7]);
    hold on;
    plot(x1,f1,'-k','linewidth',2);
    box on;
    axis([borneinf bornesup 0 1.1*top0]);
    title(name,'Interpreter','none');
    hold off
    
    
end

set(gcf,'PaperPositionMode','auto')
print -depsc2 tax_rules_ext_fm.eps;

figure('Position',[50 400 700 300]);
exoparaname1 = ['rho_w ';
                'etaWb ';
                'etaWy ';
                'rho_k ';
                'etaKb ';
                'etaKy ';
                 ];
                 
for i=1:size(exoparaname1,1)
    subplot(2,3,i)
     name = deblank(exoparaname1(i,:));
     
    eval(['x1 = m1.posterior_density.parameters.' name '(:,1);'])
    eval(['f1 = m1.posterior_density.parameters.' name '(:,2);'])
     eval(['x2 = m1.prior_density.parameters.' name '(:,1);'])
    eval(['f2 = m1.prior_density.parameters.' name '(:,2);'])
    top1 = max(f1);
    top2 = max(f2);
    top0 = max([top1;top2]);
    binf1 = x1(1);
    bsup1 = x1(end);
    binf2 = x2(1);
    bsup2 = x2(end);
   
    borneinf = min([binf1,binf2]);
    bornesup = max([bsup1,bsup2]);
    
    
    hh = plot(x2,f2,'-k','linewidth',2);
    set(hh,'color',[0.7 0.7 0.7]);
    hold on;
    plot(x1,f1,'-k','linewidth',2);
    box on;
    axis([borneinf bornesup 0 1.1*top0]);
    title(name,'Interpreter','none');
    hold off
    
    
end

figure('Position',[50 400 700 300]);
exoparaname1 = ['rho_w ';
                'etaWb ';
                'etaWh ';
                'rho_k ';
                'etaKb ';
                'etaKI ';
                 ];
                 
for i=1:size(exoparaname1,1)
    subplot(2,3,i)
     name = deblank(exoparaname1(i,:));
     
    eval(['x1 = m2.posterior_density.parameters.' name '(:,1);'])
    eval(['f1 = m2.posterior_density.parameters.' name '(:,2);'])
     eval(['x2 = m2.prior_density.parameters.' name '(:,1);'])
    eval(['f2 = m2.prior_density.parameters.' name '(:,2);'])
    top1 = max(f1);
    top2 = max(f2);
    top0 = max([top1;top2]);
    binf1 = x1(1);
    bsup1 = x1(end);
    binf2 = x2(1);
    bsup2 = x2(end);
   
    borneinf = min([binf1,binf2]);
    bornesup = max([bsup1,bsup2]);
    
    
    hh = plot(x2,f2,'-k','linewidth',2);
    set(hh,'color',[0.7 0.7 0.7]);
    hold on;
    plot(x1,f1,'-k','linewidth',2);
    box on;
    axis([borneinf bornesup 0 1.1*top0]);
    title(name,'Interpreter','none');
    hold off
    
    
end

 