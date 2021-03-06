import json, pathlib
import pandas as pd
import numpy as np
from json import encoder
import simplejson

paths = {
    'estimations': pathlib.Path('../estimations'),
    'application': pathlib.Path('../application'),
    'data': pathlib.Path('../data'),
    'vintage_data': pathlib.Path('../data/vintage_data'),
    'root': pathlib.Path('../')

}
for path in paths.values():
    assert path.exists()

# obtain forecasts and forecast errors
results = {
    'dsge': [],
    'ts': [],
    'actual': [],
    'error': [],
    'external': [],
}

lastForecast = []

actualForRMSE = {}
jsonError = []
jsonRMSE = []
lengthRMSE = 5

# collect actual GDP growth
actualGDP = pd.read_csv(paths['data'] / 'actualGDP.csv', encoding='utf-8', index_col=0)
for i, index in enumerate(actualGDP.index):
    try:
        series = actualGDP.iloc[i: i+40+1, :].values.reshape(1, -1).tolist()[0]
    except:
        series = actualGDP.iloc[i:, :].values.reshape(1, -1).tolist()[0]

    if len(series) >= 5:
        actualForRMSE[index] = series[:lengthRMSE]

    results['actual'].append({'actual': {'gdp': series}, 'vintageQuarter': index})

# collect SPF/GB/Fair forecasts
df_sgf = pd.read_excel(paths['data'] / 'gb_spf_fair.xls')
for index, row in df_sgf.iterrows():
    inst = {
        'model': row['model'],
        'vintageQuarter': row['vintage'],
        'forecast': {'gdp': row.tolist()[2:]},
        }
    if row['model'] == 'Fair':
        results['dsge'].append(inst)
    else:
        results['external'].append(inst)

    if not inst['model'] in {'SPFIndividual', 'GBafterSPF', 'GBbeforeSPF'}:
        forecastValues = inst['forecast']['gdp'][1:lengthRMSE+1]
        vintageQuarter = inst['vintageQuarter']

        if vintageQuarter in actualForRMSE.keys():

            jsonError.append({
                # 'forecast': forecastValues,
                'squaredError': [(forecast - actual)**2 for forecast, actual in zip(forecastValues, actualForRMSE[vintageQuarter])],
                'model': inst['model'],
                'vintageQuarter': vintageQuarter,
            })

# collect forecast results from the estimation folder
# calculate forecast errors
for directory in paths['estimations'].glob('*'):

    if 'dy462' in directory.stem:
        print(f'Not included: {directory.stem}')
    if '20090811' in directory.stem or '20091110' in directory.stem or 'autotune' in directory.stem or 'VI16' in directory.stem:
        print(f'Not included: {directory.stem}')
    elif 'IN10' in directory.stem and 'adjusted' not in directory.stem:
        print(f'Not included: {directory.stem}')
    elif ('DNGS15' in directory.stem or 'FRBEDO08' in directory.stem or 'GSW12' in directory.stem or 'QPM08' in directory.stem) and ('s3' in directory.stem or 's4' in directory.stem) and ('cql' not in directory.stem):
        print(f'Not included: {directory.stem}')
    else:
        if directory.is_dir():
            foundJSON = False
            for file in directory.glob('*.json'):
                foundJSON = True
                inst = json.loads(file.read_text())
                if 'autotune' in directory.stem:
                    inst['model'] = inst['model'] + '_new'
                if 'cql' in directory.stem:
                    # assert 'cql' in inst['model']
                    inst['model'] = inst['model'].replace('_cql', '')
                if 'nofa' in directory.stem:
                    assert 'nofa' in inst['model']
                if 'ew' in directory.stem:
                    inst['model'] += '_ew'
                if 'KR15' in directory.stem and 'dy424' not in directory.stem:
                    inst['model'] += '_dy457'
                if 'GLP' in inst['model']:
                    results['ts'].append(inst)
                else:
                    results['dsge'].append(inst)
            if foundJSON == False:
                print(f'No JSON: {directory.stem}')
            else:
                for file in directory.glob('*_results.mat'):
                    file.unlink()

                try:
                    lastForecast.append((inst['model'], inst['vintage'], inst['scenario'], inst['modeCompute'], inst['forecast']['gdp'][-1]))
                except:
                    lastForecast.append((inst['model'], inst['vintage'], inst['scenario'], inst['forecast']['gdp'][-1]))

                forecastValues = inst['forecast']['gdp'][1:lengthRMSE+1]

                quarter = int(np.floor((int(inst['vintage'][5:7]) - 1) / 3) + 1)
                year = int(inst['vintage'][0:4])
                vintageQuarter = str(year) + 'Q' + str(quarter)

                if vintageQuarter in actualForRMSE.keys():

                    jsonError.append({
                        # 'forecast': forecastValues,
                        'squaredError': [(forecast - actual)**2 for forecast, actual in zip(forecastValues, actualForRMSE[vintageQuarter])],
                        'model': inst['model'],
                        'vintage': inst['vintage'],
                        'vintageQuarter': vintageQuarter,
                        'scenario': inst['scenario'],
                    })

results['error'] = jsonError
# dfError = pd.DataFrame(jsonError)

# for tupleModelScenario, group in dfError.groupby(['model', 'scenario']):
#     RMSEValues = [0] * lengthRMSE
#     num = group.shape[0]

#     for step in range(0, lengthRMSE):
#         for inst in range(0, num):
#             RMSEValues[step] += group.iloc[inst, 0][step]
#         RMSEValues[step] /= num
#     RMSEValues = np.sqrt(RMSEValues)

#     jsonError.append({
#         'rmse': RMSEValues,
#         'num': num,
#         'model': tupleModelScenario[0],
#         'scenario': tupleModelScenario[1],
#     })

# obtain observed series
observed = []

# for file in paths['vintage_data'].glob('*.xlsx'):
#     vintage = file.stem
#     vintage = vintage[5:9] + '-' + vintage[9:11] + '-' + vintage[11:]

#     dfDict = pd.read_excel(file, sheet_name=None, index_col=0)

#     for key, df in dfDict.items():
#         scenario = key
#         if scenario in {'s2', 's3'}:

#             for col in df.columns.values:
#                 valueCol = df[col].tolist()
#                 for i, v in enumerate(valueCol):
#                     if np.isnan(v):
#                         valueCol[i] = v
#                     else:
#                         valueCol[i] = round(v*10000)/10000

#                 observed.append({
#                     'vintage': vintage,
#                     'scenario': scenario,
#                     'variable': col,
#                     'value': valueCol
#                 })

# save results
with open(paths['application'] / 'src' / 'results.json', 'w') as file:
    simplejson.dump(results, file, ignore_nan=True, indent=2, sort_keys=True)

# with open(paths['application'] / 'src' /  'variables.json', 'w') as file:
#     simplejson.dump(observed, file, ignore_nan=True, indent=2, sort_keys=True)

with open(paths['root'] / 'lastForecast.txt', 'w') as outputFile:
    outputFile.writelines([str(item) + '\n' for item in sorted(lastForecast, key=lambda x: x[-1])])