'---------------------------------------------------------------------------------------------------
' File: fgs_ajello_seasonadjust.m                                                                     
'                                                                           
' Description: This code seasonally adjusts the Compustat data used in 
' Ajello's ``Financial Intermediation, Investment Dynamics and Business 
' Cycle Fluctuations.''    
'                                                                           
' Input: A csv file (FGS_Ajello_output.csv) containing 
'          Compustat data, which has been cleaned in 
'          FGS_Ajello_AER16.do                                                        
' Output: A csv file, FGS_AJELLO_SA.csv                                       
'                                                                           
' Author: Miguel Acosta                                                     
'----------------------------------------------------------------------------------------------------


' Set the directory where the Compustat data is located/where you want to save the seasonally adjust data
cd  "Z:\path\to\compustat\data\"

' Set the file name of the input data (what comes out of FGS_Compustat_12215.do)
%filename = "FGS_Ajello_output.csv"

' Import the data 
import %filename @freq q 1988Q4

' Seasonally adjust series using the Census X12 (additive) method (mode = a).
cash.x12(mode = a)
fgs1.x12(mode = a)
fgsexdiv.x12(mode = a)
liqs.x12(mode = a)
wks.x12(mode = a)
capx_q.x12(mode = a)
fg.x12(mode = a)

' Output the data. 
write(t=txt,na=.,d=c,dates) FGS_AJELLO_SA.csv fgs1_sa fgsexdiv_sa cash_sa liqs_sa wks_sa fraction capx_q_sa fg_sa date


