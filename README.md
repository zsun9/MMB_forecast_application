## Model Implementation Guidance

**Please report any issues and/or mistakes in the 'Issues' section above!**

**The addition of SPF data is not discussed yet!**

### Read the paper

- Download the paper + online appendix + data files + programming files, and store them in the 'Reference' folder
- Read through the paper and code, and create a *readme file* to record the following information:
1. Short summary of the paper
2. Short summary of the model(s)
3. Common observables and unique observables
4. Any other non-standard features of the paper or model

### Collect and transform the data

- Create a spreadsheet named *'data_comparison_ModelName.xlsx'* to compare those observed variables constructed by the authors and those constructed by us
- Please use the observables we construct as many as possible; Notice that some observables in the paper can be easily transformed to those observables we construct
- For observables that are not included yet, first download the raw data series to the 'data/raw_variables' folder, then record the basic information of the raw series in *'raw_variable_description.csv'*, and record the basic information of the observables in *'observed_variable_description.xlsx'*
- Update *'data_collection.ipynb'* and *'vintage_generation.ipynb'* or your own code to include the new data collection and transformation process

### Estimation and forecast generation test

- Create an Excel file named *data_ModelName_VintageDate.xlsx* to include all the observed variables for a specific vintage
- Revise the original dynare MOD-file, such as changing the name of the observables
- Estimate the model and generate forecasts using the data file you created
- If some issues cannot be resolved easily, report them in the 'Issues' section
