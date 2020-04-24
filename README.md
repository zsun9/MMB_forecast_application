## Model Implementation Guidance

**Please report any issues and/or mistakes in the 'Issues' section above!**

**The addition of SPF data is not discussed yet!**

### Read the paper

- Download the original paper + online appendix + data files + programming files, and store them in the 'Reference' folder
- Read through the paper and code, and create a *readme file* to record the following information: Title, Authors, Publication information, Summary of the paper, Summary of the model(s), Common observables, Unique observables
- Specify how unique observables are constructed (if any)
- Highlight any other specific features of the model (e.g., whether the estimation method is non-standard)
- A **readme template** can be found in the root folder

### Collect and transform data

- Download the time series for the original paper, and check which series are already included in our database 
- For series that are not yet included in the database, download the corresponding raw data series to the 'Data/Raw' folder
- It is strongly encouraged to use an API to collect the raw data series
- Record the following information for the raw data series: Data ID, Title, Frequency, Units, Seasonal adjustment, Is revised, Vintage Dates, Source, Source_URL
- Please make sure you described how the construct new observables from new raw data series in the *readme file*
- For a specific vintage date, build up two spreadsheets to include all the raw data series and all the observables respectively

### Update the code and generate forecasts (subject to change)

- Create a copy of the MATLAB code and revise your code there first
- If the code runs smoothly, then check the forecasts to see whether it makes sense (e.g., you can compare the results you obtained with the ones from the paper)
- If you run into some problems, try to tweak the mode estimation and Bayesian estimation commands
- If there is still unresolved issues, report them in the 'Issues' section
- Once everything look okay, you can set a loop to let your PC run the code
