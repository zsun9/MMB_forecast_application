import pathlib
import pandas as pd
import get_vintage_data, create_sample_ends_at_vintagedate

infoSpf = pd.read_csv(pathlib.Path('../data')  / 'spf_dates.csv', encoding='utf-8', index_col=0)

for deadline in infoSpf['deadlines']:

#   if pd.to_datetime(deadline).year in {2001, 2008, 2009, 2020}:
     if pd.to_datetime(deadline).year in {2001, 2008, 2009, 2020}: # and pd.to_datetime(deadline).month in {2}

        print(f'Generating data in {deadline}')
        quarterStart, quarterEnd = create_sample_ends_at_vintagedate.main(vintageDate=deadline, sampleSize=100)
        get_vintage_data.main(

            vintageDate=deadline, quarterStart=str(quarterStart), quarterEnd=str(quarterEnd),
            observed=list(set([
                'ffr_obs', 
                'gdp_rgd_obs', 'gdpdef_obs', 'ifi_rgd_obs', 'c_rgd_obs', 
                'wage_rgd_obs', 'hours_sw07_obs',
                'baag10_obs', 'hours_dngs15_obs', 
                'gdpl_rgd_obs', 'unr_obs', 'cpil_obs', 'blt_obs',
                'emp_obs',
                
                'hours_frbedo08_obs', 'cnds_nom_obs', 'cd_nom_obs', 'ir_nom_obs', 'inr_nom_obs', 'cnds_def_obs', 'cd_def_obs',
                'credit_nom_obs', 'hours_kr15_obs',
                'mortgage_nom_obs',
                'mortffr_obs', 'bbb1yffr_obs', 
                'hp_nom_obs',

                'cnds_rim_obs', 'credit_rgd_obs', 'g10ffr_obs', 'hours_cmr14_obs', 'igid_rim_obs', 'igiddef_rgd_obs', 'networth_rgd_cmr14_obs', 'networth_rgd_obs',
                'rc_obs', 'pi_dm_obs','rri_obs','rbi_obs','hp_r_obs',
                'hwc_pd_obs' , 'hwr_pd_obs' , 'i_nom_obs' , 'c_winf_obs' ,'h_winf_obs',
                
                'i_A16_obs', 'hours_A16_obs', 'fgs_obs', 'cnds_nom_demean_obs', 'wage_rgd_demean_obs',
                ]))

            )

        print()