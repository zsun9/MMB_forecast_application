def vintage_gen(vintageDate = '', quarterStart = '', quarterEnd = '', raw = [], observed = []):

    '''
    Generate vintage data, arguments include:

    1. vintageDate: the vintage date on which the realtime data is observed. Format: 1990-01-01
    2. quarterStart: the first quarter of the observation period. Format: 1990Q1
    3. quarterEnd: the last quarter of the observation period. Format: 1990Q1
    4. raw: a list of raw variables to be generated, must appear in 'raw_variable_description'
    5. observed: a list of observed variables to be generated, must appear in 'observed_variable_description'

    Last update: Zexi Sun, 2020-05-14
    '''

    import pathlib
    import pandas as pd
    import numpy as np
    import datetime as datetime

    # parse arguments
    vintageDate = pd.to_datetime(vintageDate)
    # move one quarter back at the start to generate growth data in the first quarter
    if quarterStart[-1] == '1':
        quarterStart = str(int(quarterStart[0:4])-1) + 'Q4'
    else:
        quarterStart = quarterStart[0:5] + str(int(quarterStart[-1])-1)
    obsStart = pd.to_datetime(quarterStart).to_period('Q').start_time
    obsEnd = pd.to_datetime(quarterEnd).to_period('Q').end_time

    if vintageDate < obsEnd:
        print('Vintage date < Last observation date, so Last observation date = Vintage date.')
        obsEnd = vintageDate

    variables = {'raw': set(raw), 'transform': set([]), 'observed': set(observed), }

    # load data information
    descriptionObs = pd.read_excel('observed_variable_description.xlsx',encoding='utf-8')
    descriptionRaw = pd.read_csv('raw_variable_description.csv',encoding='utf-8')
    descriptionCorrespond = pd.read_excel('id_correspond.xlsx', encoding='utf-8')

    # set data locations
    pathAlfred = pathlib.Path('raw/alfred')
    pathRtdsm = pathlib.Path('raw/rtdsm')
    pathOthers = pathlib.Path('raw/others')
    assert pathAlfred.exists() and pathRtdsm.exists() and pathOthers.exists()

    # find raw variables that construct observed variables and store their names in 'transform'
    dictRawTransform = dict()

    if len(variables['observed']) > 0:

        setRaw = {fileAlfred.stem for fileAlfred in pathAlfred.glob('*.*')}

        for _, row in descriptionObs.iterrows():
            if row['id'] in variables['observed']:

                setRawTransform = set()
                for rawVar in setRaw:
                    if rawVar in row['construction']:

                        setRawTransform.update({rawVar})
                        variables['transform'].update({rawVar})
                
                dictRawTransform[row['id']] = setRawTransform
    
    # generate data for raw variables
    def gen_raw_variables(variables):

        dataOutput = pd.DataFrame({})

        index = -1

        for variable in variables:

            toMerge = False

            # find data in raw/alfred
            for fileAlfred in set(pathAlfred.glob('*.*')):

                if fileAlfred.stem == variable:

                    # load dataset
                    dataAlfred = pd.read_csv(fileAlfred, index_col=0)
                    dataAlfred.index = pd.to_datetime(dataAlfred.index)

                    # load frequency of the variable
                    frequency = descriptionRaw[descriptionRaw['id']==variable]['frequency_short'].values[0]

                    # select vintage date
                    # for data in daily frequency, choose the only vintage, otherwise, choose the biggest vintage that is smaller than vintageDate
                    vintageColAlfred = ''
                    if frequency == 'D':
                        vintageColAlfred = dataAlfred.columns.values[-1]
                    else:
                        for column in dataAlfred.columns.values:
                            if int(vintageDate.strftime('%Y%m%d')) >= int(column[-8:]):
                                vintageColAlfred = column
                            else:
                                break

                    # select observation period
                    obsPeriodAlfred = dataAlfred.index.map(lambda x: obsStart <= x <= obsEnd)

                    # combine desired observation period and vintage date
                    dataAlfred = dataAlfred[obsPeriodAlfred].copy()
                    dataAlfred = dataAlfred.loc[:, dataAlfred.columns.map(lambda x: x == vintageColAlfred)].copy()

                    if dataAlfred.shape[0]*dataAlfred.shape[1] == 0 or np.sum(~np.isnan(dataAlfred[vintageColAlfred].values)) == 0:
                        print(f'\n{variable} has no value within the observation period and vintage date you choose.\n')
                    else:
                        # take the average over the quarter
                        dataAlfred['quarter'] = dataAlfred.index.to_period('Q').values
                        dataAlfred = dataAlfred.groupby('quarter').mean().copy()
                        dataToMerge = dataAlfred.copy()
                        index += 1
                        toMerge = True

                        # if there are missing values, find them in raw/rtdsm
                        if np.sum(np.isnan(dataAlfred.values)) > 0:

                            try:
                                fileRtdsmName = descriptionCorrespond[descriptionCorrespond['alfred']==variable]['fileRtdsmName'].values[0]
                            except:
                                fileRtdsmName = 0
                                print(f'\nMissing values of {variables} not filled: No corresponding series in RTDSM.\n')

                            if type(fileRtdsmName) == str:

                                dataRtdsm = pd.read_excel(pathRtdsm / fileRtdsmName, index_col=0)
                                # convert index format
                                if 'Q' in dataRtdsm.index[0]:
                                    dataRtdsm.index = pd.to_datetime([index.replace(':', '-') for index in dataRtdsm.index])
                                else:
                                    dataRtdsm.index = pd.to_datetime(dataRtdsm.index, format='%Y:%m')

                                # select vintage date (<=vintageColAlfred)
                                vintageColRtdsm = ''
                                for column in dataRtdsm.columns.values:
                                    columnOriginal = column
                                    column = column.replace(descriptionCorrespond[descriptionCorrespond['alfred']==variable]['rtdsm'].values[0], '')
                                    if column[0] in ['0', '1', '2', '3']:
                                        column = '20' + column
                                    else:
                                        column = '19' + column

                                    if 'Q' in column:
                                        columnDate = pd.to_datetime(column)
                                    else:
                                        columnDate = pd.to_datetime(column, format='%YM%m')

                                    if pd.to_datetime(vintageColAlfred[-8:]) >= columnDate:
                                        vintageColRtdsm = columnOriginal
                                    else:
                                        break

                                # select observation period
                                obsPeriodRtdsm = dataRtdsm.index.map(lambda x: obsStart <= x <= obsEnd)

                                # combine desired observation period and vintage date
                                dataRtdsm = dataRtdsm[obsPeriodRtdsm].copy()
                                dataRtdsm = dataRtdsm.loc[:, dataRtdsm.columns.map(lambda x: x == vintageColRtdsm)].copy()

                                if dataRtdsm.shape[0]*dataRtdsm.shape[1] == 0 or np.sum(~np.isnan(dataRtdsm[vintageColRtdsm].values)) == 0:
                                    print(f'\nMissing values of {variables} not filled: RTDSM series found, but no corresponding data.\n')
                                else:
                                    dataRtdsm['quarter'] = dataRtdsm.index.to_period('Q').values
                                    dataRtdsm = dataRtdsm.groupby('quarter').mean().copy()

                                    differenceBound = 0.01
                                    difference = np.max(np.abs((dataRtdsm[vintageColRtdsm]/dataAlfred[vintageColAlfred]-1)))
                                    if difference <= differenceBound:
                                        for index, row in dataAlfred.iterrows():
                                            if np.isnan(row[vintageColAlfred]):
                                                try:
                                                    dataAlfred.loc[index, vintageColAlfred] = dataRtdsm.loc[index, vintageColRtdsm]
                                                except:
                                                    pass
                                        dataToMerge = dataAlfred.copy()
                                        print(f'\nMissing values of {variables} filled.\n')

                                    else:
                                        dataToMerge = pd.merge(dataAlfred, dataRtdsm, how='outer', left_index=True, right_index=True, sort=True)
                                        print(f'\nMissing values of {variables} not filled: Difference between RTDSM and ALFRED series > {differenceBound:.2%}, will print these two series \n')

                    break

            if toMerge == True:

                if index == 0:
                    dataOutput = dataToMerge.copy()
                else:
                    dataOutput = pd.merge(dataOutput, dataToMerge, how='outer', left_index=True, right_index=True, sort=True)

        return dataOutput
    
    dataRaw = gen_raw_variables(variables['raw'])
    dataTransform = gen_raw_variables(variables['transform'])

    # correspondence: variable name : column name (e.g., 'GDPC1':'GDPC1_20010101')
    dictVC = dict()
    for column in dataTransform.columns.values:
        if column[-8:].isdigit():
            dictVC[column[:-9]] = column
        else:
            dictVC[column] = column

    # generate observed variables
    for obs in variables['observed']:

        if obs == 'gdp_rgd_obs':
            # ΔLN(GDPC1)*100
            dataTransform.loc[:, obs] = np.log(dataTransform[dictVC['GDPC1']].values/dataTransform[dictVC['GDPC1']].shift().values)*100

        elif obs == 'pgdp_q_obs':
            # ΔLN(GDPCTPI)*100
            dataTransform.loc[:, obs] = np.log(dataTransform[dictVC['GDPCTPI']].values/dataTransform[dictVC['GDPCTPI']].shift().values)*100

        elif obs == 'ffr_obs':
            # DFF/4
            dataTransform.loc[:, obs] = dataTransform[dictVC['DFF']]/4

        elif obs == 'fpi_q_obs':
            # ΔLN(FPI/GDPCTPI)*100
            dataTransform.loc[:, obs] = np.log((dataTransform[dictVC['FPI']].values/dataTransform[dictVC['GDPCTPI']].values)/(dataTransform[dictVC['FPI']].shift().values/dataTransform[dictVC['GDPCTPI']].shift().values))*100

        elif obs == 'pcer_q_obs':
            # ΔLN(PCE/GDPCTPI)*100
            dataTransform.loc[:, obs] = np.log((dataTransform[dictVC['PCE']].values/dataTransform[dictVC['GDPCTPI']].values)/(dataTransform[dictVC['PCE']].shift().values/dataTransform[dictVC['GDPCTPI']].shift().values))*100

        elif obs == 'cp_q_obs':
            # (DBAA-DGS10)/4
            dataTransform.loc[:, obs] = (dataTransform[dictVC['DBAA']] - dataTransform[dictVC['DGS10']])/4

        elif obs == 'wage_obs':
            # ΔLN(COMPNFB/GDPCTPI)*100
            dataTransform.loc[:, obs] = np.log((dataTransform[dictVC['COMPNFB']].values/dataTransform[dictVC['GDPCTPI']].values)/(dataTransform[dictVC['COMPNFB']].shift().values/dataTransform[dictVC['GDPCTPI']].shift().values))*100
        
        elif obs == 'gdp_q_AA16_obs':
            # ΔLN((GDPC1-NETEXC)/CE16OV)*100
            dataTransform.loc[:, obs] = np.log(((dataTransform[dictVC['GDPC1']].values-dataTransform[dictVC['NETEXC']].values)/dataTransform[dictVC['CLF16OV']].values)/((dataTransform[dictVC['GDPC1']].shift().values-dataTransform[dictVC['NETEXC']].shift().values)/dataTransform[dictVC['CLF16OV']].shift().values))*100
        
        elif obs == 'i_q_AA16_obs':
            # ΔLN(GPDI+PCDG)*100
            dataTransform.loc[:, obs] = np.log((dataTransform[dictVC['GPDI']].values+dataTransform[dictVC['PCDG']].values)/(dataTransform[dictVC['GPDI']].shift().values+dataTransform[dictVC['PCDG']].shift().values))*100
        
        elif obs == 'c_q_AA16_obs':
            # ΔLN((PCESV+PCND))*100
            dataTransform.loc[:, obs] = np.log((dataTransform[dictVC['PCND']].values+dataTransform[dictVC['PCESV']].values)/(dataTransform[dictVC['PCND']].shift().values+dataTransform[dictVC['PCESV']].shift().values))*100

        elif obs == 'infla_obs':
            # ΔLN(CPIAUCSL)
            dataTransform.loc[:, obs] = np.log(dataTransform[dictVC['CPIAUCSL']].values/dataTransform[dictVC['CPIAUCSL']].shift().values)

        else:
            print(f'\n{obs} is not exported as an osbervable.\n')
    
    dataComplete = pd.merge(dataRaw, dataTransform[list(variables['observed'])], how='outer', left_index=True, right_index=True, sort=True)
    if str(dataComplete.index[0]) == quarterStart:
        dataComplete = dataComplete.iloc[1:]
    dataComplete.to_csv(f"data_{vintageDate.strftime('%Y%m%d')}.csv")

    return None

if __name__ == '__main__':
    vintage_gen(
        vintageDate='2010-06-01', quarterStart='1980Q1', quarterEnd='2010Q2', 
        raw=['PCEC96'], observed=['gdp_rgd_obs', 'ffr_obs']
    )