# -*- coding: utf-8 -*-
"""
Created on Thu Jun  4 14:44:26 2020

@author: jaspe
"""


import os
#os.chdir('C:\\Users\\KaiLong\\Documents\\GitHub\\MMB_forecast_application\\scripts')
os.chdir('C:\\Users\\jaspe\\Documents\\GitHub\\MMB_forecast_application\\scripts')
from get_vintage_data import main
main(vintageDate = '2007-05-21', quarterStart = '1965Q1', quarterEnd = '2006Q4', raw = [], observed = ['hp_r_obs'], showRawTransform=False, pathExcel = None, onlyS3 = False)
main(vintageDate = '2007-05-21', quarterStart = '1965Q1', quarterEnd = '2006Q4', raw = ['CBHPI'], observed = [], showRawTransform=False, pathExcel = None, onlyS3 = False)

main(vintageDate = '2008-11-07', quarterStart = '1965Q1', quarterEnd = '2008Q4', raw = [], observed = ['rc_obs', 'pi_dm_obs','rri_obs','rbi_obs','hwc_pd_obs', 'hwr_pd_obs', 'hp_r_obs', 'i_nom_obs', 'c_winf_obs' ,'h_winf_obs'], showRawTransform=False, pathExcel = None, onlyS3 = False)

main(vintageDate = '2001-11-14', quarterStart = '1965Q1', quarterEnd = '2001Q4', raw = [], observed = ['rc_obs', 'pi_dm_obs','rri_obs','rbi_obs','hwc_pd_obs', 'hwr_pd_obs', 'hp_r_obs', 'i_nom_obs', 'c_winf_obs' ,'h_winf_obs'], showRawTransform=False, pathExcel = None, onlyS3 = False)

main(vintageDate = '2001-11-14', quarterStart = '1965Q1', quarterEnd = '2001Q4', raw = [], observed = ['hwr_pd_obs'], showRawTransform=False, pathExcel = None, onlyS3 = False)
