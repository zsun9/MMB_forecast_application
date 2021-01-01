function [parstartnew ind]=steadyrunner_posterior

 global bounds_up bounds_low M_ oo_ options_

 ind=0;
% options_.order=1;
 bounds_up=[1;1];
 bounds_low=[-1;-1];
% if itvalue==1
%  
% ptauk=-0.9:.5:.1;
% ptauw=-0.9:.5:.1;
% 
%  
%  
%  ntot=length(ptauw)*length(ptauk);
% % 
%  parstart=[ptauk(1);ptauw(1)];
%  parfinal=parstart;
%  [errcheck]=steady_solver_ramsey(parstart);
%  ff1=errcheck;
%  
%  ix=0;
%  n=0;
%  hh   = waitbar(0,'Please wait... Steady State...');
%        set(hh,'Name','Ramsey Steady State')
% % 
% % 
%   for jj = 1:length(ptauk)
%         
%            for nn = 1:length(ptauw)
%     parstart=[ptauk(jj);ptauw(nn)];   
%     %parstart=[ptauw(nn)]; 
%     [errcheck]=steady_solver_ramsey(parstart);
%        n=n+1;
%        prtfrc=n/ntot;
%         
%        if errcheck<ff1
%        parfinal=[ptauk(jj);ptauw(nn)]; 
%        % parfinal=[ptauw(nn)]; 
%       
%        ff1=errcheck;
%        end
%         waitbar(prtfrc,hh,sprintf('%f done',prtfrc));
% % %     if abs(errcheck) < .01;
% % %         ix=ix+1;
% % %         II(ix)=ii;
% % %     end
% %     
% % %     mul(1,ii)=lmult1_SS;
% % %     mul(2,ii)=lmult2_SS;
% % %     mul(3,ii)=lmult3_SS;
% % %     mul(4,ii)=lmult4_SS;
% % %     mul(5,ii)=lmult5_SS;
% % %     mul(6,ii)=lmult6_SS;
% % %     mul(7,ii)=lmult7_SS;
% % %     mul(8,ii)=lmult8_SS;
% % %     mul(9,ii)=lmult9_SS;
% % %     mul(10,ii)=lmult10_SS;
% % %     mul(11,ii)=lmult11_SS;
% % %     mul(12,ii)=lmult12_SS;
% % %     mul(13,ii)=lmult13_SS;
% % %     mul(14,ii)=lmult14_SS;
% % %     mul(15,ii)=lmult15_SS;
% % %     mul(16,ii)=lmult16_SS;
% % %     mul(17,ii)=lmult17_SS;
% % %     mul(18,ii)=lmult18_SS;
% % %     mul(19,ii)=lmult19_SS;
% % %     mul(20,ii)=lmult20_SS;
% % %     mul(21,ii)=lmult21_SS;
% % %     mul(22,ii)=lmult22_SS;
% % %     mul(23,ii)=lmult23_SS;
% % %     mul(24,ii)= lmult24_SS;
% % %     mul(25,ii)= lmult25_SS;
% % %     mul(26,ii)=lmult26_SS;
% % %     mul(27,ii)=lmult27_SS;
% % %     mul(28,ii)=lmult28_SS;
%             end  
%         
%     end
% close(hh)
% %ff
% %[Y,I,J,K,N]=min(ff);
% 
% 
%     parstart=parfinal;
%     save('parfinal.mat', 'parstart');
% else
%     load('parfinal.mat');
% end

%load('parfinal.mat');

parfinal=[-0.10;0.34]
  
parfinal
%parfinal=[0.001;0.23]
%parfinal=parfinal(2)
[errcheck]=steady_solver_ramsey(parfinal)
  
format long

if abs(errcheck) > .1e-9
    opts =optimset('TolFun',1e-12,'TolX',1e-12,'Maxit',10000000000000, 'Display', 'iter');
    [parstartnew,fval,exitflag] = fminsearch(@steady_solver_ramsey, parfinal,opts);    
   
end

% if  fval==1e8
%     
%     ind=1;
%     
% end

%parstartnew=[parstartnew;parstartnew(1)]

% max(abs(feval([M_.fname '_static'],...
% 			       oo_.steady_state,...
% 			       [oo_.exo_steady_state; ...
% 		    oo_.exo_det_steady_state], M_.params)))
