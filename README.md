## Model Implementation Guidance

**Please report any issues and/or mistakes in the 'Issues' section above!**

**The addition of SPF data is not discussed yet!**

### Read the paper

- Download the paper + online appendix + data files + programming files, and store them in the 'Reference' folder
- Read through the paper and code, and create a *readme file* to record the following information: Short summary of the paper, Short summary of the model(s), Common observables, Unique observables
- Specify how the unique observables are constructed (if any)
- Highlight any other specific features of the model (e.g., whether the estimation method is non-standard)

### Collect and transform the data

- For unique observables, download the corresponding raw data series to the 'Data/Raw' folder
- Record the following information for the raw data series: Data ID, Title, Frequency, Units, Seasonal adjustment, Is revised, Vintage Dates, Source, Source_URL
- For a specific vintage date (e.g., 2008Q3), create a new Excel file (or merge into an existing file) to include all the raw data series and all the observables respectively

### Update the code and generate forecasts (subject to change)

- Start from reivising the Dynare MOD-file, such as changing the name of the observables
- If the MOD file runs smoothly, then check whether the forecasts makes sense (e.g., you can compare the results you obtained with the ones from the paper)
- If some issues cannot be resolved easily, report them in the 'Issues' section
- Once everything look okay, set a loop in Matlab to run estimations and generate forecasts automatically
