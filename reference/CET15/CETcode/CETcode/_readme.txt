MATLAB/DYNARE replication codes for ''Unemployment and Business Cycles'' by Lawrence Christiano, Martin Eichenbaum and Mathias Trabandt, Econometrica (forthcoming)


Folders
———————

The folder <1_AOB> contains the estimated alternating offer bargaining model code. Inspect and run cet.mod. 

The folder <2a_Nash> contains the estimated Nash bargaining model code. Inspect and run cet.mod.

The folder <2b_Nash> contains the estimated Nash bargaining model code when the replacement ratio is fixed at 0.37. See the paper for more details. Inspect and run cet.mod.

The folder <3_CalvoStickyWages> contains the estimated model with Calvo sticky wages. Inspect and run cet.mod.

The folder <4_ReducedFormSharingRule> contains the estimated model with the reduced form sharing rule. See the paper for more details. Inspect and run cet.mod.

The folder <5_SimpleWageRule> contains the estimated model with the simple wage rule discussed in the paper. Inspect and run cet.mod.

The folder <6_SimpleWageRule> contains the estimated model with the general wage rule discussed in the paper. Inspect and run cet.mod.

The folder <7_AOB_UnempBenefitsSimulation> contains the estimated alternating offer bargaining model code and simulates the effects of an increase in unemployment benefits. Inspect and run cet.mod. 



.m files
————————

The .m files generate_figure_1_to_3.m, generate_figure_4_to_6.m, generate_figure_7.m and generate_figure_8.m reproduce the figures provided in the paper. 



Descriptions
————————————

The provided codes can be used to replicate all results in the paper (i.e. model estimation and simulation).

The structure of files is the same in all folders. cet.mod is the main file with the model equations. The enumeration of equilibrium equations in cet.mod follows (roughly) the appendix that is available online. cet_steadystate.m computes the steady state. params.m sets parameter values. Please check out the comments in these files for more details.

Note that folders 1-6 contain the estimated models. If you execute cet.mod the estimation results for each model will be displayed in the command window. Those are the estimation results reported in the paper. Note however, that the folders do not contain the raw MCMC data (>500 MB for each model). The raw MCMC data are available upon request. 

All computations based on MATLAB 2013a and Dynare 4.4.3.  

Mathias Trabandt (mathias.trabandt@gmail.com)

March 2016


