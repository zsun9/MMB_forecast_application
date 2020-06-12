rm(list = ls())
library(stringr) # For str_trim 
library(rlist)
library(readxl)
library(writexl)
library(sjmisc)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# Read string data and split into data frame
dat = readLines("grgdp_fair.txt")
dict.data <- strsplit(dat, split=" {2,10}")


# clean the negative values
for (ind_0 in 1:length(dict.data)){ 
  if (str_contains(dict.data[[ind_0]], " -", ignore.case = FALSE, logic = NULL, switch = FALSE)) {
    ind_000 <- 1
    while (ind_000 < length(dict.data[[ind_0]])+0.7) {
      if (str_contains(dict.data[[ind_0]][ind_000], " -", ignore.case = FALSE, logic = NULL, switch = FALSE)) {
        dict.data[[ind_0]][ind_000] <- strsplit(dict.data[[ind_0]][ind_000], " ")
        dict.data[[ind_0]]<-unlist(dict.data[[ind_0]], use.names=FALSE)
        ind_000 <- 1
      } else {
          ind_000 <- ind_000 + 1
          }
      }
    }
} 


# data reading algorithm
data_list <- vector(mode = "list")
column_storage<- vector()
actual_storage<- vector()
long_column <- vector()
ind_count <- 0
cop_ind = 0
change_ind = 0
for (ind_1 in 1:length(dict.data)) { 
  if (any(grepl("Predicted and Actual",dict.data[[ind_1]],fixed=TRUE), na.rm = FALSE)){
   change_ind <- 1 }
   if (change_ind == 1) {
     column_storage<- vector()
     actual_storage<- vector()
     column_storage <- dict.data[[ind_1+2]]  #how many columns starts the column id after the indicator "Predicted and Actual"?
     column_storage <- column_storage[column_storage != ""]
     actual_storage <- dict.data[[ind_1+4]] #how many columns starts the actual values after the indicator "Predicted and Actual"?
     actual_storage <- actual_storage[actual_storage != ""]
     actual_storage <- actual_storage[-1]
     }
   change_ind <- 0
  
  if (any(grepl("Forecast Dated:",dict.data[[ind_1]],fixed=TRUE), na.rm = FALSE)){
    cop_ind = 1} else if ( length(dict.data[[ind_1]]) == 0) {cop_ind = 0} 

  if (cop_ind > 0.5){ cop_ind = cop_ind + 1 }
  if (cop_ind > 2.5) {
    if (nchar(dict.data[[ind_1]][1], type = "chars", allowNA = FALSE, keepNA = NA) < 6) {
      dict.data[[ind_1]][1]<-paste0(dict.data[[ind_1]][1]," ",dict.data[[ind_1]][2])
    }
    
    #list_name <- gsub( " .*$", "", dict.data[[ind_1]])[1]
    tmpmat <- matrix(, nrow = 3, ncol = length(column_storage))
    tmpmat[1,] <- column_storage
    long_column <- c(long_column, column_storage)
    for (tmp_001 in 1:length(actual_storage)) {
      tmpmat[2,tmp_001] <- actual_storage[tmp_001]
    }
    for (ind_2 in 1: length(dict.data[[ind_1]])){
      if ( nchar(dict.data[[ind_1]][length(dict.data[[ind_1]])-ind_2+1], type = "chars", allowNA = FALSE, keepNA = NA) == 0 | nchar(dict.data[[ind_1]][length(dict.data[[ind_1]])-ind_2+1], type = "chars", allowNA = FALSE, keepNA = NA) > 7){break}
      tmpmat[3,length(column_storage)-ind_2+1] = dict.data[[ind_1]][length(dict.data[[ind_1]])-ind_2+1]
      }
    data_list[[dict.data[[ind_1]][1]]]<- as.data.frame(tmpmat)

    } 
}


# arrange them in Excel format (triangular type of report)
column_code <- unique(long_column)
row_name <- names(data_list)
row_actual <- vector()
final_data <- as.data.frame(matrix(nrow = length(row_name), ncol = length(column_code) ))
colnames(final_data) <- column_code
rownames(final_data) <- row_name
for (ind_row in 1:length(row_name)){
  for (ind_column in 1:length(column_code)){
  tmp_v1 <- as.character(data_list[[ind_row]][,data_list[[ind_row]][1,] == column_code[ind_column]])
  final_data[ind_row,ind_column] <- tmp_v1[3]
  }
}

final_data1 <- cbind("Date" = row_name , final_data )

# # get the Actual data
# actual_data_frame <- as.data.frame(matrix(nrow = 2, ncol = length(column_code) ))
# actual_data_frame[1,] <- column_code
# for (id in 1:length(column_code)) {
#   for (id_1 in 1:length(data_list)) {
#     if ( as.vector(data_list[[id_1]][1,])  == as.vector(column_code[id]) ) {
#     }
#     tmp_v2 <- as.character(data_list[[id_1]][,data_list[[id_1]][1,] == column_code[id]])
# 
#   }
# }

  
write_xlsx(final_data1, path = "grgdp.xlsx", col_names = TRUE)
  
  
  