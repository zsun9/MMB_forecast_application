def vintage_gen(vintage_date = '', start_quarter = '', end_quarter = '', raw_variables = [], observed_variables = []):

    import pathlib, warnings
    import pandas as pd
    import numpy as np
    import datetime as datetime

    # parse inputs
    vintage_date = pd.to_datetime(vintage_date)
    start_observation = pd.to_datetime(start_quarter).to_period('Q').start_time
    end_observation = pd.to_datetime(end_quarter).to_period('Q').end_time

    if vintage_date < end_observation:
        warnings.warn('Vintage date < Last observation date, so Last observation date = Vintage date.')
        end_observation = vintage_date

    variables = {
        'raw_variables': set(raw_variables), 'raw_variables_transform': set([]), 'observed_variables': set(observed_variables),
        }

    


if __name__ == '__main__':
    vintage_gen(
        vintage_date='2011-04-01', start_quarter='1980Q1', end_quarter='2010Q2', 
        raw_variables=['GDPC1'], observed_variables=['gdp_rgd_obs']
    )