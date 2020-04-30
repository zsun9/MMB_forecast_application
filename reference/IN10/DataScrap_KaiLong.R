# The API key for ALFRED is    52191461124b452b055bc68a63d07928
# devtools::install_github("sboysel/fredr")
library(fredr)
fredr_set_key("52191461124b452b055bc68a63d07928")


alfred_list <- c("PCEC96",
"PNFIC1",
"PRFIC1",
"TB3MS",
"IPDNBS",
"PAYEMS",
"USCONS",
"AWHMAN",
"AWHAECON",
"CES2000000008")




temp.vintagedates<- fredr_series_vintagedates(series_id = "PCEC96")
for (ii in 1:length(temp.vintagedates)){  # ii<-1
  PCEC96 <- fredr(series_id = "PCEC96", vintage_dates = as.Date(temp.vintagedates[[1]][ii]))

}

#PCESVC96.vintagedates[[1]][2]
#as.Date(df$Date, "%m/%d/%Y %H:%M:%S")
library(writexl)
write_xlsx(x = CNP16OV, path = "CNP16OV.xlsx", col_names = TRUE)
