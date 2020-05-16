def gen_vintage(vintageDate = '', quarterStart = '', quarterEnd = '', raw = [], observed = [], showRawTransform=False):

    '''
    Generate vintage data, arguments include:

    1. vintageDate: the vintage date on which the realtime data is observed. Format: 1990-01-01
    2. quarterStart: the first quarter of the observation period. Format: 1990Q1
    3. quarterEnd: the last quarter of the observation period. Format: 1990Q1

    4. raw (list, default=[]): raw variables to be generated, must appear in 'raw_variable_description'
    5. observed (list, default=[]): observed variables to be generated, must appear in 'observed_variable_description'
    6. showRawTransform (boolean, default=False): show raw series that are used to construct observables

    Last update: Zexi Sun, 2020-05-16
    '''

    import pathlib
    import pandas as pd
    import numpy as np
    import datetime as datetime

    # set hyperparameters
    diffBound = 0.01 # max allowed difference (in %) between series with missing values and series to fill missing values

    # parse arguments
    vintageDate = pd.to_datetime(vintageDate)
    # move one quarter back at the start to generate growth data in the first quarter
    if quarterStart[-1] == '1':
        quarterStart = str(int(quarterStart[0:4])-1) + 'Q4'
    else:
        quarterStart = quarterStart[0:5] + str(int(quarterStart[-1])-1)
    obsStart = pd.to_datetime(quarterStart).to_period('Q').start_time
    obsEnd = pd.to_datetime(quarterEnd).to_period('Q').end_time
    obsRange = pd.date_range(start=quarterStart, end=quarterEnd, freq='Q').to_period('Q').start_time

    if vintageDate < obsEnd:
        print('Vintage date < Last observation date, so Last observation date = Vintage date.')
        obsEnd = vintageDate

    variables = {'raw': set(raw), 'transform': set([]), 'observed': set(observed), }

    # load data information
    infoObs = pd.read_excel('observed_variable_description.xlsx', encoding='utf-8')
    infoRaw = pd.read_csv('raw_variable_description.csv', encoding='utf-8')
    infoFillNowcast = pd.read_excel('fill_nowcast.xlsx', encoding='utf-8')
    infoFillHistory = pd.read_excel('fill_history.xlsx', encoding='utf-8')

    # set data locations
    pathAlfred = pathlib.Path('raw/alfred')
    pathRtdsm = pathlib.Path('raw/rtdsm')
    pathSpf = pathlib.Path('raw/spf')
    pathOthers = pathlib.Path('raw/others')
    assert pathAlfred.exists() and pathRtdsm.exists() and pathSpf.exists() and pathOthers.exists()

    # find raw variables that construct observed variables and store their names in 'transform'
    dictRawTransform = dict()

    if len(variables['observed']) > 0:

        setRaw = {fileAlfred.stem for fileAlfred in pathAlfred.glob('*.*')}

        for _, row in infoObs.iterrows():
            if row['id'] in variables['observed']:

                setRawTransform = set()
                for rawVar in setRaw:
                    if rawVar in row['construction']:

                        setRawTransform.update({rawVar})
                        variables['transform'].update({rawVar})
                
                dictRawTransform[row['id']] = setRawTransform
    
    # if showRawTransform = True, show raw variables that are used for constructing observables
    if showRawTransform == True:
        variables['raw'].update(variables['transform'])

    # select desired data from ALFRED/RTDSM
    def desired_data(source, var, df, vintage):

        # return a tuple: (df, actualVintageDate), or (None, None)

        if source in {'alfred', 'rtdsm'}:

            vintageCol = ''

            if source == 'alfred':

                # convert index to datetime format
                df.index = pd.to_datetime(df.index)

                # select vintage date
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

                # convert index to datetime format
                if 'Q' in df.index[0]:
                    df.index = pd.to_datetime([index.replace(':', '-') for index in df.index])
                else:
                    df.index = pd.to_datetime(df.index, format='%Y:%m')

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

            # select observation period
            obsPeriod = df.index.map(lambda x: obsStart <= x <= obsEnd)

            # combine desired observation period and vintage date
            df = df[obsPeriod].copy()
            df = df.loc[:, df.columns.map(lambda x: x == vintageCol)].copy()

            # check whether desired data are generated
            if df.shape[0]*df.shape[1] == 0 or np.sum(~np.isnan(df[vintageCol].values)) == 0:
                return None, None
            else:
                # take average over the quarter
                df['quarter'] = df.index.to_period('Q').values
                df = df.groupby('quarter').mean().copy()
                # df should span from obsStart to obsEnd, even some entries are missing
                df = pd.merge(df, pd.DataFrame(index=obsRange.to_period('Q')), how='outer', left_index=True, right_index=True, sort=True)
                return df, actualVintageDate

        else:
            raise Exception(f'Cannot retreive desired data from {source}.')

    # generate data for raw variables
    def gen_raw_variables(variablesInput):

        dfOutput = pd.DataFrame({})

        index = -1

        for variable in variablesInput:

            toMerge = False

            # find data in raw/alfred
            for fileAlfred in set(pathAlfred.glob('*.*')):

                if fileAlfred.stem == variable:

                    # retreive desired data
                    dfToMerge, actualVintageDateAlfred = desired_data(
                        source='alfred', var=variable, 
                        df=pd.read_csv(fileAlfred, index_col=0), 
                        vintage=vintageDate
                    )

                    # proceed if dfToMerge is not None
                    if dfToMerge is None:
                        print(f'\nFor raw variable {variable}, cannot find value between {quarterStart} and {quarterEnd} at vintage date {vintageDate}.\n')
                    else:
                        # print(f"\nRaw variable {variable} retreived, actual vintage date is {actualVintageDateAlfred.strftime('%Y-%m-%d')}\n")
                        index += 1
                        toMerge = True

                        # if the last obs is missing

                        # if only the last obs is missing
                        # if the second to last obs is also missing

                        # is obs other than last or second to last are missing
                        if np.sum(np.isnan(dfToMerge.iloc[:-2].values)) > 0 and variable in infoFillHistory['alfred'].values:

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
                                print(f'\nMissing values of {variable} not filled: No corresponding data.\n')
                            else:
                                dfNotFilled = dfToMerge.copy()
                                diff = np.max(np.abs(dfToFill.iloc[:-1,0]/dfToMerge.iloc[:-1,0]-1)) # don't compare the last entry
                                if diff <= diffBound:
                                    for index, (_, row) in enumerate(dfToMerge.iterrows()):
                                        if np.isnan(row.values[0]):
                                            try:
                                                dfToMerge.iloc[index, 0] = dfToFill.iloc[index, 0]
                                            except:
                                                pass
                                    print(f'\nMissing values of {variable} filled by using {fillVar} from {fillSource}.\n')
                                else:
                                    dfToMerge = pd.merge(dfToMerge, dfToFill, how='outer', left_index=True, right_index=True, sort=True)
                                    dfToMerge.to_csv(f'diff_{variable}_{fillVar}.csv')
                                    print(f'\nMissing values of {variable} not filled: Diff between series to be filled and series to fill > {diffBound:.2%}, will print two series.\n')
                    break

            if toMerge == True:
                if index == 0:
                    dfOutput = dfToMerge.copy()
                else:
                    dfOutput = pd.merge(dfOutput, dfToMerge, how='outer', left_index=True, right_index=True, sort=True)
        
        return dfOutput

    dfRaw = gen_raw_variables(variables['raw'])
    dfTransform = gen_raw_variables(variables['transform'])

    # correspondence: variable name : column name (e.g., 'GDPC1':'GDPC1_20010101')
    dictVC = dict()
    for column in dfTransform.columns.values:
        if column[-8:].isdigit():
            dictVC[column[:-9]] = column
        else:
            dictVC[column] = column

    # generate observed variables
    for obs in variables['observed']:

        if obs == 'gdp_rgd_obs':
            # ΔLN(GDPC1)*100
            dfTransform.loc[:, obs] = np.log(dfTransform[dictVC['GDPC1']].values/dfTransform[dictVC['GDPC1']].shift().values)*100

        elif obs == 'gdpdef_obs':
            # ΔLN(GDPCTPI)*100
            dfTransform.loc[:, obs] = np.log(dfTransform[dictVC['GDPCTPI']].values/dfTransform[dictVC['GDPCTPI']].shift().values)*100

        elif obs == 'ffr_obs':
            # DFF/4
            dfTransform.loc[:, obs] = dfTransform[dictVC['DFF']]/4

        elif obs == 'ifi_rgd_obs':
            # ΔLN(FPI/GDPCTPI)*100
            dfTransform.loc[:, obs] = np.log((dfTransform[dictVC['FPI']].values/dfTransform[dictVC['GDPCTPI']].values)/(dfTransform[dictVC['FPI']].shift().values/dfTransform[dictVC['GDPCTPI']].shift().values))*100

        elif obs == 'c_rgd_obs':
            # ΔLN(PCE/GDPCTPI)*100
            dfTransform.loc[:, obs] = np.log((dfTransform[dictVC['PCE']].values/dfTransform[dictVC['GDPCTPI']].values)/(dfTransform[dictVC['PCE']].shift().values/dfTransform[dictVC['GDPCTPI']].shift().values))*100

        elif obs == 'wage_rgd_obs':
            # ΔLN(COMPNFB/GDPCTPI)*100
            dfTransform.loc[:, obs] = np.log((dfTransform[dictVC['COMPNFB']].values/dfTransform[dictVC['GDPCTPI']].values)/(dfTransform[dictVC['COMPNFB']].shift().values/dfTransform[dictVC['GDPCTPI']].shift().values))*100

        elif obs == 'baag10_obs':
            # (DBAA-DGS10)/4
            dfTransform.loc[:, obs] = (dfTransform[dictVC['DBAA']] - dfTransform[dictVC['DGS10']])/4

        elif obs == 'hours_dngs15_obs':
            # LN(AWHNONAG*CE16OV/100/(CNP16OV/3))*100
            dfTransform.loc[:, obs] = np.log(dfTransform[dictVC['AWHNONAG']]*dfTransform[dictVC['CE16OV']]/100/(dfTransform[dictVC['CNP16OV']]/3))*100

        elif obs == 'hours_sw07_obs':
            # Demeaned: LN(PRS85006023*(CE16OV/118753)/(CNP16OV/193024.333333333))*100
            dfTransform.loc[:, obs] = np.log(dfTransform[dictVC['DBAA']]*(dfTransform[dictVC['DBAA']]/118753)/(dfTransform[dictVC['DBAA']]/193024.333333333))*100
            dfTransform.loc[:, obs] = dfTransform.loc[:, obs] - dfTransform.loc[:, obs].mean()

        elif obs == 'gdp_q_AA16_obs':
            # ΔLN((GDPC1-NETEXC)/CE16OV)*100
            dfTransform.loc[:, obs] = np.log(((dfTransform[dictVC['GDPC1']].values-dfTransform[dictVC['NETEXC']].values)/dfTransform[dictVC['CLF16OV']].values)/((dfTransform[dictVC['GDPC1']].shift().values-dfTransform[dictVC['NETEXC']].shift().values)/dfTransform[dictVC['CLF16OV']].shift().values))*100
        
        elif obs == 'i_q_AA16_obs':
            # ΔLN(GPDI+PCDG)*100
            dfTransform.loc[:, obs] = np.log((dfTransform[dictVC['GPDI']].values+dfTransform[dictVC['PCDG']].values)/(dfTransform[dictVC['GPDI']].shift().values+dfTransform[dictVC['PCDG']].shift().values))*100
        
        elif obs == 'c_q_AA16_obs':
            # ΔLN((PCESV+PCND))*100
            dfTransform.loc[:, obs] = np.log((dfTransform[dictVC['PCND']].values+dfTransform[dictVC['PCESV']].values)/(dfTransform[dictVC['PCND']].shift().values+dfTransform[dictVC['PCESV']].shift().values))*100

        # elif obs == 'rc_obs':
        #     # ΔLN(PCECC96/CNP16OV) - first value of ΔLN(PCECC96/CNP16OV) 
        #     dfTransform.loc[:, obs] = np.log(dfTransform[dictVC['PCECC96']].values/dfTransform[dictVC['CNP16OV']].values) - np.log(dfTransform[dictVC['PCECC96']].values/dfTransform[dictVC['CNP16OV']].values)[0]
            
        # elif obs == 'pi_dm_obs':
        #     # ΔLN(pi_dm_obs) - mean ΔLN(CPIAUCSL)
        #     dfTransform.loc[:, obs] = np.log(dfTransform[dictVC['IPDNBS']].values- np.log(dfTransform[dictVC['IPDNBS']]).shift().values - np.nanmean(np.log(dfTransform[dictVC['IPDNBS']].values- np.log(dfTransform[dictVC['IPDNBS']]).shift().values)

        else:
            print(f'\n{obs} is not exported as an osbervable.\n')
    
    dfComplete = pd.merge(dfRaw, dfTransform[list(variables['observed'])], how='outer', left_index=True, right_index=True, sort=True)

    # remove the first quarter, because it was only used for calculating growth
    if str(dfComplete.index[0]) == quarterStart:
        dfComplete = dfComplete.iloc[1:]

    # if there are missing values in the last quarter and vintage date is no later than 120 days after the start of last quarter:
    # then create data for four scenarios
    with pd.ExcelWriter(f"data_{vintageDate.strftime('%Y%m%d')}.xlsx") as writer:
        if np.sum(np.isnan(dfComplete.iloc[-1,:])) > 0 and vintageDate - dfComplete.index[-1].start_time < pd.Timedelta('120 days'):
            dfComplete.index = [str(index) for index in dfComplete.index]
            dfComplete.iloc[:-1,:].to_excel(writer, sheet_name='s1')
            dfComplete.to_excel(writer, sheet_name='s3')
            print('Generated data with different scenarios.')
        else:
            dfComplete.index = [str(index) for index in dfComplete.index]
            dfComplete.to_excel(writer)
            print('Generated data with only scenario.')

    return None

    return None

if __name__ == '__main__':
    pass