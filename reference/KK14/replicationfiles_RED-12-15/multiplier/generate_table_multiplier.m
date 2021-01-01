%%%% generating Table Multiplier in 
%%%% Kliem and Kriwoluzky "Toward a Taylor Rule of Fiscal Policy"


dynare model_bench_irf1;


disp('Hit any key to start the recommended model')
pause;


dynare model_ext_irf1;

clc;

plt_multiplier;
