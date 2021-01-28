# install.packages("devtools")
# library(devtools)
# devtools::install_github("sboysel/fredr")
rm(list = ls())

library(fredr)
library(writexl)
library(dplyr)
library(readxl)
fredr_set_key("52191461124b452b055bc68a63d07928")
ref.vin.date <- as.Date("2012-12-31")
source("UtilityFunctions.R")
DATE1 <- as.Date("1983-01-01") # 1983Q1
DATE2 <- as.Date("2008-09-30")  # 2008Q3  
########
# special definiation for real house prices due to data structure
data_ind <- 1    # 0 or 1, 0 means data length according to availbility, 
                 # 1 means data length is defined as between DATE1 and DATE2 
datalist <- list()


#== Inflation ===========
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "GDPCTPI")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data <- as.data.frame(fredr_series_observations(series_id = "GDPCTPI", frequency = "q", vintage_dates = closest_date))
series.data$date <- as.Date(series.data$date)
series.data[,3] = log(series.data[,3])
series.data[-1,3] = diff(series.data[,3])
series.data[1,3] = NA
#series.data[,3] = series.data[,3]*100
#series.data[,3] = log(series.data[,3])


inf_p = betweendates(DATE1,DATE2,series.data)
inf_p[,3] = inf_p[,3] - mean(inf_p[,3])

datalist[["inf_p"]] <- inf_p
write_xlsx(datalist, path = "datalist.xlsx", col_names = TRUE)

# index 2005Q4=100
series.data <- as.data.frame(read_excel("GDPCTPIindex2005.xls",sheet = "FRED"))
series.data$date <- as.Date(series.data$date)
series.data[,2] = log(series.data[,2])
series.data[-1,2] = diff(series.data[,2])
series.data[1,2] = NA
inf_p = betweendates(DATE1,DATE2,series.data)
inf_p[,2] = inf_p[,2] - mean(inf_p[,2])

datalist[["inf_p"]] <- inf_p
write_xlsx(datalist, path = "datalist.xlsx", col_names = TRUE)



#== fed fund rate ====
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "DFF")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data <- as.data.frame(fredr_series_observations(series_id = "DFF", frequency = "q", vintage_dates = closest_date))
series.data$date <- as.Date(series.data$date)
series.data[,3] = log(series.data[,3])
R = betweendates(DATE1,DATE2,series.data)

#== Nominal wage ======
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "COMPNFB")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data1 <- as.data.frame(fredr_series_observations(series_id = "COMPNFB", frequency = "q", vintage_dates = closest_date))
series.data1$date <- as.Date(series.data1$date)

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "GDPCTPI")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data2 <- as.data.frame(fredr_series_observations(series_id = "GDPCTPI", frequency = "q", vintage_dates = closest_date))
series.data2$date <- as.Date(series.data2$date)

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "CNP16OV")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data3 <- as.data.frame(fredr_series_observations(series_id = "CNP16OV", frequency = "q", vintage_dates = closest_date))
series.data3$date <- as.Date(series.data3$date)

series.data=inner_join(series.data1, series.data2, by = "date", copy = FALSE, suffix = c(".x", ".y"))
series.data=inner_join(series.data, series.data3, by = "date", copy = FALSE, suffix = c("", ".z"))

series.data[, "value"] = series.data[, "value"]/series.data[series.data$date == "2005-10-01","value"]

w_dataset = betweendates(DATE1,DATE2,series.data)
w_obs = cbind(w_dataset$date, log(w_dataset$value.x/(w_dataset$value.y*w_dataset$value)))

series.data[,3] = log(series.data[,3])

#== hours worked, lp ==========

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "PRS85006023")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data <- as.data.frame(fredr_series_observations(series_id = "PRS85006023", frequency = "q", vintage_dates = closest_date))
series.data$date <- as.Date(series.data$date)
series.data[,3] = log(series.data[,3])
lp = betweendates(DATE1,DATE2,series.data)
lp[,3] = lp[,3] - mean(lp[,3])


# use data adjusted to index 2005=100
series.data <- as.data.frame(read_excel("PRS85006023index2005.xls",sheet = "FRED"))
series.data$date <- as.Date(series.data$date)
series.data[,2] = log(series.data[,2])
lp = betweendates(DATE1,DATE2,series.data)
lp[,2] = lp[,2] - mean(lp[,2])


#== Gov expenditure =========
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "A957RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data1 <- as.data.frame(fredr_series_observations(series_id = "A957RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data1$date <- as.Date(series.data1$date)

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "A787RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data2 <- as.data.frame(fredr_series_observations(series_id = "A787RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data2$date <- as.Date(series.data2$date)

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "AD08RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data3 <- as.data.frame(fredr_series_observations(series_id = "AD08RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data3$date <- as.Date(series.data3$date)

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "A918RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data4 <- as.data.frame(fredr_series_observations(series_id = "A918RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data4$date <- as.Date(series.data4$date)

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "CNP16OV")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data5 <- as.data.frame(fredr_series_observations(series_id = "CNP16OV", frequency = "q", vintage_dates = closest_date))
series.data5$date <- as.Date(series.data5$date)
series.data5[, "value"] = series.data5[, "value"]/series.data5[series.data5$date == "2005-10-01","value"]

series.data6 <- as.data.frame(read_excel("GDPCTPIindex2005.xls",sheet = "FRED"))
series.data6$date <- as.Date(series.data6$date)



series.data=inner_join(series.data1, series.data2, by = "date", copy = FALSE, suffix = c(".A957RC1Q027SBEA", ".A787RC1Q027SBEA"))
series.data=inner_join(series.data, series.data3, by = "date", copy = FALSE, suffix = c("", ".AD08RC1Q027SBEA"))
series.data=inner_join(series.data, series.data4, by = "date", copy = FALSE, suffix = c("", ".A918RC1Q027SBEA"))
series.data=inner_join(series.data, series.data5, by = "date", copy = FALSE, suffix = c("", ".CNP16OV"))
series.data=inner_join(series.data, series.data6, by = "date", copy = FALSE, suffix = c("", ".GDPCTPI"))

#g_dataset = betweendates(DATE1,DATE2,series.data)
g_dataset=series.data
g_obs = cbind.data.frame("date" = g_dataset$date, "value" = log(g_dataset$value.A957RC1Q027SBEA+g_dataset$value.A787RC1Q027SBEA+g_dataset$value-g_dataset$value.A918RC1Q027SBEA)/(g_dataset$value.CNP16OV*g_dataset$GDPCTPI_NBD20051001))
g_obs[-1,2] = diff(g_obs[,2])
g_obs = betweendates(DATE1,DATE2,g_obs)
g_obs[,2] = g_obs[,2] - mean(g_obs[,2])

#datalist <- list()
datalist[["g_obs"]] <- g_obs

#=== c_obs =======



#===== Write list to excel ========================
write_xlsx(datalist, path = "datalist.xlsx", col_names = TRUE)

