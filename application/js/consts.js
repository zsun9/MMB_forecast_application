const modelColors = {
  // Always appear
  'SPFMean': 'Green',
  'SPFIndividual': 'rgba(0, 0, 0, 0.1)',
  // Selective
  'DS04': 'Red',
  'WW11': 'Fuchsia',
  'SW07': 'DodgerBlue',
  'NKBGG': 'Cyan',
  'DNGS15': 'Orange',
  'DNGS15_cql': 'Orange',
  'FRBEDO08': 'LawnGreen',
  'QPM08': 'DarkMagenta',
  'QPM08_cql': 'DarkMagenta',
  'GLP3v': 'GreenYellow',
  'GLP8v': 'DarkCyan',
  'KR15_FF': 'Blue',
  'Fair': 'Gold',
};

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