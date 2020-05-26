import pathlib
import pandas as pd
import get_vintage_data, create_sample_ends_at_vintagedate

infoSpf = pd.read_csv(pathlib.Path('../data')  / 'spf_dates.csv', encoding='utf-8', index_col=0)

for deadline in infoSpf['deadlines']:

    if pd.to_datetime(deadline).year in {2001, 2008, 2009, 2020}: # 2001, 2008, 2020
        quarterStart, quarterEnd = create_sample_ends_at_vintagedate.main(vintageDate=deadline, sampleSize=100)
        get_vintage_data.main(

            vintageDate=deadline, quarterStart=str(quarterStart), quarterEnd=str(quarterEnd),
            observed=[
                'gdp_rgd_obs', 'gdpdef_obs', 'ffr_obs', 'ifi_rgd_obs', 'c_rgd_obs', 
                'wage_rgd_obs', 'baag10_obs', 'hours_dngs15_obs', 'hours_sw07_obs',
                'gdpl_rgd_obs',
                ]

            )