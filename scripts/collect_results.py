import json, pathlib
import pandas as pd

paths = {
    'estimations': pathlib.Path('../estimations'),
    'application': pathlib.Path('../application'),
    'data': pathlib.Path('../data'),
}
for path in paths.values():
    assert path.exists()

results = {
    'dsge': [],
    'bvar': [],
    'actual': [],
    'others': [],
}

actualGDP = pd.read_csv(paths['data'] / 'actualGDP.csv', encoding='utf-8', index_col=0)
for i, index in enumerate(actualGDP.index):
    try:
        series = actualGDP.iloc[i: i+40+1, :].values.reshape(1, -1).tolist()[0]
    except:
        series = actualGDP.iloc[i:, :].values.reshape(1, -1).tolist()[0]

    results['actual'].append({'actual': {'gdp': series}, 'vintageQuarter': index})

for file in paths['estimations'].rglob('*.json'):
    inst = json.loads(file.read_text())
    # for i, value in enumerate(inst['forecast']['gdp']):
    #     inst['forecast']['gdp'][i] = f'{value: .10f}'
    results['dsge'].append(inst)

with open(paths['application'] / 'results.json', 'w') as file:
    json.dump(results, file, indent=2, sort_keys=True)