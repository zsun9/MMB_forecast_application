* Replication of calculations of Financing Gap Share for "Financial Intermediation, Investment Dynamics and Business Cycle Fluctuations"
* by Andrea Ajello

clear all

set matsize 800

* Download the following variables from Compustat Quarterly Files:

* gvkey fqtr fyr datacqtr datafqtr capxy 
* chechy dvy fincfy fopty ivncfy oancfy fic sic 

* Store the dataset as Compustat_File.csv.
* Change directory so that you are running this code in the folder 
* that contains the Compustat file in csv format.

cd "...\FGS_Compustat"

* Read the dataset using the following:

insheet using Compustat_File.csv

* And save it in dat format for future use
save Compustat_File.dta, replace

* Decide whether (1) or not (0) you want to keep data past 2008Q1
global past2008 1

use Compustat_File.dta

** Format dates and clean dataset

* Generate quarter and country indicator
encode datacqtr, gen(qq)
encode datafqtr, gen(fq)
gen    date = qq
encode fic, gen(country)
destring sic, replace

split datacqtr , p("Q")
rename datacqtr1 cyear //create year string
rename datacqtr2 cqtr //create quarter string
destring cyear, replace
destring cqtr, replace

* Drop financial firms and government
drop if (sic>5999 & sic<=6799) | (sic>8999)

* Drop non-US Firms (!! Careful, the country code number for the U.S. can change in different data releases from Compustat !!)
*drop if country != 62
keep if fic == "USA"

* Drop observation if either calendar or fiscal dates are missing
drop if qq == .
drop if fq == .

* Define Operating Cash Flow (cf)
gen cflow = oancfy
replace cflow = fopty if oancfy == . 
replace cflow = fopty + oancfy if fopty != . & oancfy != .
sort gvkey fyear fqtr
gen gvkey_lag = gvkey[_n-1]

* Define lagged year variable
sort gvkey fyear fqtr
gen fy_lag = fyear[_n-1]

* Check that cash-flow identity holds
gen check  = chechy - cflow - ivncfy - fincfy
gen check2 = (cflow - capxy - dvy) - (chechy + (-ivncfy - capxy) + (-fincfy - dvy))

** Analysis

* Change variables of interest from year-to-date to quarterly

* 1. Make CAPXY quarterly (Capital Expenditures)
sort gvkey fyear fqtr
by gvkey fyear: gen capx_lag = capxy[_n-1]
replace capx_lag = 0 if fyear != fy_lag & gvkey == gvkey_lag
replace capx_lag = 0 if gvkey != gvkey_lag
by gvkey fyear: replace capx_lag = capx_lag[_n-1] if capx_lag == .
by gvkey fyear: gen capx_q = capxy - capx_lag if fyear == fy_lag & gvkey == gvkey_lag
replace capx_q = capxy if fyear != fy_lag | gvkey != gvkey_lag

* 2. Make Operating Cash Flow quarterly:
sort gvkey fyear fqtr
by gvkey fyear: gen cf_lag = cflow[_n-1]
replace cf_lag = 0 if fyear != fy_lag & gvkey == gvkey_lag
replace cf_lag = 0 if gvkey != gvkey_lag
by gvkey fyear: replace cf_lag = cf_lag[_n-1] if cf_lag == .
by gvkey fyear: gen cf_q = cflow - cf_lag if fyear == fy_lag & gvkey == gvkey_lag
replace cf_q = cflow if fyear != fy_lag | gvkey != gvkey_lag

* 3. Make dividends DVY quarterly
sort gvkey fyear fqtr
by gvkey fyear: gen dvy_lag = dvy[_n-1]
replace dvy_lag = 0 if fyear != fy_lag & gvkey == gvkey_lag
replace dvy_lag = 0 if gvkey != gvkey_lag
by gvkey fyear: replace dvy_lag = dvy_lag[_n-1] if dvy_lag == .
by gvkey fyear: generate dv_q = dvy - dvy_lag if fyear == fy_lag & gvkey == gvkey_lag
replace dv_q = dvy if fyear != fy_lag | gvkey != gvkey_lag
replace dv_q = 0 if dv_q==.

* 4. Make Financial Cash Flow quarterly:
sort gvkey fyear fqtr
by gvkey fyear: gen fincf_lag = fincfy[_n-1]
replace fincf_lag = 0 if fyear != fy_lag & gvkey == gvkey_lag
replace fincf_lag = 0 if gvkey != gvkey_lag
by gvkey fyear: replace fincf_lag = fincf_lag[_n-1] if fincf_lag == .
by gvkey fyear: gen fincf_q = fincfy - fincf_lag if fyear == fy_lag & gvkey == gvkey_lag
replace fincf_q = fincfy if fyear != fy_lag | gvkey != gvkey_lag

