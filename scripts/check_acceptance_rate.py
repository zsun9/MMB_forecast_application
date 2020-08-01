import pathlib

paths = {
    'estimations': pathlib.Path('../estimations'),
    'root': pathlib.Path('../')
}
for path in paths.values():
    assert path.exists()

jsonNotExist = []
acceptanceRates = []

for dirPath in paths['estimations'].glob('*'):
    if dirPath.is_dir() and 'GLP' not in dirPath.stem:

        try:
            jsonPath = list(dirPath.glob('*.json'))[0]
            with open(list(dirPath.glob('*.log'))[0], 'r') as logFile:
                log = logFile.readlines()
                for index, line in enumerate(log):
                    if 'Chain  1: ' in line:
                        acceptanceRates.append((dirPath.stem, float(line.replace('Chain  1: ', '').replace(' ', '').replace('\n', '').replace('%', ''))))
                    if 'average acceptation rate per chain' in line:
                        acceptanceRates.append((dirPath.stem, 100*float(log[index+1].replace('Chain  1: ', '').replace(' ', '').replace('\n', '').replace('%', ''))))

        except:
            print(f'Something wrong with: {dirPath.stem}')
            jsonNotExist.append(dirPath.stem)

with open(paths['root'] / 'accpetanceRate.txt', 'w') as outputFile:
    outputFile.writelines([str(item) + '\n' for item in sorted(acceptanceRates, key=lambda x: x[1])])