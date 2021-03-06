from gen_vintage import gen_vintage
import pandas as pd

spf_deadlines = [
    '2001-02-14',
    '2001-05-12',
    '2001-08-15',
    '2001-11-14',
    '2008-08-07',
    '2020-02-11',
    '2020-05-12',
]

window = 100

for dl in spf_deadlines:

    print(f'\n\nNow collecting data for {dl} vintage date')

    quarterEnd = str(pd.to_datetime(dl).to_period('Q'))
    quarterStart = pd.to_datetime(dl).to_period('Q').end_time + pd.Timedelta('1 days')
    quarterStart = pd.to_datetime(str(quarterStart.year - 25) + quarterStart.strftime('-%m-%d'))
    quarterStart = str(quarterStart.to_period('Q'))

    gen_vintage(
        vintageDate=dl, 
        quarterStart=quarterStart, 
        quarterEnd=quarterEnd, 
        observed=['gdp_rgd_obs', 'gdpdef_obs', 'ffr_obs', 'ifi_rgd_obs', 'c_rgd_obs', 'wage_rgd_obs', 'hours_dngs15_obs', 'hours_sw07_obs', 'baag10_obs'],
        )