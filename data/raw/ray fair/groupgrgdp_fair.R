library(readxl)
library(writexl)
library(janitor)
#library(dplyr)
library(stringr) # For str_trim 

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

main.data <- as.data.frame(read_excel("grgdp.xlsx"))


# rearrange the data into presentation format
main.data1 <- matrix(,nrow(main.data),ncol(main.data))
for (ind0 in 1:nrow(main.data)) { 
  count_ind = 0
  for (ind1 in 1:ncol(main.data)-1) {

    if (is.na(main.data[ind0,ind1+1])) {
      } else {
        count_ind = 1 + count_ind
        main.data1[ind0,count_ind] <- main.data[ind0,ind1+1]
      }
  }
}
 
main.data1 <- remove_empty(main.data1, which = c("rows", "cols"), quiet = TRUE) # delete entirely NA columns and rows
main.data1 <- as.data.frame(main.data1)

#generate column names
steps <- ncol(main.data1) -2
names0 <- vector()
for (ind2 in 1:steps) {
  names0[ind2] <- paste0("step", ind2)
}
names <- c("date", "nowcast", names0)
colnames(main.data1) <- names


# # restrcture the dates
# tmpsplit <- vector(mode = "list") 
# for (ind4 in 1:nrow(main.data1)) {
#   tmpsplit <- vector(mode = "list") 
#   tmpsplit <- strsplit(as.character(main.data1[ind4,1]), " ")
#   tmpsplit <- unlist(tmpsplit)
#   tmpsplit <- tmpsplit[-1]
#   main.data1[ind4,1] <- paste(tmpsplit,  sep = '' ,collapse = '')
#   
#   
# 
# }


# print out excel
write_xlsx(main.data1, path = "rayfairgrgdp.xlsx", col_names = TRUE)

