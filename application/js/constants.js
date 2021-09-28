const modelColor = {
  // Always appear
  'SPFMean': 'Yellow',
  'SPFIndividual': 'rgba(0, 0, 0, 0.1)',
  // Selective pre crisis
  'DS04': 'Blue',//org//'Red',
  'WW11': 'Blue',//org//'Violet',
  'SW07': 'Blue',//org//'DodgerBlue',
  'SW07_ew': 'Blue',//org//'DodgerBlue',
  'FRBEDO08': 'Blue',//org//'LawnGreen',
  'FRBEDO08_cql': 'Blue',//org//'LawnGreen',
  'Fair': 'Blue',//org//'SandyBrown',
  'Pre-crisis models avg': 'Blue',
  // Selective post crisis
  'Post-crisis models avg': 'Red',
  'NKBGG': 'Red',//org//'Cyan',
  'QPM08': 'Red',//org//'DarkMagenta',
  'QPM08_cql': 'Red',//org//'DarkMagenta',
  'KR15_FF': 'Red',//org//'Blue',
  'KR15_FF_dy457': 'Red',//org//'Blue',
  'DNGS15': 'Red',//org//'Orange',
  'DNGS15_cql': 'Red',//org//'Orange',
  'DNGS15_ew': 'Red',//org//'Orange',
  'DNGS15_nofa': 'Red',//org//'Orange',
  'KR15_HH': 'Red',//org//'SpringGreen',
  'A16': 'Red',//org//'Teal',
  'CMR14': 'Red',//org//'Yellow',
  // Selective others
  'GLP3v': 'GreenYellow',
  'GLP5v': 'Salmon',
  'GLP8v': 'SkyBlue',

  'IN10': 'Red',//org//'Red',
  'GSW12': 'Blue',//org//'Cyan',
  'GSW12_cql': 'Blue',//org//'Cyan',
  // 'VI16_BGG': 'DodgerBlue',
  // 'VI16_GK': 'LawnGreen',
  'FU20': 'Blue',//org//'Teal',

  'VI16_BGG': 'Red',//org//'Red',
  'VI16_GK': 'Red',//org//'Blue',
  'VI16_BGG_new': 'Red',//org//'Red',
  'VI16_GK_new': 'Red',//org//'Blue',
};

const modelDash = {
  'SW07_ew': [10, 5],
  'FRBEDO08_cql': [10, 5],
  'QPM08_cql': [10, 5],
  'DNGS15_cql': [10, 5],
  'DNGS15_ew': [10, 5],
  'DNGS15_nofa': [10, 5],
  'KR15_FF_dy457': [10, 5],

  'GSW12_cql': [10, 5],

  'VI16_BGG': [10, 5],
  'VI16_GK': [10, 5],
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