* 5. Make Net investment cash flow quarterly:
sort gvkey fyear fqtr
by gvkey fyear: gen ivncf_lag = ivncfy[_n-1]
replace ivncf_lag = 0 if fyear != fy_lag & gvkey == gvkey_lag
replace ivncf_lag = 0 if gvkey != gvkey_lag
by gvkey fyear: replace ivncf_lag = ivncf_lag[_n-1] if ivncf_lag == .
by gvkey fyear: gen ivncf_q = ivncfy - ivncf_lag if fyear == fy_lag & gvkey == gvkey_lag
replace ivncf_q = ivncfy if fyear != fy_lag | gvkey != gvkey_lag

* 6. make Cash Holdings CHECHY quarterly
sort gvkey fyear fqtr
by gvkey fyear: gen chechy_lag = chechy[_n-1]
replace chechy_lag = 0 if fyear != fy_lag & gvkey == gvkey_lag
replace chechy_lag = 0 if gvkey != gvkey_lag
by gvkey fyear: replace chechy_lag = chechy_lag[_n-1] if chechy_lag == .
by gvkey fyear: gen chechy_q = chechy - chechy_lag if fyear == fy_lag & gvkey == gvkey_lag
replace chechy_q = chechy if fyear != fy_lag | gvkey != gvkey_lag

* 7. Define numerator of FGS and FGSEXDIV (it can be positive [surplus] or negative [gap])
gen fin_need_d = cf_q - capx_q - dv_q
gen fin_need = cf_q - capx_q

* 8. Define Financing Gap (negative entries)
gen fin_need_d_neg = fin_need_d if fin_need_d < 0 
* FG EXDIV
gen fin_need_neg = fin_need if fin_need < 0

* 9. External funding sources net of dividends paid
gen fincf_d_q = - fincf_q - dv_q

* 10. Net Financial Investment (Total investment net of Capital Expenditures)
gen nfi_qq = - (ivncf_q + capx_q)
* Net Financial Investment if FG < 0
gen nfi_q_d_neg    = nfi_qq     if fin_need_d < 0

* 12. Net Cash Variation if FG < 0
gen chechy_q_d_neg = chechy_q    if fin_need_d < 0

* 13. Net Financial Cash Flow if FG < 0
gen fincf_q_d_neg  = fincf_d_q   if fin_need_d < 0

* 14. Dividends if FG < 0
gen dv_q_neg       = dv_q        if fin_need_d < 0

* 15. Working Capital Needs (Negative Operating Cash Flows) if FG < 0
gen cflow_neg      = cf_q       if (cf_q < 0 & fin_need_d < 0)

* 16. Which firms have a negative financing gap?
gen indi_dv = 0
replace indi_dv = 1 if fin_need_d < 0

* 17. Count all entries and all entries with a non-missing financing gap.
gen ind = 1
gen ini = 1 if fin_need_d < .
gen ind_miss = 1 if fin_need_d_neg == .

* Select relevant sample period 1989Q1 - 2008Q2 (leave one extra quarter at the
* beginning for calculating quarterly growth rates), option to leave data past
* 2008Q2 is made at top of this do file. 
drop if cyear < 1988
drop if cyear == 1988 & cqtr < 4
if !$past2008 {
    drop if cyear >= 2009
    drop if cyear >= 2008 & cqtr > 2
}

* Collapse dataset by quarter

collapse (rawsum) fin_need_d_neg cflow_neg capx_q fin_need_neg nfi_q_d_neg chechy_q_d_neg indi_dv ind (mean) cyear cqtr, by(qq)
 
gen fgs1     = (abs(fin_need_d_neg) - abs(cflow_neg))/capx_q
gen fgsexdiv = (abs(fin_need_neg) - abs(cflow_neg))/capx_q
gen wks      = (-(cflow_neg)/abs(fin_need_d_neg))
gen liqs     = (-(nfi_q_d_neg + chechy_q_d_neg)/abs(fin_need_d_neg))
gen cash     = (-(chechy_q_d_neg)/abs(fin_need_d_neg))
gen fraction = indi_dv/ind
gen date     = cyear + (cqtr-1)/4
gen fg       = abs(fin_need_d_neg) - abs(cflow_neg)

save FGS_Ajello_output.dta, replace

outsheet qq fgs1 fgsexdiv wks liqs cash fraction capx_q fg date using FGS_Ajello_output.csv, comma replace
