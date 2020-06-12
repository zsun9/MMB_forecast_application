library(readxl)
main.data <- as.data.frame(read_excel("individual_rgdp.xlsx"))

# all values in log, i.e. growth rate
nowcast <- log(as.numeric(main.data$RGDP2)) - log(as.numeric(main.data$RGDP1))
step1 <- log(as.numeric(main.data$RGDP3)) - log(as.numeric(main.data$RGDP1))
step2 <- log(as.numeric(main.data$RGDP4)) - log(as.numeric(main.data$RGDP1))
step3 <- log(as.numeric(main.data$RGDP5)) - log(as.numeric(main.data$RGDP1))
step4 <- log(as.numeric(main.data$RGDP6)) - log(as.numeric(main.data$RGDP1))

# define spf deadlines
# merge it back
rgdpgrowthdat <- cbind( "Year" = main.data$YEAR, "quater" =  main.data$QUARTER , "id" = main.data$ID , "Last quater" =  log(as.numeric(main.data$RGDP1)), nowcast,  step1 ,  step2,
                       step3,step4 )




