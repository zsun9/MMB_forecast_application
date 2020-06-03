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

    diffBound = 0.01 # max allowed difference (in %) between series with missing values and series to fill missing values
    # specificRules = {
    #     ('2008-08-07', 'COMPNFB', '2008Q3'): 181.676,
    # }

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
    infoObs = pd.read_excel('observed_variable_description.xlsx', encoding='utf-8')
    infoRaw = pd.read_csv('raw_variable_description.csv', encoding='utf-8')
    infoFillNowcast = pd.read_excel('fill_nowcast.xlsx', encoding='utf-8')
    infoFillHistory = pd.read_excel('fill_history.xlsx', encoding='utf-8')
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
            obsPeriod = df.index.map(lambda x: obsStart <= x <= obsEnd)
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
                    # if variable updated quarterly, then remove the last obs
                    if infoRaw[infoRaw['id']==var]['frequency_short'].values[0] == 'Q':
                        df.iloc[-1] = float('nan')
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
                    dfToMerge, actualVintageDateAlfred = desired_data(
                        source='alfred', var=variable, 
                        df=dfTemp, 
                        vintage=vintageDate
                    )

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

                            row = infoFillHistory[infoFillHistory['alfred']==variable]

                            fillSource = row['fillSource'].values[0]
                            fillVar = row['fillVar'].values[0]
                            fillFilename = row['fillFilename'].values[0]

                            if fillSource == 'alfred':
                                dfToFill = pd.read_csv(pathAlfred / fillFilename, index_col=0)
                            elif fillSource == 'rtdsm':
                                dfToFill = pd.read_excel(pathRtdsm / fillFilename, index_col=0)
                            else:
                                raise Exception(f'Cannot identify fill source ({fillSource}), make sure it is alfred or rtdsm')

                            dfToFill, _ = desired_data(
                                source=fillSource, var=fillVar, df=dfToFill, vintage=actualVintageDateAlfred
                            )

                            if dfToFill is None:
                                print(f'Missing values of {variable} not filled: No corresponding data.')
                            else:
                                # dfNotFilled = dfToMerge.copy()
                                diff = np.sum(np.abs(dfToFill.iloc[:-1,0]/dfToMerge.iloc[:-1,0]-1) > diffBound) # don't compare the last entry
                                if diff < 1:
                                    for index, (_, row) in enumerate(dfToMerge.iterrows()):
                                        if np.isnan(row.values[0]):
                                            try:
                                                dfToMerge.iloc[index, 0] = dfToFill.iloc[index, 0]
                                            except:
                                                pass
                                    print(f'Missing values of {variable} filled by {fillVar} from {fillSource}.')
                                elif diff == 1 and np.argmax(np.abs(dfToFill.iloc[:-1,0]/dfToMerge.iloc[:-1,0]-1)) == dfToFill.iloc[:-1,0].shape[0] - 1:
                                    lastDiff = np.max(np.abs(dfToFill.iloc[:-1,0]/dfToMerge.iloc[:-1,0]-1))
                                    for index, (_, row) in enumerate(dfToMerge.iterrows()):
                                        if np.isnan(row.values[0]):
                                            try:
                                                dfToMerge.iloc[index, 0] = dfToFill.iloc[index, 0]
                                            except:
                                                pass
                                    print(f'Missing values of {variable} filled by {fillVar} from {fillSource}, even though the diff between the last entry is {lastDiff:.2%} > {diffBound:.2%}.')
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
                                dataSpf = pd.read_excel(pathSpf / 'meanLevel.xlsx', sheet_name=variableNowcast, encoding='utf-8')

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
                # Demeaned: LN(PRS85006023*(CE16OV/118753)/(CNP16OV/193024.333333333))*100
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
                df.loc[:, obs] = np.log(((df[d['TOTLQ']])*100/df[d['CLF16OV']])/((df[d['TOTLQ']].shift()*100)/df[d['CLF16OV']].shift()))
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
                df.loc[:, obs] = np.log((df[d['PAYEMS']].values-df[d['USCONS']].values)*df[d['AWHMAN']].values/df[d['CNP16OV']].values) - np.nanmean(np.log((df[d['PAYEMS']].values - df[d['USCONS']].values)*df[d['AWHMAN']].values/df[d['CNP16OV']].values))                                 
                                                                                                                         
            elif obs == 'hwr_pd_obs':
            # LN(USCONS*CES2000000007/CNP16OV) - mean(LN(USCONS*CES2000000007/CNP16OV))
                df.loc[:, obs] = np.log(df[d['USCONS']].values*df[d['CES2000000007']].values/df[d['CNP16OV']].values) - np.nanmean(np.log(df[d['USCONS']].values*df[d['CES2000000007']].values/df[d['CNP16OV']].values))                                                                                                                         
          
# =============================================================================
#             elif obs == 'hp_r_obs':
#                 df.loc[:, obs] = df[d['CBHPI']].values
# =============================================================================
        
            elif obs == 'i_nom_obs':
           # TB3MS/400 - mean (TB3MS/400)
                df.loc[:, obs] = df[d['TB3MS']].values/400 - np.nanmean(df[d['TB3MS']].values/400)       

            elif obs == 'c_winf_obs':  # problem with data
           # ΔLN(AHETPI) - mean(ΔLN(AHETPI))
                df.loc[:, obs] = np.log(df[d['AHETPI']].values)- np.log(df[d['AHETPI']].shift().values) - np.nanmean(np.log(df[d['AHETPI']].values- np.log(df[d['AHETPI']]).shift().values))      
                                                                                                
        
# =============================================================================
#             elif obs == 'h_winf_obs':
#            # ΔLN(CES2000000008) - mean(ΔLN(CES2000000008))
#                df.loc[:, obs] = np.log(df[d['CES2000000008']].values) #- np.log(df[d['CES2000000008']].shift().values) - np.nanmean(np.log(df[d['CES2000000008']].values)- np.log(df[d['CES2000000008']].shift().values))  
# =============================================================================
                                                                                                                         
          
            
            
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
    observableNoCurrentQuaterValue = {'hours_dngs15_obs', 'hours_sw07_obs', 'hours_frbedo08_obs'}
    if obsEnd.to_period('Q') == vintageDate.to_period('Q'):
        for observable in observableNoCurrentQuaterValue:
            if observable in dfComplete.columns:
                dfComplete.iloc[-1, dfComplete.columns.get_loc(observable)] = float('nan')
            if observable in dfCompleteSpf.columns:
                dfCompleteSpf.iloc[-1, dfCompleteSpf.columns.get_loc(observable)] = float('nan')

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
                dfS1.to_excel(writer, sheet_name='s1')
                dfS2.to_excel(writer, sheet_name='s2')
                dfS3.to_excel(writer, sheet_name='s3')
                dfS4.to_excel(writer, sheet_name='s4')
                print('Generated data with scenarios 1, 2, 3, and 4.')
            elif writeS3:
                dfS1.to_excel(writer, sheet_name='s1')
                dfS3.to_excel(writer, sheet_name='s3')
                print('Generated data with scenarios 1 and 3.')
            elif writeS2:
                dfS1.to_excel(writer, sheet_name='s1')
                dfS2.to_excel(writer, sheet_name='s2')
                print('Generated data with scenarios 1 and 2.')
            else:
                dfComplete.to_excel(writer)
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
        vintageDate='2020-05-12', quarterStart='1980Q1', quarterEnd='2020Q2',
        observed=[
                'hours_frbedo08_obs', 'cnds_nom_obs', 'cd_nom_obs', 'ir_nom_obs', 'inr_nom_obs', 'cnds_def_obs', 'cd_def_obs',
           ],

        )