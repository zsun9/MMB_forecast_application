function ds = dynamic_set_auxiliary_series(ds, params)
%
% Status : Computes Auxiliary variables of the dynamic model and returns a dseries
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

ds.AUX_ENDO_LAG_1_1=ds.pie(-1);
ds.AUX_ENDO_LAG_1_2=ds.AUX_ENDO_LAG_1_1(-1);
