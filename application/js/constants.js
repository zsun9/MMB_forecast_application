const modelColor = {
  // Always appear
  'SPFMean': 'DarkGreen',
  'SPFIndividual': 'rgba(0, 0, 0, 0.1)',
  // Selective pre crisis
  'DS04': 'Red',
  'WW11': 'Violet',
  'SW07': 'DodgerBlue',
  'SW07_ew': 'DodgerBlue',
  'FRBEDO08': 'LawnGreen',
  'FRBEDO08_cql': 'LawnGreen',
  'Fair': 'SandyBrown',
  // Selective post crisis
  'NKBGG': 'Cyan',
  'QPM08': 'DarkMagenta',
  'QPM08_cql': 'DarkMagenta',
  'KR15_FF': 'Blue',
  'KR15_FF_dy457': 'Blue',
  'DNGS15': 'Orange',
  'DNGS15_cql': 'Orange',
  'DNGS15_ew': 'Orange',
  'DNGS15_nofa': 'Orange',
  'KR15_HH': 'SpringGreen',
  'A16': 'Teal',
  'CMR14': 'OrangeRed',
  // Selective others
  'GLP3v': 'GreenYellow',
  'GLP5v': 'Salmon',
  'GLP8v': 'SkyBlue',

  'IN10': 'Red',
};

const modelDash = {
  'SW07_ew': [10, 5],
  'FRBEDO08_cql': [10, 5],
  'QPM08_cql': [10, 5],
  'DNGS15_cql': [10, 5],
  'DNGS15_ew': [10, 5],
  'DNGS15_nofa': [10, 5],
  'KR15_FF_dy457': [10, 5],
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