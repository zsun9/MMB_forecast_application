function [h] = g1g2Func(gammas,allparams,criterion);

%************************************************************************************
%  Purpose:    Computes the matrix of second partial derivatives
%              (Hessian matrix) of a function defined by a procedure
%              which below is called MomentFunction.
%
%  Remark: This procedure is written such that if there is a problem with computing
%          a gradient for a given parameter in the benchmark case, i.e. bhat + eps,
%          where bhat is the point estimate, then procedure instead compute 
%          bhat - eps, and then save the function value f(bhat)+[f(bhat)-f(bhat-eps)]
%          instead. Thus, we implicity assume that
%          f(bhat+eps)-f(bhat) = f(bhat)-f(bhat-eps) in these cases.
%
%  Last written and modified by Jesper Lindé 2004-09-10.
%************************************************************************************

x0 = allparams;

% initializations
  k = length(x0);
  kk = length(gammas); % Number of deep parameters.
  hessian = zeros(k,k);
  grdd = zeros(k,1);
  eps = (6.0554544523933429e-6)*10; %This perhaps has to be varied for each case ...
                                    %The appropriate scaling factor is decided by comparing
                                    %the effects on f(gammas) of a 2se change of an arbitrary
                                    %parameter, if the effects are about the same, step-size
                                    %is ok, if not, the step-size is increased. Another way
                                    %to check that the step-size is ok is to check convergence
                                    %of the standard errors when the scaling factor is increased.

% Computation of stepsize (dh)
  ax0 = abs(x0);
  if x0 ~= 0;
     dax0 = x0./ax0;
  else;
     dax0 = 1;
  end;
  dh = eps*max( ([ax0,(1e-2)*ones(k,1)])' )'.*dax0;

  xdh = x0+dh;
  dh = (xdh-x0);    % This increases precision slightly
  ee = eye(k);
  for i=1:length(ee);
     ee(i,i)=dh(i);
  end;
  
% This is how the call to MomentFunction is done:
%
% MomentFunction(parametervector,comp_psihat,baseline)
%
% Case #1: baseline == 1.
% Compute psiphihat which is used to form f0 in g1g2Func.m.
% Case #2: comp_psihat == 1 and baseline == 0.
% Computing dff/d(gmmma(i))d(gamma(j)) - i.e. for the cases when only gammas are involved in the derivatives.
% Case #3: comp_psihat == 2 and baseline == 0.
% This is for the case when computing cross derivatives, i.e dff/(dgamma*dpsi).
% Case #4: comp_psihat == 3 and baseline == 0.
% This is for the case when only psi's are involved in the computations, then we
% use the baseline decision rule results.
   

% Computation of f0=f(x0)
  [f0,ErrFlagVal] = MomentFunction(x0,1,1,criterion);
  if ErrFlagVal == 1;
     disp(' (g1g2Func) The equilibrium cannot be computed for the baseline parameters - something is wrong...');
  end;

% Checking accuracy of f0.
  [f0test,ErrFlagVal] = MomentFunction(x0,1,1,criterion);
  if abs(f0-f0test) > 0;
     error(' (g1g2Func) Warning: this should be a zero number, and if it is not - major problems!!!');
  end;

% Compute forward step
  probind = zeros(size(gammas));%Indicating whether there are problems with the perbutation, used later on.
  i = 1;
  while i <= k;
     if i <= kk;
        [funcval,ErrFlagVal] = MomentFunction(x0+ee(:,i),1,0,criterion);
        if ErrFlagVal == 1;%try this when the algorithm crash for desireed perbutation.
           probind(i)=1; % equal to 1 if problems, 0 othervise.
           [funcval,ErrFlagVal] = MomentFunction(x0-ee(:,i),1,0,criterion);
           if ErrFlagVal == 1;
              disp('Serious problem (g1g2Func) We cannot compute the derivate for this parameter...');
              i
              keyboard;
           else; %switching sign of the function value
              disp(' (g1g2Func) We were able to compute the derivate the other way around ... puuh!!!');
              funcval = f0+(f0-funcval);
           end;
        end;
     elseif i > kk;
        [funcval,ErrFlagVal] = MomentFunction(x0+ee(:,i),3,0,criterion);
     end;
     grdd(i,1) = funcval;%saving the gradient.
     i = i+1;
  end;
    
% Compute "double" forward step
  i = 1;
  while i <= kk; % only doing this for the rows we need.
     j = i;
     while j <= k;
        if i <= kk;
           if j <= kk;
              [funcval,ErrFlagVal]=MomentFunction( x0+(ee(:,i)+ee(:,j)),1,0,criterion );
              if ErrFlagVal == 1;
                 [funcval,ErrFlagVal]=MomentFunction( x0-(ee(:,i)+ee(:,j)),1,0,criterion );
                 if ErrFlagVal == 0;
                    disp('(g1g2Func) We were able to compute the derivate the other way around ... puuh!!!');
                    funcval = f0+(f0-funcval);
                 else;
                    disp('Serious problem (g1g2Func) We cannot compute the double difference for these parameters...');
                    [i j]
                    disp('(g1g2Func) you have control of the keyboard')
                    keyboard;
                 end;
              end;
              %This part until next % could be removed if wanted
              if j == kk;
                 [ff,ErrFlagVal] = MomentFunction( x0+ee(:,i),1,0,criterion );
                 if ErrFlagVal == 1;
                    [ff,ErrFlagVal] = MomentFunction( x0-ee(:,i),1,0,criterion );
                    if ErrFlagVal == 0;
                       disp('We were able to compute the derivate the other way around ... puuh!!!');
                    end;
                    ff = f0+(f0-ff);
                 end;
                 if abs(ff - grdd(i,1)) > 0;
                    i
                    error('Something is fishy when computing the hessian matrix');
                 end;
              end;
              %
           elseif j > kk;
              if probind(i) == 1;
                 [funcval,ErrFlagVal] = MomentFunction( x0-(ee(:,i)+ee(:,j)),2,0,criterion );
                 if ErrFlagVal == 1;
                    disp('Serious problem: We cannot compute the double difference for these parameters...');
                    [i j]
                    keyboard;
                 end;
                 funcval = f0+(f0-funcval);
              else;
                 [funcval,ErrFlagVal] = MomentFunction( x0+(ee(:,i)+ee(:,j)),2,0,criterion );
                 if ErrFlagVal == 1;
                    error('j>kk, probind(i)=0 and ErrFlagVal=1: This is not supposed to happen ...');
                 end;
              end;
           end;
        elseif i > kk;
           [funcval,ErrFlagVal] = MomentFunction( x0+(ee(:,i)+ee(:,j)),3,0,criterion );
           if ErrFlagVal == 1;
              error('i>kk and ErrFlagVal=1: This is not supposed to happen ...');
           end;
        end;
        hessian(i,j) = funcval;
        if i ~= j;
           hessian(j,i) = hessian(i,j);
        end;
        j=j+1; 
     end;
     i=i+1;
  end;
     
  grddc = zeros(k,k);
  for i=1:k;
     grddc(i,:) = ones(1,k)*grdd(i);
  end;
    
% Returning the hessian.
  h = ( ( (hessian - grddc) - grddc') + f0*ones(k,k) ) ./ (dh*dh');