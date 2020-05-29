def main(relativeRootPath = '..'):

    import pandas as pd
    import re, pathlib

    pathRoot = pathlib.Path(relativeRootPath)
    pathData = pathlib.Path(pathRoot / 'data')
    pathSpf = pathlib.Path( pathData / 'raw' / 'spf')
    assert pathData.exists() and pathSpf.exists()

    with open(pathSpf / 'spf-release-dates.txt', 'r') as file:
        lines = file.readlines()

    deadlines, releases, quarters = [], [], []

    startMatch = False
    for line in lines:
        line = line.replace('\t', ' ')
        match = re.search('(Q[1-4])( ){1,}(\d{1,2}/\d{1,2}/\d{2})', line)

        if match:
            startMatch = True
            deadline = pd.to_datetime(match.group(3))
            deadlines.append(deadline.strftime('%Y-%m-%d'))

            quarters.append(str(deadline.to_period('Q')))

            line = line.replace(match.group(0), ' ')
            release = pd.to_datetime(re.search('\d{1,2}/\d{1,2}/\d{2}', line).group(0))
            releases.append(release.strftime('%Y-%m-%d'))
        else:
            print(line)

    df = pd.DataFrame({'deadlines': deadlines, 'releases': releases})
    df.index = quarters
    
    # the first SPF should be removed, because it has forecasts for 1990Q2 but was collected in 1990Q3
    df = df.iloc[1:]

    df.to_csv(pathData / 'spf_dates.csv', encoding='utf-8')

if __name__ == '__main__':
    main()