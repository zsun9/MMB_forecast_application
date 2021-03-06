function ds = dynamic_set_auxiliary_series(ds, params)
%
% Status : Computes Auxiliary variables of the dynamic model and returns a dseries
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

ds.AUX_ENDO_LEAD_228=ds.Y_US(1);
ds.AUX_ENDO_LEAD_232=ds.AUX_ENDO_LEAD_228(1);
ds.AUX_ENDO_LEAD_124=ds.AUX_ENDO_LEAD_232(1);
ds.AUX_ENDO_LEAD_244=ds.PIE_US4(1);
ds.AUX_ENDO_LEAD_175=ds.AUX_ENDO_LEAD_244(1);
ds.AUX_ENDO_LEAD_155=ds.AUX_ENDO_LEAD_175(1);
ds.AUX_ENDO_LAG_22_1=ds.E(-1);
ds.AUX_ENDO_LAG_22_2=ds.AUX_ENDO_LAG_22_1(-1);
ds.AUX_ENDO_LAG_22_3=ds.AUX_ENDO_LAG_22_2(-1);
ds.AUX_ENDO_LAG_22_4=ds.AUX_ENDO_LAG_22_3(-1);
ds.AUX_ENDO_LAG_22_5=ds.AUX_ENDO_LAG_22_4(-1);
ds.AUX_ENDO_LAG_22_6=ds.AUX_ENDO_LAG_22_5(-1);
ds.AUX_ENDO_LAG_22_7=ds.AUX_ENDO_LAG_22_6(-1);
ds.AUX_ENDO_LAG_22_8=ds.AUX_ENDO_LAG_22_7(-1);
ds.AUX_ENDO_LAG_8_1=ds.gdpl_rgd_obs(-1);
ds.AUX_ENDO_LAG_8_2=ds.AUX_ENDO_LAG_8_1(-1);
ds.AUX_ENDO_LAG_8_3=ds.AUX_ENDO_LAG_8_2(-1);
ds.AUX_ENDO_LAG_9_1=ds.gdpl_rgd_obs_BAR(-1);
ds.AUX_ENDO_LAG_9_2=ds.AUX_ENDO_LAG_9_1(-1);
ds.AUX_ENDO_LAG_9_3=ds.AUX_ENDO_LAG_9_2(-1);
ds.AUX_ENDO_LAG_5_1=ds.PIE_US(-1);
ds.AUX_ENDO_LAG_5_2=ds.AUX_ENDO_LAG_5_1(-1);
