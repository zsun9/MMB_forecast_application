def main(vintageDate = '', quarterStart = '', quarterEnd = '', raw = [], observed = [], showRawTransform=False, pathExcel = None, onlyS3 = False):

    '''
    Generate vintage data
    
    Arguments:

    1. vintageDate: the vintage date on which the realtime data is observed. Format: 1990-01-01
    2. quarterStart: the first quarter of the observation period. Format: 1990Q1
    3. quarterEnd: the last quarter of the observation period. Format: 1990Q1

    4. raw (list, default=[]): raw variables to be generated, must appear in 'raw_variable_description'
    5. observed (list, default=[]): observed variables to be generated, must appear in 'observed_variable_description'
    6. showRawTransform (boolean, default=False): if True, show raw series that are used to construct observables

    7. pathExcel (string, default=None): file path to store the data, if None, save to 'data' file
    8. onlyS3 (boolean, default=False): if True, only generate data under the third scenario
    '''

    import pathlib, os
    import pandas as pd
    import numpy as np
    import datetime as datetime

    diffBound = 0.015 # max allowed difference (in %) between series with missing values and series to fill missing values
    specificRules = {
        # ('2008-08-07', 'COMPNFB', '2008Q3'): 181.676,
        ('2008-08-07', 'HOANBS', '2008Q3'): '2008-08-08',
        ('2008-08-07', 'IPDNBS', '2008Q3'): '2008-08-08',
        ('2008-08-07', 'COMPNFB', '2008Q3'): '2008-08-08',
        ('2020-08-12', 'PRS85006023', '2020Q3'): '2020-08-14',
        ('2020-08-12', 'HOANBS', '2020Q3'): '2020-08-14',
        ('2020-08-12', 'IPDNBS', '2020Q3'): '2020-08-14',
        ('2020-08-12', 'COMPNFB', '2020Q3'): '2020-08-14',
    }

    # parse arguments
    vintageDate = pd.to_datetime(vintageDate)
    # move one quarter back at the start to generate growth data in the first quarter
    def back_one_quarter(stringQuarter):
        if stringQuarter[-1] == '1':
            return str(int(stringQuarter[0:4])-1) + 'Q4'
        else:
            return stringQuarter[0:5] + str(int(stringQuarter[-1])-1)
    quarterStart = back_one_quarter(quarterStart)

    obsStart = pd.to_datetime(quarterStart).to_period('Q').start_time
    obsEnd = pd.to_datetime(quarterEnd).to_period('Q').end_time
    obsRange = pd.date_range(start=quarterStart, end=quarterEnd, freq='QS').to_period('Q').start_time

    if obsStart > obsEnd:
        return None

    if vintageDate < obsEnd:
        print('Vintage date < End date of last observation quarter, so Last observation date = Vintage date.')
        obsEnd = vintageDate

    variables = {'raw': set(raw), 'transform': set([]), 'observed': set(observed), }

    # set data locations
    pathData = pathlib.Path('../data')
    pathAlfred = pathlib.Path( pathData / 'raw' / 'alfred')
    pathRtdsm = pathlib.Path( pathData / 'raw' / 'rtdsm')
    pathSpf = pathlib.Path( pathData / 'raw' / 'spf')
    pathOthers = pathlib.Path( pathData / 'raw' / 'others')
    assert pathData.exists() and pathAlfred.exists() and pathRtdsm.exists() and pathSpf.exists() and pathOthers.exists()

    # load data information
    os.chdir(pathData)
    infoObs = pd.read_excel('observed_variable_description.xlsx')
    infoRaw = pd.read_csv('raw_variable_description.csv', encoding='utf-8')
    infoFillNowcast = pd.read_excel('fill_nowcast.xlsx')
    infoFillHistory = pd.read_excel('fill_history.xlsx')
    infoSpf = pd.read_csv('spf_dates.csv', encoding='utf-8', index_col=0)

    infoSpf['deadlines'] = pd.to_datetime(infoSpf['deadlines'])

    # find raw variables that construct observed variables and store their names in 'transform'
    dictRawTransform = dict()

    if len(variables['observed']) > 0:

        setRaw = set(file.stem for file in pathAlfred.glob('*.*')).union(set(file.stem for file in pathOthers.glob('*.*')))

        for _, row in infoObs.iterrows():
            if row['id'] in variables['observed']:

                setRawTransform = set()
                for rawVar in setRaw:
                    if rawVar in row['construction'].replace('100', ' ').replace('*', ' ').replace('Δ', ' ').replace('LN', ' ').replace('(', ' ').replace(')', ' ').replace('/', ' ').replace('-', ' ').replace('+', ' ').replace('mean', ' ').split(' '):

                        setRawTransform.update({rawVar})
                        variables['transform'].update({rawVar})
                
                dictRawTransform[row['id']] = setRawTransform
    
    # if showRawTransform = True, show raw variables that are used for constructing observables
    if showRawTransform == True:
        variables['raw'].update(variables['transform'])

    # select desired data from ALFRED/RTDSM
    def desired_data(source, var, df, vintage):

        # return a tuple: (df, actualVintageDate), or (None, None)

        if source in {'alfred', 'others', 'rtdsm'}:

            # convert index to datetime format
            if source in {'alfred', 'others'}:
                df.index = pd.to_datetime(df.index)
            else:
                if 'Q' in df.index[0]:
                    df.index = pd.to_datetime([index.replace(':', '-') for index in df.index])
                else:
                    df.index = pd.to_datetime(df.index, format='%Y:%m')

            # select observation period and convert data from any frequency to quarterly
            obsPeriod = df.index.map(lambda x: obsStart <= x)
            df = df[obsPeriod].copy()
            obsPeriod = df.index.map(lambda x: x <= obsEnd)
            df = df[obsPeriod].copy()
            df['quarter'] = df.index.to_period('Q').values
            df = df.groupby('quarter').mean().copy()
            df = pd.merge(df, pd.DataFrame(index=obsRange.to_period('Q')), how='right', left_index=True, right_index=True)
            if np.sum(np.sum(~np.isnan(df))) == 0:
                return None, None

            # select vintage date
            vintageCol = ''

            if source in {'alfred', 'others'}:

                # for data in daily frequency, choose the only vintage
                if infoRaw[infoRaw['id']==var]['frequency_short'].values[0] == 'D':
                    vintageCol = df.columns.values[-1]
                    actualVintageDate = vintageDate
                else:
                    for column in df.columns.values:
                        columnOriginal = column
                        columnDate = pd.to_datetime(column[-8:], format='%Y%m%d')
                        if vintage >= columnDate:
                            vintageCol = columnOriginal
                            actualVintageDate = columnDate
                        else:
                            break

            else:

                # select vintage date
                for column in df.columns.values:
                    columnOriginal = column
                    column = column.replace(var, '')
                    if column[0] in ['0', '1', '2', '3']:
                        column = '20' + column
                    else:
                        column = '19' + column

                    if 'Q' in column:
                        columnDate = pd.to_datetime(column)
                    else:
                        columnDate = pd.to_datetime(column, format='%YM%m')

                    if vintage >= columnDate:
                        vintageCol = columnOriginal
                        actualVintageDate = columnDate
                    else:
                        break

            # if vintage column found and is not all NaN, then return it
            if vintageCol != '':

                if np.sum(~np.isnan(df[vintageCol].values)) == 0:
                    return None, None
                else:
                    return df.loc[:, df.columns.map(lambda x: x == vintageCol)], actualVintageDate

            # else: if first column is not all NaN, then return it
            else:

                if np.sum(~np.isnan(df.iloc[:,0].values)) == 0:
                    return None, None
                else:
                    print(f'Warning: Exact vintage date for {var} not found, will use its value in the earliest possible vintage date!')
                    df = df.iloc[:,0].copy()
                    try:
                        df = df.to_frame()
                    except:
                        pass
                    # if variable updated quarterly, then remove the last obs
                    if infoRaw[infoRaw['id']==var]['frequency_short'].values[0] == 'Q':
                        df.iloc[-1] = float('nan')
                    # for some variables, even remove the last two obs
                    if var in {'BOGZ1FL144104005Q', 'HMLBSHNO'}:
                        df.iloc[-2] = float('nan')
                    return df, vintage

        else:
            raise Exception(f'Cannot retreive desired data from source {source}.')

    # generate data for raw variables
    def gen_raw_variables(variablesInput):

        dfOutput, dfOutputSpf = pd.DataFrame({}), pd.DataFrame({})

        index = -1

        for variable in variablesInput:

            toMerge = False

            # find data in raw/alfred or raw/others
            for file in set(pathAlfred.glob('*.*')).union(set(pathOthers.glob('*.*'))):

                if file.stem == variable:

                    # retreive desired data
                    try:
                        dfTemp = pd.read_csv(file, index_col=0)
                    except:
                        dfTemp = pd.read_excel(file, index_col=0)

                    # check whether needs to change the vintage date (a trick just for some very specific settings)
                    if (vintageDate.strftime('%Y-%m-%d'), variable, quarterEnd.upper()) in specificRules.keys():
                        dfToMerge, actualVintageDateAlfred = desired_data(source='alfred', var=variable, df=dfTemp, vintage=pd.to_datetime(specificRules[(vintageDate.strftime('%Y-%m-%d'), variable, quarterEnd.upper())]))
                    else:
                        dfToMerge, actualVintageDateAlfred = desired_data(source='alfred', var=variable, df=dfTemp, vintage=vintageDate)

                    # proceed if dfToMerge is not None
                    if dfToMerge is None:
                        print(f'For raw variable {variable}, cannot find value between {quarterStart} and {quarterEnd} at vintage date {vintageDate}.')
                    else:
                        # print(f"Raw variable {variable} retreived, actual vintage date is {actualVintageDateAlfred.strftime('%Y-%m-%d')}")
                        index += 1
                        toMerge = True

                        # fill data under specific rules
                        # if (vintageDate.strftime('%Y-%m-%d'), variable, quarterEnd.upper()) in specificRules.keys():
                        #     dfToMerge.iloc[-1] = specificRules[(vintageDate.strftime('%Y-%m-%d'), variable, quarterEnd.upper())]

                        # if values other than last or second to last are missing
                        if variable in infoFillHistory['alfred'].values and np.sum(np.isnan(dfToMerge.iloc[:-2].values)) > 0:

                            rows = infoFillHistory[infoFillHistory['alfred']==variable]
                            for _, row in rows.iterrows():
                                fillSource, fillVar, fillFilename = row['fillSource'], row['fillVar'], row['fillFilename']

                                if fillSource == 'alfred':
                                    dfToFill = pd.read_csv(pathAlfred / fillFilename, index_col=0)
                                elif fillSource == 'rtdsm':
                                    dfToFill = pd.read_excel(pathRtdsm / fillFilename, index_col=0)
                                else:
                                    raise Exception(f'Cannot identify fill source ({fillSource}), make sure it is alfred or rtdsm')
                                
                                dfToFill, _ = desired_data(source=fillSource, var=fillVar, df=dfToFill, vintage=actualVintageDateAlfred)

                                if dfToFill is None:
                                    print(f'Missing values of {variable} not filled: No corresponding data.')

                                else:
                                    diff = np.sum(np.abs(dfToFill.iloc[:-1,0]/dfToMerge.iloc[:-1,0]-1) > diffBound) # compare two series except the last element

                                    # if all the differences < diffBound
                                    if diff == 0:
                                        for index, (_, row) in enumerate(dfToMerge.iterrows()):
                                            if np.isnan(row.values[0]):
                                                try:
                                                    dfToMerge.iloc[index, 0] = dfToFill.iloc[index, 0]
                                                except:
                                                    pass
                                        print(f'Missing values of {variable} filled by {fillVar} from {fillSource}.')

                                    # if only one difference < diffBound, and it is the last one
                                    elif diff <= 2 and np.sum(np.abs(dfToFill.iloc[:-3,0]/dfToMerge.iloc[:-3,0]-1) > diffBound) == 0:
                                        lastDiff = np.max(np.abs(dfToFill.iloc[:-1,0]/dfToMerge.iloc[:-1,0]-1))
                                        for index, (_, row) in enumerate(dfToMerge.iterrows()):
                                            if np.isnan(row.values[0]):
                                                try:
                                                    dfToMerge.iloc[index, 0] = dfToFill.iloc[index, 0]
                                                except:
                                                    pass
                                        print(f'Missing values of {variable} filled by {fillVar} from {fillSource}, even though the diff between the last two elements > {diffBound:.2%}.')
                                    
                                    # other cases
                                    else:
                                        dfToMerge = pd.merge(dfToMerge, dfToFill, how='outer', left_index=True, right_index=True, sort=True)
                                        dfToMerge.to_csv(f'diff_{variable}_{fillVar}.csv')
                                        print(f'Missing values of {variable} not filled: Diff between series to be filled and series to fill > {diffBound:.2%}, will print two series.')

                        # create a df to store SPF data
                        dfToMergeSpf = dfToMerge.copy()
                        dfToMergeSpf.iloc[-1] = float('nan')
                        if variable in infoFillNowcast['alfred'].values:
                            
                            # **for now, only consider SPF values when (1) vintageDate at SPF deadline (2) quarter vintageDate = quarter obsEnd
                            if np.sum(infoSpf['deadlines'] == vintageDate) == 1 and obsEnd.to_period('Q') == vintageDate.to_period('Q'):
                                
                                variableNowcast = infoFillNowcast[infoFillNowcast['alfred']==variable]['fillVar'].values[0]
                                dataSpf = pd.read_excel(pathSpf / 'meanLevel.xls', sheet_name=variableNowcast, engine='xlrd')

                                row = dataSpf[dataSpf.apply(lambda x: x['YEAR'] == vintageDate.year and x['QUARTER'] == vintageDate.quarter, axis=1)]
                                if np.sum(np.sum(~np.isnan(row))) == 0:
                                    print(f'SPF value of {variable} not filled: no SPF value for the last quarter.')
                                else:
                                    # for most variables, one just needs to find the corresponding value in SPF
                                    # but for CPIAUCSL, the corresponding CPI is annualized growth in %, needs to be changed to non-annualized level
                                    if variable != 'CPIAUCSL':
                                        diff = np.abs(row[variableNowcast+'1'].values[0]/dfToMerge.iloc[-2,0] - 1)
                                    else:
                                        impliedCPILevel = (row[variableNowcast+'1'].values[0]/400 + 1)*dfToMerge.iloc[-3,0]
                                        diff = np.abs(impliedCPILevel/dfToMerge.iloc[-2,0] - 1)
                                    
                                    if diff <= diffBound:
                                        if variable != 'CPIAUCSL':
                                            dfToMergeSpf.iloc[-1,0] = row[variableNowcast+'2'].values[0]
                                        else:
                                            dfToMergeSpf.iloc[-1,0] = (row[variableNowcast+'2'].values[0]/400 + 1)*dfToMerge.iloc[-2,0]
                                        print(f'SPF value of {variable} filled by {variableNowcast}.')
                                    else:
                                        print(f'SPF values of {variable} not filled: Diff between second to last quarter actual value in ALFRED and SPF > {diffBound:.2%}')
                                        print(f"Variable: {variable}, Second to last quarter: {str(dfToMerge.index[-2])}, ALFRED value: {dfToMerge.iloc[-2,0]}, SPF value: {row[variableNowcast+'1'].values[0]}")
                            
                            else:
                                print(f'SPF value of {variable} not filled: vintageDate is not a SPF deadline.')

                    break

            if toMerge == True:
                if index == 0:
                    dfOutput = dfToMerge.copy()
                    dfOutputSpf = dfToMergeSpf.copy()
                else:
                    dfOutput = pd.merge(dfOutput, dfToMerge, how='outer', left_index=True, right_index=True, sort=True)
                    dfOutputSpf = pd.merge(dfOutputSpf, dfToMergeSpf, how='outer', left_index=True, right_index=True, sort=True)
        
        return dfOutput, dfOutputSpf

    dfRaw, dfRawSpf = gen_raw_variables(variables['raw'])
    dfTransform, dfTransformSpf = gen_raw_variables(variables['transform'])

    # correspondence: variable name : column name (e.g., 'GDPC1':'GDPC1_20010101')
    dictVC = dict()
    
    for column in dfTransform.columns.values:
        if column[-8:].isdigit():
            dictVC[column[:-9]] = column
        else:
            dictVC[column] = column

    # generate observed variables: define function
    def construct_observables(df, d):

        for obs in variables['observed']:

            if obs == 'gdp_rgd_obs':
                # ΔLN(GDPC1)*100
                df.loc[:, obs] = np.log(df[d['GDPC1']]/df[d['GDPC1']].shift())*100

            elif obs == 'gdpdef_obs':
                # ΔLN(GDPCTPI)*100
                df.loc[:, obs] = np.log(df[d['GDPCTPI']]/df[d['GDPCTPI']].shift())*100

            elif obs == 'ffr_obs':
                # DFF/4
                df.loc[:, obs] = df[d['DFF']]/4

            elif obs == 'ifi_rgd_obs':
                # ΔLN(FPI/GDPCTPI)*100
                df.loc[:, obs] = np.log((df[d['FPI']]/df[d['GDPCTPI']])/(df[d['FPI']].shift()/df[d['GDPCTPI']].shift()))*100

            elif obs == 'c_rgd_obs':
                # ΔLN(PCE/GDPCTPI)*100
                df.loc[:, obs] = np.log((df[d['PCE']]/df[d['GDPCTPI']])/(df[d['PCE']].shift()/df[d['GDPCTPI']].shift()))*100

            elif obs == 'wage_rgd_obs':
                # ΔLN(COMPNFB/GDPCTPI)*100
                df.loc[:, obs] = np.log((df[d['COMPNFB']]/df[d['GDPCTPI']])/(df[d['COMPNFB']].shift()/df[d['GDPCTPI']].shift()))*100

            elif obs == 'baag10_obs':
                # (DBAA-DGS10)/4
                df.loc[:, obs] = (df[d['DBAA']] - df[d['DGS10']])/4

            elif obs == 'hours_dngs15_obs':
                # LN(AWHNONAG*CE16OV/100/(CNP16OV/3))*100
                df.loc[:, obs] = np.log(df[d['AWHNONAG']]*df[d['CE16OV']]/100/(df[d['CNP16OV']]/3))*100

            elif obs == 'hours_sw07_obs':
                # Subtracted by mean: LN(PRS85006023*(CE16OV/118753)/(CNP16OV/193024.333333333))*100
                df.loc[:, obs] = np.log(df[d['PRS85006023']]*(df[d['CE16OV']]/118753)/(df[d['CNP16OV']]/193024.333333333))*100
                df.loc[:, obs] = df.loc[:, obs] - df.loc[:, obs][:-1].mean()

            elif obs == 'blt_obs':
                # BLT
                df.loc[:, obs] = df[d['BLT']]

            elif obs == 'unr_obs':
                # UNRATE
                df.loc[:, obs] = df[d['UNRATE']]

            elif obs == 'gdpl_rgd_obs':
                # LN(GDPC1)*100
                df.loc[:, obs] = np.log(df[d['GDPC1']])*100

            elif obs == 'cpil_obs':
                # LN(CPIAUCSL)*100
                df.loc[:, obs] = np.log(df[d['CPIAUCSL']])*100

            elif obs == 'cnds_nom_obs':
                # ΔLN(PCEND+PCES)*100
                df.loc[:, obs] = np.log((df[d['PCEND']]+df[d['PCES']])/(df[d['PCEND']].shift()+df[d['PCES']].shift()))*100

            elif obs == 'cd_nom_obs':
                # ΔLN(PCEDG)*100
                df.loc[:, obs] = np.log(df[d['PCEDG']]/df[d['PCEDG']].shift())*100

            elif obs == 'ir_nom_obs':
                # ΔLN(PRFI)*100
                df.loc[:, obs] = np.log(df[d['PRFI']]/df[d['PRFI']].shift())*100
                df.iloc[-1, -1] = np.log(df[d['PRFIC1']].values[-1]*df[d['GDPCTPI']].values[-1]/df[d['PRFIC1']].values[-2]/df[d['GDPCTPI']].values[-2])*100

            elif obs == 'inr_nom_obs':
                # ΔLN(PNFI)*100
                df.loc[:, obs] = np.log(df[d['PNFI']]/df[d['PNFI']].shift())*100
                df.iloc[-1, -1] = np.log(df[d['PNFIC1']].values[-1]*df[d['GDPCTPI']].values[-1]/df[d['PNFIC1']].values[-2]/df[d['GDPCTPI']].values[-2])*100

            elif obs == 'cnds_def_obs':
                # ΔLN((PCEND+PCES)/(PCENDC96+PCESC96))*100
                df.loc[:, obs] = np.log(((df[d['PCEND']]+df[d['PCES']])/(df[d['PCENDC96']]+df[d['PCESC96']]))/((df[d['PCEND']].shift()+df[d['PCES']].shift())/(df[d['PCENDC96']].shift()+df[d['PCESC96']].shift())))*100

            elif obs == 'cd_def_obs':
                # ΔLN(DDURRD3Q086SBEA)*100
                df.loc[:, obs] = np.log((df[d['PCEDG']]/df[d['PCEDGC96']])/(df[d['PCEDG']].shift()/df[d['PCEDGC96']].shift()))*100

            elif obs == 'hours_frbedo08_obs':
                # Divided by mean: AWHNONAG*CE16OV/CNP16OV
                df.loc[:, obs] = df[d['AWHNONAG']]*df[d['CE16OV']]/df[d['CNP16OV']]
                df.loc[:, obs] = df.loc[:, obs] / df.loc[:, obs][:-1].mean()

            elif obs == 'bbb1yffr_obs':
                # (C0091Y-DFF)/4
                df.loc[:, obs] = (df[d['C0091Y']] - df[d['DFF']])/4

            elif obs == 'hp_nom_obs':
                # ΔLN(CBHPI)*100
                df.loc[:, obs] = np.log(df[d['CBHPI']]/df[d['CBHPI']].shift())*100

            elif obs == 'credit_nom_obs':
                # ΔLN(BOGZ1FL144104005Q)*100
                df.loc[:, obs] = np.log(df[d['BOGZ1FL144104005Q']]/df[d['BOGZ1FL144104005Q']].shift())*100

            elif obs == 'mortffr_obs':
                # (MORTRATE-DFF)/4
                df.loc[:, obs] = (df[d['MORTRATE']] - df[d['DFF']])/4
            
            elif obs == 'mortgage_nom_obs':
                # ΔLN(HMLBSHNO)*100
                df.loc[:, obs] = np.log(df[d['HMLBSHNO']]/df[d['HMLBSHNO']].shift())*100

            elif obs == 'hours_kr15_obs':
                # LN(12*PRS85006023*CE16OV/CNP16OV)*100
                df.loc[:, obs] = np.log(12*df[d['PRS85006023']]*df[d['CE16OV']]/df[d['CNP16OV']])*100

            elif obs == 'g10ffr_obs':
                # (DGS10-DFF)/4
                df.loc[:, obs] = (df[d['DGS10']] - df[d['DFF']])/4

            elif obs == 'networth_rgd_obs':
                # ΔLN(WILL5000IND/GDPCTPI)*100
                df.loc[:, obs] = np.log((df[d['WILL5000IND']]/df[d['GDPCTPI']])/(df[d['WILL5000IND']].shift()/df[d['GDPCTPI']].shift()))*100

            elif obs == 'networth_rgd_cmr14_obs':
                # Subtract by mean and then take exponential: ΔLN(WILL5000IND/GDPCTPI)*100
                df.loc[:, obs] = np.log((df[d['WILL5000IND']]/df[d['GDPCTPI']])/(df[d['WILL5000IND']].shift()/df[d['GDPCTPI']].shift()))*100
                df.loc[:, obs] = df.loc[:, obs] - df.loc[:, obs][:-1].mean()
                df.loc[:, obs] = np.exp(df.loc[:, obs]/100)
                
            elif obs == 'hours_cmr14_obs':
                # LN(HOANBS/CNP16OV)
                df.loc[:, obs] = np.log(df[d['HOANBS']]/(df[d['CNP16OV']]))*100

            elif obs == 'credit_rgd_obs':
                # ΔLN(BOGZ1FL144104005Q/GDPCTPI)*100
                df.loc[:, obs] = np.log((df[d['BOGZ1FL144104005Q']]/df[d['GDPCTPI']])/(df[d['BOGZ1FL144104005Q']].shift()/df[d['GDPCTPI']].shift()))*100

            elif obs == 'cnds_rim_obs':
                # ΔLN(PCESC96+PCENDC96)*100
                df.loc[:, obs] = np.log((df[d['PCESC96']]+df[d['PCENDC96']])/(df[d['PCESC96']].shift()+df[d['PCENDC96']].shift()))*100
            
            elif obs == 'igid_rim_obs':
                # ΔLN(PCEDGC96+GPDIC1)*100
                df.loc[:, obs] = np.log((df[d['PCEDGC96']]+df[d['GPDIC1']])/(df[d['PCEDGC96']].shift()+df[d['GPDIC1']].shift()))*100

            elif obs == 'igiddef_rgd_obs':
                # ΔLN(((GPDI+PCEDG)/(GPDIC1+PCEDGC96))/GDPCTPI)*100
                df.loc[:, obs] = np.log(((df[d['GPDI']]+df[d['PCEDG']])/(df[d['GPDIC1']]+df[d['PCEDGC96']])/df[d['GDPCTPI']])/((df[d['GPDI']].shift()+df[d['PCEDG']].shift())/(df[d['GPDIC1']].shift()+df[d['PCEDGC96']].shift())/df[d['GDPCTPI']].shift()))*100

            elif obs == 'emp_obs':
                # ΔLN(CE16OV)*100
                df.loc[:, obs] = np.log(df[d['CE16OV']]/df[d['CE16OV']].shift())*100
 







            elif obs == 'gdpnoexp_obs':
                # demean: ΔLN((GDP-NETEXP)/GDPCTPI)*100
                df.loc[:, obs] = np.log(((df[d['GDP']]-df[d['NETEXP']])/df[d['GDPCTPI']])/((df[d['GDP']].shift()-df[d['NETEXP']].shift())/df[d['GDPCTPI']].shift()))*100 
                df.loc[:, obs] = df.loc[:, obs] - df.loc[:, obs][:-1].mean()
            
            elif obs == 'i_A16_obs':
                # demean: ΔLN(GPDI+PCDG)*100
                df.loc[:, obs] = np.log((df[d['GPDI']]+df[d['PCDG']])/(df[d['GPDI']].shift()+df[d['PCDG']].shift()))*100
                df.loc[:, obs] = df.loc[:, obs] - df.loc[:, obs][:-1].mean()

            elif obs == 'hours_A16_obs':
                # (demean: LN(TOTLQ*100/CLF16OV))*100
                df.loc[:, obs] = np.log(((df[d['TOTLQ']])*100/df[d['CNP16OV']]))
                df.loc[:, obs] = (df.loc[:, obs] - df.loc[:, obs][:-1].mean())*100
                
            
            elif obs == 'fgs_obs':
                # LN(FGS)
                df.loc[:, obs] =np.log(df[d['FGS']])

            elif obs == 'wage_rgd_demean_obs':
                # demean:ΔLN(COMPNFB/GDPCTPI)*100
                df.loc[:, obs] = np.log((df[d['COMPNFB']]/df[d['GDPCTPI']])/(df[d['COMPNFB']].shift()/df[d['GDPCTPI']].shift()))*100
                df.loc[:, obs] = df.loc[:, obs] - df.loc[:, obs][:-1].mean()
 
            
            elif obs == 'cnds_nom_demean_obs':
                # demean:ΔLN(PCEND+PCES)*100
                df.loc[:, obs] = np.log((df[d['PCEND']]+df[d['PCES']])/(df[d['PCEND']].shift()+df[d['PCES']].shift()))*100
                df.loc[:, obs] = df.loc[:, obs] - df.loc[:, obs][:-1].mean()
            
            
            elif obs == 'rc_obs': 
            # LN(PCEC96/CNP16OV) - first value of LN(PCEC96/CNP16OV)  # note: equivalant of the second value of the vector here as extra previous period value is drawn
                df.loc[:, obs] = np.log(df[d['PCEC96']].values/df[d['CNP16OV']].values) - np.log(df[d['PCEC96']].values/df[d['CNP16OV']].values)[1]

            
            elif obs == 'pi_dm_obs':
           # ΔLN(IPDNBS) - mean ΔLN(IPDNBS)
                df.loc[:, obs] = np.log(df[d['IPDNBS']].values)- np.log(df[d['IPDNBS']].shift().values) - np.nanmean(np.log(df[d['IPDNBS']].values)- np.log(df[d['IPDNBS']].shift().values))
                
            elif obs == 'rri_obs':   
            # LN(PRFIC1/CNP160V) - first value of LN(PRFIC1/CNP16OV)   # note: equivalant to 2nd value
                df.loc[:, obs] = np.log(df[d['PRFIC1']].values/df[d['CNP16OV']].values) - np.log(df[d['PRFIC1']].values/df[d['CNP16OV']].values)[1]
                                                                                                                         
            elif obs == 'rbi_obs':  
            # LN(PNFIC1/CNP160V) - first value of LN(PNFIC1/CNP16OV)  # note: equivalant to 2nd value
                df.loc[:, obs] = np.log(df[d['PNFIC1']].values/df[d['CNP16OV']].values) - np.log(df[d['PNFIC1']].values/df[d['CNP16OV']].values)[1]                                                                                                                                                                                                                                  
          
            elif obs == 'hwc_pd_obs':
            # LN((PAYEMS-USCONS)*AWHMAN/CNP16OV) - mean(LN((PAYEMS-USCONS)*AWHMAN/CNP16OV))
                df.loc[:, obs] = np.log((df[d['PAYEMS']].values-df[d['USCONS']].values)*df[d['AWHMAN']].values/df[d['CNP16OV']].values) - np.nanmean(np.log((df[d['PAYEMS']].values - df[d['USCONS']].values)*df[d['AWHMAN']].values/df[d['CNP16OV']].values)[1:-1])                                                           
                                            
            elif obs == 'hwr_pd_obs':
            # LN(USCONS*CES2000000007/CNP16OV) - mean(LN(USCONS*CES2000000007/CNP16OV))
                df.loc[:, obs] = np.log(df[d['USCONS']].values*df[d['CES2000000007']].values/df[d['CNP16OV']].values) - np.nanmean(np.log(df[d['USCONS']].values*df[d['CES2000000007']].values/df[d['CNP16OV']].values)[1:-1])                                                                                                                         
                 
            elif obs == 'hp_r_obs':
            # LN(CBHPI/IPDNBS) - first observation of LN(CBHPI/IPDNBS)
                df.loc[:, obs] = np.log(df[d['CBHPI']].values/df[d['IPDNBS']].values) - np.log(df[d['CBHPI']].values/df[d['IPDNBS']].values)[1]  
        
            elif obs == 'i_nom_obs':
           # TB3MS/400 - mean (TB3MS/400)
           #     df.loc[:, obs] = df[d['TB3MS']].values/400 - np.nanmean(df[d['TB3MS']][1:-1].values/400)       
                df.loc[:, obs] = df[d['DTB3']].values/400 - np.nanmean(df[d['DTB3']][1:-1].values/400)   

            elif obs == 'c_winf_obs':  
           # ΔLN(AHETPI) - mean(ΔLN(AHETPI))
                df.loc[:, obs] = np.log(df[d['AHETPI']].values) -  np.log(df[d['AHETPI']].shift().values) - np.nanmean(np.log(df[d['AHETPI']].values)[1:-1] -  np.log(df[d['AHETPI']].shift().values)[1:-1])     
                                                                                                
            elif obs == 'h_winf_obs':
           # ΔLN(CES2000000008) - mean(ΔLN(CES2000000008))
                df.loc[:, obs] = np.log(df[d['CES2000000008']].values) -  np.log(df[d['CES2000000008']].shift().values) - np.nanmean(np.log(df[d['CES2000000008']].values)[1:-1] -  np.log(df[d['CES2000000008']].shift().values)[1:-1])     
 
            elif obs == 'c_rpc_obs'  :
            #diff(log((PCND+ PCESV)/(index(GDPCTPI*CNP16OV))))-mean(log((PCND+ PCESV)/(index(GDPCTPI*CNP16OV))))                                                                                                                           
                temp_vec1 =  np.log((df[d['PCND']].values+ df[d['PCESV']].values)/(df[d['GDPCTPI']].values*(df[d['CNP16OV']].values/226959)))    
                temp_vec1 = np.ediff1d(temp_vec1)
                temp_vec1 = np.insert(temp_vec1, 0, 0)
                df.loc[:, obs]= temp_vec1 - np.nanmean(temp_vec1[1:])
 
            elif obs == 'hrw_pc_obs'  :
            #log((PRS85006023* CE16OV)/(index(CNP16OV)))-mean(log((PRS85006023* CE16OV)/(index(CNP16OV))))                                                                                                                           
                temp_vec1 =  np.log((df[d['PRS85006023']].values*df[d['CE16OV']].values)/(df[d['CNP16OV']].values/226959))    
                df.loc[:, obs]= temp_vec1 - np.nanmean(temp_vec1[1:])   
                
            elif obs == 'i_rgpc_obs'  :
            #diff(log((GPDI+ PCDG)/(GDPCTPI*CNP16OV)))-mean(diff(log((GPDI+ PCDG)/(GDPCTPI*CNP16OV))))                                                                                                                           
                temp_vec1 =  np.log((df[d['GPDI']].values+ df[d['PCDG']].values)/(df[d['GDPCTPI']].values*(df[d['CNP16OV']].values/226959)))    
                temp_vec1 = np.ediff1d(temp_vec1)
                temp_vec1 = np.insert(temp_vec1, 0, 0)
                df.loc[:, obs]= temp_vec1 - np.nanmean(temp_vec1[1:])                
                
            elif obs == 'gexp_rgpc_obs'  :
            #X= (A957RC1Q027SBEA + A787RC1Q027SBEA + AD08RC1Q027SBEA - A918RC1Q027SBEA)/(GDPCTPI*CNP16OV)  ,   diff(X)-mean(diff(X))                                                                                                                
                temp_vec1 =  np.log((df[d['A957RC1Q027SBEA']].values+ df[d['A787RC1Q027SBEA']].values+ df[d['AD08RC1Q027SBEA']].values-df[d['A918RC1Q027SBEA']].values)/(df[d['GDPCTPI']].values*(df[d['CNP16OV']].values/226959)))    
                temp_vec1 = np.ediff1d(temp_vec1)
                temp_vec1 = np.insert(temp_vec1, 0, 0)
                df.loc[:, obs]= temp_vec1 - np.nanmean(temp_vec1[1:])               
            
            elif obs == 'tau_w_obs'  :
            # Too complicated, consist of   RENTIN,CPROFIT,W255RC1Q027SBEA,PROPINC,A074RC1Q027SBEA,W071RC1Q027SBEA,WASCUR,PROPINC,COE,W780RC1Q027SBEA                                                                                                       
                temp_vec_CI = df[d['RENTIN']].values + df[d['CPROFIT']].values+df[d['W255RC1Q027SBEA']].values+df[d['PROPINC']].values/2
                temp_vec_tau_w = ((df[d['A074RC1Q027SBEA']].values+df[d['W071RC1Q027SBEA']].values)/(df[d['WASCUR']].values+df[d['PROPINC']].values/2+temp_vec_CI))*((df[d['WASCUR']].values+df[d['PROPINC']].values/2)/(df[d['COE']].values+df[d['PROPINC']].values/2))+df[d['W780RC1Q027SBEA']].values/(df[d['COE']].values+df[d['PROPINC']].values/2)
                temp_vec_tau_w = np.log(temp_vec_tau_w)
                df.loc[:, obs]= temp_vec_tau_w - np.nanmean(temp_vec_tau_w[1:]) 
                
                
            elif obs == 'tau_k_obs'  :
            # Too complicated, consist of   RENTIN,CPROFIT,W255RC1Q027SBEA,PROPINC,A074RC1Q027SBEA,WASCUR,PROPINC,B249RC1Q027SBEA,B075RC1Q027SBEA                                                                                                       
                temp_vec_CI = df[d['RENTIN']].values + df[d['CPROFIT']].values+df[d['W255RC1Q027SBEA']].values+df[d['PROPINC']].values/2
                temp_vec_tau_k = (df[d['A074RC1Q027SBEA']].values/(df[d['WASCUR']].values + df[d['PROPINC']].values/2 + temp_vec_CI))*(temp_vec_CI/(temp_vec_CI + df[d['B249RC1Q027SBEA']].values)) + (df[d['B075RC1Q027SBEA']].values + df[d['B249RC1Q027SBEA']].values)/(temp_vec_CI + df[d['B249RC1Q027SBEA']].values)
                temp_vec_tau_k = np.log(temp_vec_tau_k)
                df.loc[:, obs]= temp_vec_tau_k - np.nanmean(temp_vec_tau_k[1:]) 
                
            elif obs == 'taxrev_rgpc_obs':
                # too complicated, consist of RENTIN-CPROFIT-W255RC1Q027SBEA-PROPINC-A074RC1Q027SBEA-W071RC1Q027SBEA-WASCUR-PROPINC-COE-W780RC1Q027SBEA-B249RC1Q027SBEA-B075RC1Q027SBEA-GDPCTPI-CNP16OV
                temp_vec_CI = df[d['RENTIN']].values + df[d['CPROFIT']].values+df[d['W255RC1Q027SBEA']].values+df[d['PROPINC']].values/2
                temp_vec_tau_w = ((df[d['A074RC1Q027SBEA']].values+df[d['W071RC1Q027SBEA']].values)/(df[d['WASCUR']].values+df[d['PROPINC']].values/2+temp_vec_CI))*((df[d['WASCUR']].values+df[d['PROPINC']].values/2)/(df[d['COE']].values+df[d['PROPINC']].values/2))+df[d['W780RC1Q027SBEA']].values/(df[d['COE']].values+df[d['PROPINC']].values/2)
                temp_vec_tau_k = (df[d['A074RC1Q027SBEA']].values/(df[d['WASCUR']].values + df[d['PROPINC']].values/2 + temp_vec_CI))*(temp_vec_CI/(temp_vec_CI + df[d['B249RC1Q027SBEA']].values)) + (df[d['B075RC1Q027SBEA']].values + df[d['B249RC1Q027SBEA']].values)/(temp_vec_CI + df[d['B249RC1Q027SBEA']].values)
                temp_vec_govtaxrev_nonadj = (temp_vec_tau_w*(df[d['COE']].values + df[d['PROPINC']].values/2) + temp_vec_tau_k*(temp_vec_CI + df[d['B249RC1Q027SBEA']].values))
                temp_vec_govtaxrev=temp_vec_govtaxrev_nonadj /(df[d['GDPCTPI']].values*(df[d['CNP16OV']].values/226959))
                temp_vec_govtaxrev = np.log(temp_vec_govtaxrev)
                temp_vec1 = np.ediff1d(temp_vec_govtaxrev)
                temp_vec1 = np.insert(temp_vec1, 0, 0)
                df.loc[:, obs]= temp_vec1 - np.nanmean(temp_vec1[1:])                 
 

            elif obs == 'inf_ctpi_obs':
                # diff(log(GDPCTPI))-mean(diff(log(GDPCTPI)))
                temp_vec_inf = df[d['GDPCTPI']].values
                temp_vec_inf =  np.log(temp_vec_inf)
                temp_vec1 = np.ediff1d(temp_vec_inf)
                temp_vec1 = np.insert(temp_vec1, 0, 0)
                df.loc[:, obs]= temp_vec1 - np.nanmean(temp_vec1[1:])  
                
            elif obs == 'nom_w_pc_obs':
                temp_vec1 = np.log((df[d['COMPNFB']].values/(df[d['GDPCTPI']].values*(df[d['CNP16OV']].values/226959))))
                temp_vec1 = np.ediff1d(temp_vec1)
                temp_vec1 = np.insert(temp_vec1, 0, 0)
                df.loc[:, obs]= temp_vec1 - np.nanmean(temp_vec1[1:])  
            
            elif obs == 'govdebt_rcpc_obs':
                # too complicated, construct from raw data series RENTIN-CPROFIT-W255RC1Q027SBEA-PROPINC-A074RC1Q027SBEA-W071RC1Q027SBEA-WASCUR-PROPINC-COE-W780RC1Q027SBEA-B249RC1Q027SBEA-B075RC1Q027SBEA-GDPCTPI-CNP16OV-A957RC1Q027SBEA-A787RC1Q027SBEA-AD08RC1Q027SBEA-A918RC1Q027SBEA-MVGFD027MNFRBDAL-W014RC1Q027SBEA-W011RC1Q027SBEA-W020RC1Q027SBEA-B232RC1Q027SBEA-B096RC1Q027SBEA-W006RC1Q027SBEA-W780RC1Q027SBEA-W009RC1Q027SBEA-B097RC1Q027SBEA-A091RC1Q027SBEA
                # using MVGFD027MNFRBDAL : Market Value of Gross Federal Debt as the initial value of the debt series
                temp_vec_CI = df[d['RENTIN']].values + df[d['CPROFIT']].values+df[d['W255RC1Q027SBEA']].values+df[d['PROPINC']].values/2
                temp_vec_tau_w = ((df[d['A074RC1Q027SBEA']].values+df[d['W071RC1Q027SBEA']].values)/(df[d['WASCUR']].values+df[d['PROPINC']].values/2+temp_vec_CI))*((df[d['WASCUR']].values+df[d['PROPINC']].values/2)/(df[d['COE']].values+df[d['PROPINC']].values/2))+df[d['W780RC1Q027SBEA']].values/(df[d['COE']].values+df[d['PROPINC']].values/2)
                temp_vec_tau_k = (df[d['A074RC1Q027SBEA']].values/(df[d['WASCUR']].values + df[d['PROPINC']].values/2 + temp_vec_CI))*(temp_vec_CI/(temp_vec_CI + df[d['B249RC1Q027SBEA']].values)) + (df[d['B075RC1Q027SBEA']].values + df[d['B249RC1Q027SBEA']].values)/(temp_vec_CI + df[d['B249RC1Q027SBEA']].values)
                temp_vec_govtaxrev_nonadj = (0.9*temp_vec_tau_w*(df[d['COE']].values + df[d['PROPINC']].values/2) + 0.62*temp_vec_tau_k*(temp_vec_CI + df[d['B249RC1Q027SBEA']].values))
                temp_vec_govexp_nonadj =  (df[d['A957RC1Q027SBEA']].values+ df[d['A787RC1Q027SBEA']].values+ df[d['AD08RC1Q027SBEA']].values-df[d['A918RC1Q027SBEA']].values)
                temp_vec_govtrans_noadj = (df[d['W014RC1Q027SBEA']].values- df[d['W011RC1Q027SBEA']].values) +   (df[d['W020RC1Q027SBEA']].values -df[d['B232RC1Q027SBEA']].values) +  df[d['B096RC1Q027SBEA']].values -  (df[d['W006RC1Q027SBEA']].values + df[d['W780RC1Q027SBEA']].values + df[d['W009RC1Q027SBEA']].values + df[d['B097RC1Q027SBEA']].values  - temp_vec_govtaxrev_nonadj)
                temp_vec_IntPmt = df[d['A091RC1Q027SBEA']].values
                temp_vec_MVdebtgross = df[d['MVGFD027MNFRBDAL']].values
                from itertools import accumulate
                temp_vec_b_change =  temp_vec_govexp_nonadj + temp_vec_govtrans_noadj - temp_vec_govtaxrev_nonadj + temp_vec_IntPmt
                temp_vec1 = list(accumulate(temp_vec_b_change))
                temp_vec1 = np.array(temp_vec1)
                temp_vec1 = temp_vec1 -temp_vec1[0]+temp_vec_MVdebtgross[0]
                temp_vec1 = temp_vec1/(df[d['GDPCTPI']].values*(df[d['CNP16OV']].values/226959))
                temp_vec1 = np.log(temp_vec1)
                temp_vec1 = np.ediff1d(temp_vec1)
                temp_vec1 = np.insert(temp_vec1, 0, 0)
                df.loc[:, obs]= temp_vec1 - np.nanmean(temp_vec1[1:])  
            
            
            
            else:
                print(f'{obs} is not exported as an osbervable.')

        return df
    
    # generate observed variables: construct obs
    dfTransform = construct_observables(dfTransform, dictVC)
    dfTransformSpf = construct_observables(dfTransformSpf, dictVC)

    dfComplete = pd.merge(dfRaw, dfTransform[list(variables['observed'])], how='outer', left_index=True, right_index=True, sort=True)
    dfCompleteSpf = pd.merge(dfRawSpf, dfTransformSpf[list(variables['observed'])], how='outer', left_index=True, right_index=True, sort=True)

    if dfComplete.shape == (0, 0):
        print('No data is generated.')
        return None

    # remove the first quarter, because it was only used for calculating growth
    if str(dfComplete.index[0]) == quarterStart:
        dfComplete = dfComplete.iloc[1:]
        dfCompleteSpf = dfCompleteSpf.iloc[1:]

    dfComplete.index = [str(index) for index in dfComplete.index]
    dfCompleteSpf.index = [str(index) for index in dfCompleteSpf.index]

    # remove some observables' current quarter value
    # observableNoCurrentQuaterValue = {'hours_sw07_obs', 'hours_frbedo08_obs', 'hours_kr15_obs', 'hours_dngs15_obs', 'unr_obs', 'hours_cmr14_obs'}
    # if obsEnd.to_period('Q') == vintageDate.to_period('Q'):
    #     for observable in observableNoCurrentQuaterValue:
    #         if observable in dfComplete.columns:
    #             dfComplete[observable.replace('_obs', '_cql_obs')] = dfComplete[observable]
    #             dfCompleteSpf[observable.replace('_obs', '_cql_obs')] = dfComplete[observable]
    #             dfComplete.iloc[-1, dfComplete.columns.get_loc(observable)] = float('nan')

    # if there are missing values in the last quarter and vintage date is no later than 120 days after the start of last quarter:
    # then create data for four scenarios
    pathExcelFile = f"data_{vintageDate.strftime('%Y%m%d')}.xlsx"
    if pathExcel is not None:
        pathExcelFile = pathExcel / pathExcelFile
    else:
        pathExcelFile = pathData / pathExcelFile

    with pd.ExcelWriter(pathExcelFile) as writer:

        # **for now, only consider scenarios when quarter(vintageDate) == obsEnd
        if obsEnd.to_period('Q') != vintageDate.to_period('Q') or onlyS3 == True:

            dfComplete.to_excel(writer)
            print('Generated data with one scenario.')

        else:
            assert np.sum(np.sum(dfComplete.iloc[:-1,:].fillna(-999) != dfCompleteSpf.iloc[:-1,:].fillna(-999))) == 0, '1 to n-1 rows of dfComplete and dfCompleteSpf not the same!'
            writeS2, writeS3, writeS4 = False, False, False

            # as long as there are some observables have last quarter value, we should consider S3
            if np.sum(~np.isnan(dfComplete.iloc[-1])):
                writeS3 = True
                dfS3 = dfComplete
                dfS1 = dfComplete.iloc[:-1,:]

            # as long as there are some SPF nowcast included, we should consider S2
            if np.sum(~np.isnan(dfCompleteSpf.iloc[-1])):
                writeS2 = True
                dfS2 = dfCompleteSpf
                dfS1 = dfCompleteSpf.iloc[:-1,:]

            # as long as both S2 and S3 exists, we should consider S4
            if writeS2 and writeS3:
                writeS4 = True
                # dfS4 should be based on dfS3, only fill with SPF nowcast if value is missing
                dfS4 = dfS3.copy()
                for index, column in enumerate(dfS4.columns.values):
                    if np.isnan(dfS4.iloc[-1, index]) and ~np.isnan(dfS2.iloc[-1, index]):
                        dfS4.iloc[-1, index] = dfS2.iloc[-1, index]

            # write to Excel
            if writeS4:
                dfS1.sort_index(axis=1).to_excel(writer, sheet_name='s1')
                dfS2.sort_index(axis=1).to_excel(writer, sheet_name='s2')
                dfS3.sort_index(axis=1).to_excel(writer, sheet_name='s3')
                dfS4.sort_index(axis=1).to_excel(writer, sheet_name='s4')
                print('Generated data with scenarios 1, 2, 3, and 4.')
            elif writeS3:
                dfS1.sort_index(axis=1).to_excel(writer, sheet_name='s1')
                dfS3.sort_index(axis=1).to_excel(writer, sheet_name='s3')
                print('Generated data with scenarios 1 and 3.')
            elif writeS2:
                dfS1.sort_index(axis=1).to_excel(writer, sheet_name='s1')
                dfS2.sort_index(axis=1).to_excel(writer, sheet_name='s2')
                print('Generated data with scenarios 1 and 2.')
            else:
                dfComplete.sort_index(axis=1).to_excel(writer)
                print('Generated data with one scenario.')

        # if np.sum(np.isnan(dfComplete.iloc[-1,:])) > 0 and vintageDate - dfComplete.index[-1].start_time < pd.Timedelta('120 days'):
        #     dfComplete.index = [str(index) for index in dfComplete.index]
        #     dfComplete.iloc[:-1,:].to_excel(writer, sheet_name='s1')
        #     dfComplete.to_excel(writer, sheet_name='s3')
        #     print('Generated data with different scenarios.')
        # else:
        #     dfComplete.index = [str(index) for index in dfComplete.index]
        #     dfComplete.to_excel(writer)
        #     print('Generated data with the only scenario.')

    return None

if __name__ == '__main__':

    main(
        vintageDate = '2020-11-10', quarterStart = '1980Q1', quarterEnd = '2020Q4', raw = [],
        observed = ['bbb1yffr_obs']

        )