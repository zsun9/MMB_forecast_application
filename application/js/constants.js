const modelColor = {
  // Always appear
  'SPFMean': 'Green',
  'SPFIndividual': 'rgba(0, 0, 0, 0.1)',
  // Selective
  'CMR14': 'Red',
  'DS04': 'Red',
  'IN10': 'Red',
  'DS04_ew': 'Red',
  'WW11': 'Fuchsia',
  'WW11_ew': 'Fuchsia',
  'SW07': 'DodgerBlue',
  'SW07_ew': 'DodgerBlue',
  'NKBGG': 'Cyan',
  'NKBGG_ew': 'Cyan',
  'DNGS15': 'Orange',
  'DNGS15_cql': 'Orange',
  'DNGS15_ew': 'Orange',
  'DNGS15_cql_ew': 'Orange',
  'FRBEDO08': 'LawnGreen',
  'FRBEDO08_cql': 'LawnGreen',
  'FRBEDO08_ew': 'LawnGreen',
  'FRBEDO08_cql_ew': 'LawnGreen',
  'QPM08': 'DarkMagenta',
  'QPM08_cql': 'DarkMagenta',
  'QPM08_ew': 'DarkMagenta',
  'QPM08_cql_ew': 'DarkMagenta',
  'GLP3v': 'GreenYellow',
  'GLP8v': 'Blue',
  'KR15_FF': 'Blue',
  'Fair': 'Gold',
  'GBbeforeSPF': 'Brown',
  'GBafterSPF': 'Brown',
  'KR15_HH': 'Purple',
};

const modelDash = {
  'DS04_ew': [5, 5],
  'WW11_ew': [5, 5],
  'SW07_ew': [5, 5],
  'NKBGG_ew': [5, 5],
  'DNGS15_ew': [5, 5],
  'DNGS15_cql_ew': [5, 5],
  'QPM08_ew': [5, 5],
  'QPM08_cql_ew': [5, 5],
  'FRBEDO08_ew': [5, 5],
  'FRBEDO08_cql_ew': [5, 5],
}

const scenarioStrings = {
  's1': 'Balanced panel',
  's2': 'Conditioning on SPF nowcast',
  's3': 'Conditioning on current-quarter observations',
  's4': 'Full conditioning',
};

const nberRecessionQuarter = [
  '1980Q1', '1980Q2', '1981Q3', '1981Q4', '1982Q1', '1982Q2', '1982Q3', '1990Q3', '1990Q4',
  '2001Q1', '2001Q2', '2001Q3', '2008Q1', '2008Q2', '2008Q3', '2008Q4', '2009Q1', '2020Q1', '2020Q2',
]

const colorSetVariables = ['red', 'blue', 'green', 'gold', 'cyan'];

const scenarioLabel = {
  's3': 'with current-quarter value',
  's2': 'with SPF nowcast value',
};

const labelScenario = {
  'with current-quarter value': 's3',
  'with SPF nowcast value': 's2',
};