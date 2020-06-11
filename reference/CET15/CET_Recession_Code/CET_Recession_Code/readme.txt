MATLAB/DYNARE codes for ``Understanding the Great Recession'' by Lawrence Christiano, 
Martin Eichenbaum and Mathias Trabandt, American Economic Journal: Macroeconomics, forthcoming. 

The folder <Estimation> contains the code for the estimated medium-sized model developed in the paper. Please check out and run cet.mod.

The folder <Estimation> contains only .mat files with the posterior mode and posterior mean of the estimated parameters. Detailed numerical MCMC results are available upon request (due to large amount of data, roughly 500 MB).

The folder <GreatRecession> contains the code for the zero lower bound (ZLB) simulation described in the paper. The model and parameterization is the same as in the folder <Estimation>. Please check out and run cet.mod.

The structure of files is similar in both folders. cet.mod is the main file with the model equations. cet_steadystate.m computes the steady state. params.m sets parameter values. Please check out the comments in these files for more details.  

All computations based on MATLAB 2012a and Dynare 4.3.3.  

Mathias Trabandt (mathias.trabandt@gmail.com)

November 2014
