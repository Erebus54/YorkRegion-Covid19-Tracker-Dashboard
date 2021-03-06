library(lubridate)
library(data.table)
library(dplyr)
library(beepr)


#grab file 
loc <- "https://data.ontario.ca/dataset/f4112442-bdc8-45d2-be3c-12efae72fb27/resource/455fd63b-603d-4608-8216-7d8647f43350/download/conposcovidloc.csv"
casestatus <- fread(input = loc, encoding = 'UTF-8',data.table = F)

#data dict URL 
#https://data.ontario.ca/dataset/status-of-covid-19-cases-in-ontario
#end_time <- Sys.time()
#end_time - start_time


#clean CaseStatus file
casestatus$Accurate_Episode_Date <- as.Date(casestatus$Accurate_Episode_Date)
casestatus$Case_Reported_Date <- as.Date(casestatus$Case_Reported_Date)
casestatus$Test_Reported_Date <- as.Date(casestatus$Test_Reported_Date)

target <- "York Region Public Health Services"

casestatus <- casestatus %>% 
  dplyr::filter(Reporting_PHU == target) %>% 
  dplyr::arrange(Case_Reported_Date) 

#create .csv for each date of dataset
dirPath <- paste(getwd(), "/datasets/", sep = "")


fileName = paste(dirPath, 'casestatus.rds',sep = '')



#Write Case Status File
saveRDS(casestatus, file = fileName)


print(paste("casestatus.csv has been dowloaded",
            nrow(casestatus), "Rows x ", ncol(casestatus), "Columns",  
            sep = " ")
)

beep(sound = 1, expr = NULL)

print(paste("Download Completed"))
remove(list = ls())
