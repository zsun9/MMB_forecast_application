library(readxl)
library(dplyr)
library(writexl)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

main.data <- as.data.frame(read_excel("individual_rgdp.xlsx"))

main.data <-  main.data %>% group_by(ID) %>% arrange(YEAR, QUARTER, .by_group = TRUE) #%>% arrange(QUARTER, .by_group = TRUE)

# all values in log, i.e. growth rate
nowcast <- (log(as.numeric(main.data$RGDP2)) - log(as.numeric(main.data$RGDP1)))
step1 <- log(as.numeric(main.data$RGDP3)) - log(as.numeric(main.data$RGDP1))*4/2
step2 <- log(as.numeric(main.data$RGDP4)) - log(as.numeric(main.data$RGDP1))*4/3
step3 <- log(as.numeric(main.data$RGDP5)) - log(as.numeric(main.data$RGDP1))*4/4
step4 <- log(as.numeric(main.data$RGDP6)) - log(as.numeric(main.data$RGDP1))*4/5


# define spf deadlines




# merge it back
rgdpgrowthdat <- cbind( "Year" = main.data$YEAR, "quater" =  main.data$QUARTER , "id" = main.data$ID , "Last quater" =  log(as.numeric(main.data$RGDP1)), nowcast,  step1 ,  step2,
                       step3,step4 )

rgdpgrowthdat <- as.data.frame(rgdpgrowthdat)

write_xlsx(rgdpgrowthdat, path = "spf_rggdp_sorted.xlsx", col_names = TRUE)

