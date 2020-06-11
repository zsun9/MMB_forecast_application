% function to compute standard errors of the deep parameters, written by
% Jesper Lindé 11/1/04

function xxse = ComputeStdErrors(xx,par,taux,nsteps,chk,IRFFF,IRFFFSE,IRFu,IRFuSE,IRFz,IRFzSE,criterion);


%Step 1: Setting up things in vector form, and take out non-relevant IRFs

IRFFF = IRFFF(:);%vector
IRFz = IRFz(:);%vector  
IRFu = IRFu(:);%vector
Indvec = find(IRFFF~=0);
IRFFF = IRFFF(Indvec);  
Indvec = find(IRFFFSE~=0);
IRFFFSE = IRFFFSE(Indvec);
  
IRFFF = IRFFF(1:end-(nsteps-1));%vector, take out p_i response
IRFFFSE = IRFFFSE(1:end-(nsteps-1));%vector
IRFz = IRFz(1:end-nsteps);%vector, take out p_i reponse
IRFzSE = IRFzSE(:);
IRFzSE = IRFzSE(1:end-nsteps);
  
[IRFFF,IRFu,IRFz] = setcrit(IRFFF,IRFu,IRFz,criterion);

IRFs = [IRFFF;IRFu;IRFz]; % a j x 1 vector with impulse responses.
Vhat   = [IRFFFSE(:); IRFuSE(:); IRFzSE].^2;

gammas = xx'; % a k x 1 vector with deep parameters.
nepar = length(gammas);
allparams = [gammas;IRFs]; % k+j x 1 vector for the k estimated parameters and j impulse responses.
save fixparams par chk taux nepar nsteps Vhat;


% Step 2: Compute the hessian and the g1 and g2 matrices using CEE notation.
  tic
  % Defining the function that we want to compute hessian for.
  hessian = g1g2Func(gammas,allparams,criterion);
  toc
  
  delete fixparams.mat;
  delete workingphat.mat;
  delete psiphihat.mat;

% Step 3: Computing the standard deviations

  g1 = hessian(1:length(gammas),1:length(gammas));
  g2 = hessian(1:length(gammas),length(gammas)+1:length(hessian));
  Dhat = -inv(g1)*g2;
  
  %Loading the file which contains the matrix with bootstrapped standard deviations; size j x j
  load WhatMat; 
  StdErr = sqrt(diag(Dhat*(WhatMat)*Dhat'));

  disp('Standard errors for the estimated parameters');
  xxse=StdErr


