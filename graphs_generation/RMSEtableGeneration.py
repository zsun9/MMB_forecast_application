# -*- coding: utf-8 -*-
"""
Created on Mon Jul  4 12:06:53 2022

@author: kaliu
"""

import json
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib as mpl
import pathlib
import os 
import math


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

quarterlist = ['2020Q1', '2020Q2', '2020Q3' ,'2020Q4']
#quarterlist = ['2008Q3', '2008Q4', '2009Q1' ,'2009Q2']
#quarterlist = ['2001Q2']
#quarterlist = ['2001Q1', '2001Q2', '2001Q3' ,'2001Q4']
forecastHorizonlist = [ 0, 1, 2, 3, 4]
scenariolist = ['s1' , 's3']

DSGEsources=[  
           'SW07', 'DS04', 'WW11' , 'FU20' , 'GSW12' , 'FRBEDO08' ,   #'Fair',
           'NKBGG', 'QPM08', 'DNGS15', 'CMR14' , 'KR15_FF' , 'KR15_HH' ,
           'IN10', 
            ]
#TSsource = ['GLP3v', 'GLP5v' , 'GLP8v']
TSsource=[]
sourcePspf = DSGEsources  + TSsource + ['SPFMean']
SquareError = np.zeros((0,len(sourcePspf)))
SquareErrorWsenario = []

row_tmp = []
for horizonlist_ind, forecastHorizon in enumerate(forecastHorizonlist):

    for scenariolist_ind, scenario in enumerate(scenariolist):
        SquareError = np.zeros((0,len(sourcePspf)))
    
        for quater_ind, quarter in enumerate(quarterlist):
            actualGDP = actual[quarter][0+forecastHorizon:0+forecastHorizon+1]
            dsge_row_tmp = []
            ts_row_tmp = []
            spf_tmp = []
            for ind_tmp, model_name_tmp in enumerate(DSGEsources):
                nowcast = dsge[quarter+scenario][model_name_tmp][1+forecastHorizon:1+forecastHorizon+1]
                sqerr = np.sum((np.asarray(nowcast)-np.asarray(actualGDP))**2) 
                dsge_row_tmp = dsge_row_tmp + [sqerr]
                
            for ind_tmp, model_name_tmp in enumerate(TSsource):
                nowcast = ts[quarter+scenario][model_name_tmp][1+forecastHorizon:1+forecastHorizon+1]
                sqerr = np.sum((np.asarray(nowcast)-np.asarray(actualGDP))**2) 
                ts_row_tmp = ts_row_tmp + [sqerr]
            spf_nowcast = external[quarter]['SPFMean'][1+forecastHorizon:1+forecastHorizon+1]
            sqerr_spf = np.sum((np.asarray(spf_nowcast)-np.asarray(actualGDP))**2)
            #sqerr_spf = math.sqrt(sqerr_spf)
            spf_tmp = spf_tmp + [sqerr_spf]
        
            #print(row_tmp)
            SquareError = np.vstack((SquareError,dsge_row_tmp +ts_row_tmp + spf_tmp))
     #   SquareErrorWsenario = np.concatenate((SquareErrorWsenario, SquareError))
       # SquareErrorWsenario = 
    
        
        SquareError = pd.DataFrame(SquareError, columns=sourcePspf)
        sum_sq = SquareError.sum(axis = 0)
        sum_sq = sum_sq/4
        eqerror_tab = np.sqrt(sum_sq)
        spf_rmse_tmp = np.sum(eqerror_tab.tail(1))
        eqerror_tab_rel = eqerror_tab/spf_rmse_tmp
        eqerror_tab_rel[len(eqerror_tab_rel)-1:len(eqerror_tab_rel)] = spf_rmse_tmp
    
        
        if scenariolist_ind == 0:
            SquareErrorTable=eqerror_tab_rel
        else:
            SquareErrorTable = pd.concat([SquareErrorTable,eqerror_tab_rel], axis = 1)
    
    
    FinalTable_tmp = [None]*(len(SquareErrorTable)+len(SquareErrorTable))
    FinalTable_tmp[::2] = SquareErrorTable[0]
    FinalTable_tmp[1::2] = SquareErrorTable[1]
    
    Doublesourcename = [None]*(len(sourcePspf)+len(sourcePspf))
    Doublesourcename[::2] = sourcePspf
    Doublesourcename[1::2] = sourcePspf
    
    FinalTable = pd.DataFrame(FinalTable_tmp)
    FinalTable = FinalTable.T
    FinalTable.columns = Doublesourcename

    if horizonlist_ind == 0:
        TableToSave = FinalTable
    else:
        TableToSave = pd.concat([TableToSave, FinalTable], ignore_index=True)
            


TableToSave.to_excel("RMSEoutput.xlsx") 