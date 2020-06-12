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
}
for path in paths.values():
    assert path.exists()

# obtain observed series
observed = []

for file in paths['vintage_data'].glob('*.xlsx'):
    vintage = file.stem
    vintage = vintage[5:9] + '-' + vintage[9:11] + '-' + vintage[11:]

    dfDict = pd.read_excel(file, sheet_name=None, index_col=0)

    for key, df in dfDict.items():
        scenario = key
        if scenario in {'s2', 's3'}:

            for col in df.columns.values:
                valueCol = df[col].tolist()
                for i, v in enumerate(valueCol):
                    if np.isnan(v):
                        valueCol[i] = v
                    else:
                        valueCol[i] = round(v*100000)/100000

                observed.append({
                    'vintage': vintage,
                    'scenario': scenario,
                    'variable': col,
                    'value': valueCol
                })

# obtain forecasts and forecast errors
results = {
    'dsge': [],
    'ts': [],
    'actual': [],
    'error': [],
}


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

# collect forecast results from the estimation folder
# calculate forecast errors
for file in paths['estimations'].rglob('*.json'):
    inst = json.loads(file.read_text())
    if 'GLP' in inst['model']:
        results['ts'].append(inst)
    else:
        results['dsge'].append(inst)

    forecastValues = inst['forecast']['gdp'][1:lengthRMSE+1]
    # if inst['scenario'] in {'s2', 's4'}:
    #     forecastValues[0] = float('nan')

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

# save results
with open(paths['application'] / 'results.json', 'w') as file:
    simplejson.dump(results, file, ignore_nan=True, indent=2, sort_keys=True)

with open(paths['application'] / 'observed.json', 'w') as file:
    simplejson.dump(observed, file, ignore_nan=True, indent=2, sort_keys=True)