import json
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib as mpl
import pathlib
import os 


##
quarters = ['1950Q1']

i = 0
while i < 500:
    
    lastQuarter = quarters[-1]
    if lastQuarter[-1] == '4':
        quarters.append(str(int(lastQuarter[0:4]) + 1) + 'Q1')
    else:
        quarters.append(lastQuarter[:-1] + str(int(lastQuarter[-1])+1))
        
    
    i += 1
    
quarters = [quarter[2:] for quarter in quarters]

##
modelClasses = {}

with open('../application/src/results.json') as j:
    results = json.load(j)
    
actual = {instance['vintageQuarter']: instance['actual']['gdp'] for instance in results['actual']}

external = {}
i = 0
for instance in results['external']:
    if instance['vintageQuarter'] in external.keys():
        if instance['model'] in external[instance['vintageQuarter']].keys():
            external[instance['vintageQuarter']][instance['model']+str(i)] = instance['forecast']['gdp']
            i += 1
        else:
            external[instance['vintageQuarter']][instance['model']] = instance['forecast']['gdp']
    else:
        external[instance['vintageQuarter']] = {instance['model']: instance['forecast']['gdp']}
        
ts = {}
for instance in results['ts']:
    try:
        ts[instance['vintageQuarter'] + instance['scenario']][instance['model']] = instance['forecast']['gdp']
    except:
        ts[instance['vintageQuarter'] + instance['scenario']] = {instance['model']: instance['forecast']['gdp']}
        
dsge = {}
for instance in results['dsge']:
    if 'vintageQuarter' not in instance.keys():
        instance['vintageQuarter'] = str(pd.to_datetime(instance['vintage']).to_period('Q'))
    if 'scenario' not in instance.keys():
        for scenario in [1,2,3,4]:
            try:
                dsge[instance['vintageQuarter'] + str(scenario)][instance['model']] = instance['forecast']['gdp']
            except:
                dsge[instance['vintageQuarter'] +'s'+ str(scenario)] = {instance['model']: instance['forecast']['gdp']}

            modelClasses[instance['model']] = instance['ModelClass']
    
    else:
        try:
            dsge[instance['vintageQuarter'] + instance['scenario']][instance['model']] = instance['forecast']['gdp']
        except:
            dsge[instance['vintageQuarter'] + instance['scenario']] = {instance['model']: instance['forecast']['gdp']}

        modelClasses[instance['model']] = instance['ModelClass']


#quarterlist = ['2020Q1', '2020Q2', '2020Q3' ,'2020Q4']
quarterlist = ['2008Q3', '2008Q4', '2009Q1' ,'2009Q2']
#quarterlist = ['2001Q1', '2001Q2', '2001Q3' ,'2001Q4']
forecastHorizon = 1
scenario = 's1'

sources=[ 'QPM08','CMR14', 'DNGS15', 'IN10', 'KR15_FF','KR15_HH', 'NKBGG',
            'DS04','FRBEDO08','FU20','GSW12','SW07','WW11',]
SquareError = np.zeros((0,len(sources)))
row_tmp = []
for quater_ind, quarter in enumerate(quarterlist):
    actualGDP = actual[quarter][:forecastHorizon]
    row_tmp = []
    for ind_tmp, model_name_tmp in enumerate(sources):
        nowcast = dsge[quarter+scenario][model_name_tmp][1:forecastHorizon+1]
        sqerr = np.sum((np.asarray(nowcast)-np.asarray(actualGDP))**2)
        row_tmp = row_tmp + [sqerr]
    #print(row_tmp)
    SquareError = np.vstack((SquareError,row_tmp))
    
SquareError = pd.DataFrame(SquareError, columns=sources)
sum_sq = SquareError.sum(axis = 0)


print(sum_sq.sort_values( axis=0, ascending=True))
print(sum_sq)