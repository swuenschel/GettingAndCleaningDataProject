#download files to current directory and run analysis

print("Downloading file.")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              "input.zip", method = "curl")

print("Unzipping downloaded file.")
unzip("input.zip")
unlink("input.zip")

print("Runing analysis.")
source("run_analysis.R") 
setwd("../")