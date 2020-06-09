function quadform   =   quadform(xx,fixedpars,taux,nsteps,psihat,Vhat,A,computeA,chk,criterion)

optpars  =  map(xx);

%Generate IRFs in the model
[modirfpol,modirfemt,modirfnet,ErrFlagVal]  =  modirf(optpars,fixedpars,taux,nsteps,A,computeA,chk);

if ErrFlagVal > 0
    quadform = 10e50;
    return
end

% Stacking the matrices to a 60 x 11 matrix, same ordering as in the data (psihat)
[modirfpol,modirfemt,modirfnet] = setcrit(modirfpol,modirfemt,modirfnet,criterion);
psiphihat = [-modirfpol; modirfemt; modirfnet];%note, minus policy shock


% nozero function replaces all zeros with NaN (policy shocks)
calcff = ([nozero(psihat) - nozero(psiphihat)].^2) ./ nozero(Vhat);%this measure do not include pinv
calcff = calcff(:);
quadform = sum(calcff(find(~isnan(calcff))));