function [ff,ErrFlagVal] = MomentFunction(allparams,comp_psihat,baseline,criterion);

ErrFlagVal = 0;

load fixparams;
psihat = allparams(nepar+1:end);

% Case #1: baseline == 1.
% Compute psiphihat which is used to form f0 in g1g2Func.m.
if baseline == 1;
    xx = allparams(1:nepar);
    [modirfpol,modirfemt,modirfnet,ErrFlagVal] = modirf(xx,par,taux,nsteps,[],1,0);
    IRFFF = -modirfpol(:);%vector, negative policy shock
    IRFu  = modirfemt(:);%vector
    IRFz  = modirfnet(:);%vector
    Indvec = find(IRFFF~=0);
    IRFFF = IRFFF(Indvec);
    IRFz  = IRFz(1:end-nsteps);
    [IRFFF,IRFu,IRFz] = setcrit(IRFFF,IRFu,IRFz,criterion);
    psiphihat = [IRFFF;IRFu;IRFz]; % a j x 1 vector with impulse responses.
    
    save psiphihat psiphihat;
end;

% Case #2: comp_psihat == 1 and baseline == 0.
% Computing dff/d(gamma(i))d(gamma(j)) - i.e. for the cases when only gammas are involved in the derivatives.
if comp_psihat == 1 & baseline == 0;
   xx = allparams(1:nepar);
   [modirfpol,modirfemt,modirfnet,ErrFlagVal] = modirf(xx,par,taux,nsteps,[],1,0);
   IRFFF = -modirfpol(:);%vector, negative policy shock
   IRFu  = modirfemt(:);%vector
   IRFz  = modirfnet(:);%vector  
   Indvec = find(IRFFF~=0);
   IRFFF = IRFFF(Indvec);
   IRFz  = IRFz(1:end-nsteps);
   [IRFFF,IRFu,IRFz] = setcrit(IRFFF,IRFu,IRFz,criterion);
   psiphihat = [IRFFF;IRFu;IRFz]; % a j x 1 vector with impulse responses.
   save workingphat psiphihat;
end;

% Case #3: comp_psihat == 2 and baseline == 0.
% This is for the case when computing cross derivatives, i.e dff/(dgamma*dpsi).
if comp_psihat == 2 & baseline == 0;
   load workingphat;
end;

% Case #4: comp_psihat == 3 and baseline == 0.
% This is for the case when only psi's are involved in the computations, then we
% use the baseline decision rule results.
if comp_psihat == 3 & baseline == 0;
   load psiphihat;
end;

if ErrFlagVal == 1
    ff=10^6;
    return
end

calcff = ([nozero(psihat) - nozero(psiphihat)].^2) ./ nozero(Vhat);
calcff = calcff(:);
ff = sum(calcff(find(~isnan(calcff))));
if baseline == 1;
   ff
   %keyboard;
end;
