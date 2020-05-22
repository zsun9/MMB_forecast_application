## Model Implementation Guide

### Naming conventions

- Models

  Name a model by the initials of the last names of all the authors plus the paper publication date. For example, we name the model from Smets and Wouters (2007) as *SW07*.

- Raw variables

  If possible, keep the original names of the raw variables unchanged. Always define the name of raw variable in capital letters.
  
- Observables

  An observed variable should be usually named as *ObservableName[_Type]_obs[_ModelName]*.
  
  At the minimum, the name of an observables should contain two parts: *ObservableName* and *_obs*. For example, we name the Federal funds rate as *ffr_obs*.
  
  For observables that essentially represent the same concept but do not share the exact same definition, name each of them by including a *[_Type]*. This is applied to the naming of most macroeconomic variables from the national accounts, since we usually need them in both nominal and real terms.
  
  For example, name personal consumption expenditures (PCE) as follows:
  - Nominal PCE: *pce_nom_obs*
  - Nominal PCE deflated by the GDP deflator: *pce_rgd_obs* (*rgd = real, gdp deflator*)
  - Nominal PCE deflated by its own implicit deflator: *pce_rid_obs* (*rid = real, implicit deflator*)
  
  Note: it makes no difference whether to name the real GDP as *gdp_rgd_obs* or *gdp_rid_obs*, but the former one is preferred.
  
  It is acceptable to name an observable that only appears in one model by including *[_ModelName]*. However, such a name should be avoided, especially when this observable might appear in other models that will be implemented in the future.

### Notes for data collection and transformation

- Please be careful when selecting a variable on the ALFRED, because sometimes variables that have similar definitions do not have clear and distinguishable IDs.
- In particular, pay attention to **whether this variable is in real or nominal terms**, and **whether it is seasonally adjusted or not**.
- If the ALFRED contains the several variants of the same observable that are only different in updating frequencies, please **choose the one that is updated on the highest frequency**.
- Many observables in our database are in net percentage terms, but in some models, observables are expressed in gross terms. Use the following formula to convert between them: **GrossTerms = EXP(NetPctTerms/100)**.

### General steps

#### Read paper

- Download the paper + online appendix + data files + programming files, and save them to a new subfolder in the 'Reference' folder
- Read through the paper and code, and create a *readme file* to record the following information:
  1. Short summary of the paper
  2. Short summary of the model(s)
  3. Common observables and unique observables
  4. Any other non-standard features of the model

#### Collect and transform data

- Create a spreadsheet named *'data_comparison_ModelName.xlsx'* to compare the data from the paper with the data you construct
- It is highly recommended to use the observables already included in our database rather than constructing a new one, given that the new one will have the same (or very similar) definition as the old one.
- For observables that are not included in our database yet: Download the corresponding raw variables, record the basic information of the raw variables and observables, and update the Python code to include the data transformation process

#### Estimation and forecast generation test

- Revise the dynare MOD-file, the steady-state file, and any auxillary file(s) if necessary
- Check whether (1) the data for a specific vintage date can be obtained, (2) the model can be estimated, and (3) the forecasts can be generated without any problem
- If everything runs smoothly, then store all the relevant files (excluding data files) in a new subfolder in the 'Models' folder
