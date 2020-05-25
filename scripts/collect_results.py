import json, pathlib

paths = {
    'estimations': pathlib.Path('../estimations'),
    'application': pathlib.Path('../application'),
    'spf': pathlib.Path('../data/raw/spf'),
}
for path in paths.values():
    assert path.exists()

results = {
    'dsge': [],
    'timeseries': [],
    'actual': [],
    'external': [],
}

for file in paths['estimations'].rglob('*.json'):
    inst = json.loads(file.read_text())
    # for i, value in enumerate(inst['forecast']['gdp']):
    #     inst['forecast']['gdp'][i] = f'{value: .10f}'
    results['dsge'].append(inst)

with open(paths['application'] / 'results.json', 'w') as file:
    json.dump(results, file, indent=2, sort_keys=True)