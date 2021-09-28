# -*- coding: utf-8 -*-
"""
Created on Tue Sep 28 12:04:01 2021

@author: zexi
"""

# %%html
# <style> .container {width:95%} .CodeMirror {font-family: Menlo; font-size: 9pt} .output {font-size: 9pt} </style>


import json
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib as mpl

# hyper parameters
##
scenarioStrings = {
  's1': 'Balanced panel',
  's2': 'Cond. on SPF nowcast',
  's3': 'Cond. on current-quarter data',
  's4': 'Full conditioning',
};

sourceColors = {
    'Pre-crisis': 'blue',
    'Post-crisis': 'red',
    'GLP': 'green',
    'Actual': 'black',
    'SPFMean': 'saddlebrown',
    'SPFIndividual': 'grey',
}

sourceWidths = {
    'Actual': 3,
    'SPFMean': 3,
    'SPFIndividual': 1,
    'Post-crisis models avg': 3,
    'Pre-crisis models avg': 3,
    'Pre-crisis': 1.2, # class of models
    'Post-crisis': 1.2, # class of models
    'GLP': 1.5, # class of models
    'CMR14': 2.3 ,
    'IN10': 2.3,
    'DNGS15': 2.3, 
    'SW07': 2.3, 
    'GSW12':2.3,
}

topCandidateColors = {
    'CMR14': 'gold',
    'IN10':'aqua',
    'DNGS15': 'purple', 
    'SW07':'violet', 
    'GSW12':'gold',
}

GraphRecessionHorizon = {
    '2001Q1':3,
     '2001Q2':2,
     '2001Q3':1,
     '2001Q4':0,
     '2008Q1':5,
     '2008Q2':4, 
     '2008Q3':3,
     '2008Q4':2, 
     '2009Q1':1, 
     '2009Q2':0,
     '2020Q1':2, 
     '2020Q2':1,
    }

yaxismaxval = {
     '2001Q1':6,
     '2001Q2':6,
     '2001Q3':6,
     '2001Q4':6,
     '2008Q1':6,
     '2008Q2':6, 
     '2008Q3':6,
     '2008Q4':6, 
     '2009Q1':6, 
     '2009Q2':6,
     '2020Q1':35, 
     '2020Q2':35,
     '2020Q3':20,
     '2020Q4':20,}

yaxisminval = {
     '2001Q1':-2,
     '2001Q2':-2,
     '2001Q3':-2,
     '2001Q4':-6,
     '2008Q1':-8,
     '2008Q2':-8, 
     '2008Q3':-8,
     '2008Q4':-8, 
     '2009Q1':-9, 
     '2009Q2':-8,
     '2020Q1':-40, 
     '2020Q2':-90,
     '2020Q3':-20,
     '2020Q4':-20}

nberRecessionQuarters = ['2001Q1', '2001Q2', '2001Q3', '2008Q1', '2008Q2', '2008Q3', '2008Q4', '2009Q1', '2020Q1', '2020Q2',]

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
        
