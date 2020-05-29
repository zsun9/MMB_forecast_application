def main(vintageDate, sampleSize):

    '''
    Return start and end of sample period, where the end quarter contains the vintage date

    Arguments:

    1. vintageDate: the vintage date, string format: '1990-01-01'
    2. sampleSize: the size of the sample, integer
    
    Returns:

    1. quarterStart: start of the sample, pandas Period object
    2. quarterEnd: end of the sample, pandas Period object
    '''
    
    import pandas as pd

    vintageDate = pd.to_datetime(vintageDate)

    quarterEnd = vintageDate.to_period('Q')

    deltaYear = (sampleSize-1) // 4
    deltaQuarter = (sampleSize-1) % 4
    
    currentYear = vintageDate.year
    currentQuarter = vintageDate.quarter
    if currentQuarter - deltaQuarter >= 1:
        startYear = currentYear - deltaYear
        startQuarter = currentQuarter - deltaQuarter
    else:
        startYear = currentYear - deltaYear - 1
        startQuarter = currentQuarter - deltaQuarter + 4

    quarterStart = pd.to_datetime(str(startYear) + 'Q' + str(startQuarter)).to_period('Q')

    return quarterStart, quarterEnd

if __name__ == '__main__':
    pass