##
def plotForecasts(forecastStartQuarters, sources, topCandidates, scenarios, forecastHorizon,move,GraphGroupType, casenum):
    if casenum ==1:
        forecastStartQuarters=[forecastStartQuarters]       
    elif casenum==2:
        forecastStartQuarters=forecastStartQuarters
    else:
        forecastStartQuarters=[forecastStartQuarters] 
        
    if GraphGroupType == 1:
        fig, axes = plt.subplots(len(scenarios), len(forecastStartQuarters), squeeze=False, sharex=False, sharey=False, figsize=(5*len(forecastStartQuarters),5))
    elif GraphGroupType== 2:
        fig, axes = plt.subplots(len(forecastStartQuarters), len(scenarios), squeeze=False, sharex=False, sharey=False, figsize=(16,9*len(forecastStartQuarters)))
    else:
        fig, axes = plt.subplots(len(scenarios), len(forecastStartQuarters), squeeze=False, sharex=False, sharey=False, figsize=(5*len(forecastStartQuarters),5))
    FirstQuarter = forecastStartQuarters[0]
    firstGraphRecHoriz = GraphRecessionHorizon[FirstQuarter]
    maxval_vec=[]
    minval_vec=[]
    for q_tmp, quarter_tmp in enumerate(forecastStartQuarters):
        maxval_vec.append(yaxismaxval[quarter_tmp])
        minval_vec.append(yaxisminval[quarter_tmp])
    minval=min(minval_vec)
    maxval=max(maxval_vec)
    
        
    for s, scenario in enumerate(scenarios):
        for q, quarter in enumerate(forecastStartQuarters):
            if GraphGroupType ==1:
                ax = axes[s, q]
            elif GraphGroupType==2:
                ax = axes[q, s]
            else: 
                ax = axes[s, q]

                
            # actual GDP
            gdpLastQuarter = external[quarter]['SPFMean'][0]
            if len(actual[quarter][:forecastHorizon])<forecastHorizon:
                actualGDPplot = actual[quarter][:forecastHorizon]#.append(NaN_fill)
                actualGDPplot = np.append(actualGDPplot, np.repeat(np.nan, forecastHorizon-len(actual[quarter][:forecastHorizon])))
                actualGDPplot=actualGDPplot.tolist()

            else:
                 actualGDPplot = actual[quarter][:forecastHorizon]

            #ax.plot(range(forecastHorizon+1), [gdpLastQuarter] + actual[quarter][:forecastHorizon], label='Actual', color=sourceColors['Actual'], linewidth=sourceWidths['Actual'])
            ax.plot(range(forecastHorizon+1), [gdpLastQuarter] + actualGDPplot, label='Actual', color=sourceColors['Actual'], linewidth=sourceWidths['Actual'])
            if move==True:
                ax.fill_between([0,firstGraphRecHoriz-q], minval, maxval, color='grey', alpha=0.1)
                    
            
            # SPF data
            SPFIndividualLegend = False
            if 'SPFIndividual' in sources:
                for key, value in external[quarter].items():
                    if 'SPFIndividual' in key:
                        if SPFIndividualLegend == False:
                            ax.plot(range(forecastHorizon+1), external[quarter][key][:forecastHorizon+1], label='SPFIndividual', color=sourceColors['SPFIndividual'], linewidth=sourceWidths['SPFIndividual'], alpha=0.3)
                            SPFIndividualLegend = True
                        else:
                            ax.plot(range(forecastHorizon+1), external[quarter][key][:forecastHorizon+1], color=sourceColors['SPFIndividual'], linewidth=sourceWidths['SPFIndividual'], alpha=0.3)
                        
            if 'SPFMean' in sources:
                ax.plot(range(forecastHorizon+1), external[quarter]['SPFMean'][:forecastHorizon+1], label='SPFMean', color=sourceColors['SPFMean'], linewidth=sourceWidths['SPFMean'])
            
            # GLP
            for source in sources:
                if 'GLP' in source:
                    ax.plot(range(forecastHorizon+1), ts[quarter+scenario][source][:forecastHorizon+1], label=source, color=sourceColors['GLP'], linewidth=sourceWidths['GLP'])
            
            # All other sources
            for source in set(sources).difference({'SPFIndividual', 'SPFMean', 'GLP3v', 'GLP5v', 'GLP8v'}):
                width, color = '', ''
                
                if source in sourceWidths.keys():
                    width = sourceWidths[source]
                else:
                    width = sourceWidths[modelClasses[source]]
    
                if source in topCandidates:
                    color = topCandidateColors[source]
                else:
                    color = sourceColors[modelClasses[source]]
    
                ax.plot(range(forecastHorizon+1), dsge[quarter+scenario][source][:forecastHorizon+1], label=source, color=color, linewidth=width)
            
            # styling
            #ax.set_title(f'{quarter}, {scenarioStrings[scenario]}', fontsize=14)
            ax.set_title(f'{quarter}\n {scenarioStrings[scenario]}', fontsize=14)
            ax.set_xlim([0, forecastHorizon])
            ax.set_ylim([minval, maxval])
            if move ==False:
                ax.fill_between([0,firstGraphRecHoriz], minval, maxval, color='grey', alpha=0.1)
            ax.spines['top'].set_color('grey')
            ax.spines['bottom'].set_color('grey')
            ax.spines['left'].set_color('grey')
            ax.spines['right'].set_color('grey')
            ax.grid()
            
            # horizontal axis labels
            index = quarters.index(quarter[2:]) - 1
            ax.set_xticklabels(quarters[index:index+forecastHorizon+1])
                        
    # legend
    if GraphGroupType ==1:
        ax.legend(loc='upper center', bbox_to_anchor=(-1.3, 1.3), ncol=len(sources)+2, fancybox=False, shadow=False)
    elif GraphGroupType ==2:
        ax.legend(ncol=len(sources) // 2 + 1, bbox_to_anchor=(0.5, 1.2))
    else:
        ax.legend(loc='upper center', bbox_to_anchor=(-1.3, 1.3), ncol=len(sources)+2, fancybox=False, shadow=False)

    #
    #ax.legend(loc='upper center', ncol=6, fancybox=False, shadow=False)


    
    fig.tight_layout()
    plt.subplots_adjust(wspace=0.3, hspace=0.5)
    return fig, axes

mpl.rcParams['font.family'] = 'Arial'
mpl.rcParams['font.size'] = 14


## Plot
case_ind =2  # case 1 -> s1 s3 for every yearquarter
             # case 2 -> s1 for 4 periods
## case 1
if case_ind ==1:
    forecastQuartersList=['2001Q1', '2001Q2', '2001Q3', '2001Q4','2008Q3', '2008Q4', '2009Q1', '2009Q2', '2020Q1', '2020Q2', '2020Q3', '2020Q4']
    #forecastQuartersList=['2001Q1', '2001Q2', '2001Q3', '2001Q4','2008Q3', '2008Q4', '2009Q1', '2009Q2', '2020Q1']
    #forecastQuartersList=[ '2020Q2', '2020Q3', '2020Q4']
    for ind_tmp, indname_tmp in enumerate(forecastQuartersList):
        a, _ = plotForecasts(forecastStartQuarters=indname_tmp, 
                             sources=[  'SPFIndividual', 'SPFMean',
                                      'CMR14', 'DNGS15', 'IN10', 'KR15_FF','KR15_HH', 'NKBGG','QPM08',
                                      #'DS04','FRBEDO08','FU20','GSW12','SW07','WW11',
                                      #'Fair', # Fair model not available for 2020Q2
                                      #'SW07', 'DS04', 'GLP3v', 'GLP8v',
                                      #'Post-crisis models avg', 'Pre-crisis models avg'
                                      ], 
                             topCandidates = ['SW07','GSW12',
                                              'CMR14', 'DNGS15', 'IN10',],
                             scenarios=['s1','s3'],
                             forecastHorizon=5, move=False, GraphGroupType = 2, casenum = case_ind)
    #nberRecessionQuarters = ['2001Q1', '2001Q2', '2001Q3', 
    #                            '2008Q1', '2008Q2', '2008Q3', '2008Q4', '2009Q1', 
    #                          '2020Q1', '2020Q2',]
    #a.savefig('aa.svg')
        nametag = 'post'+indname_tmp + '.png'
    
        a.savefig(nametag, bbox_inches='tight')

if case_ind==2:
    forecastQuartersDict = {
                             '20012002': ['2001Q1', '2001Q2', '2001Q3', '2001Q4'],
                             '20082009':['2008Q3', '2008Q4', '2009Q1', '2009Q2'],    
                             '20202021':[ '2020Q1', '2020Q2','2020Q3','2020Q4'],
                             }
    
    forecastQuarterskey=['20012002','20082009','20202021']
    
    for period_tmp,  periodname_tmp in enumerate(forecastQuarterskey):
        forecastQuartersList = forecastQuartersDict[periodname_tmp]
    
        a, _ = plotForecasts(forecastStartQuarters=forecastQuartersList, 
                      sources=[  'SPFIndividual', 'SPFMean',
                               #'CMR14', 'DNGS15', 'IN10', 'KR15_FF','KR15_HH', 'NKBGG','QPM08',
                               #'DS04','FRBEDO08','FU20','GSW12','SW07','WW11',
                               #'Fair', # Fair model not available for 2020Q2
                                'DNGS15', 'GLP8v',
                               #'Post-crisis models avg', 'Pre-crisis models avg'
                               ], 
                      topCandidates = ['SW07','GSW12',
                                       'CMR14', 'DNGS15', 'IN10',],
                      scenarios=['s1'],
                      forecastHorizon=5, move=True, GraphGroupType = 1, casenum = case_ind)
         #nberRecessionQuarters = ['2001Q1', '2001Q2', '2001Q3', 
         #                            '2008Q1', '2008Q2', '2008Q3', '2008Q4', '2009Q1', 
         #                          '2020Q1', '2020Q2',]
         #a.savefig('aa.svg')
        nametag = 'struct'+periodname_tmp + '.png'
         
        a.savefig(nametag, bbox_inches='tight')
    


# Pre-crisis models默認藍色，Post-crisis models默認紅色
# 如果對某些model需要不一樣的顏色，則需要在topCandidates中添加model names，並且在topCandidateColors中設定這些models的顏色
# 在一行四個charts的排列下，Legend的位置是合適的，但如果改變每行charts的數目，則Legend的位置會不再合適，需要調整“bbox_to_anchor=(0.6, 1.3)”的參數
# 保存圖片為svg格式，也就是可以放大不失真的矢量圖