path <- getwd()
library(data.table)
library(dplyr)
#Getting the different documents into our program

data1 <- read.table(file.path(path, "/UCI HAR Dataset/test/X_test.txt"))
data1y <- read.table(file.path(path, "/UCI HAR Dataset/test/y_test.txt"))
data2 <- read.table(file.path(path, "/UCI HAR Dataset/train/X_train.txt"))
data2y <- read.table(file.path(path, "/UCI HAR Dataset/train/y_train.txt"))
features <- read.table(file.path(path, "/UCI HAR Dataset/features.txt"))
subjecttrain <- read.table(file.path(path, "/UCI HAR Dataset/train/subject_train.txt"))
subjecttest <- read.table(file.path(path, "/UCI HAR Dataset/test/subject_test.txt"))
activitynames <- read.table(file.path(path, "/UCI HAR Dataset/activity_labels.txt"))

# Working with the files and creating some intermediary data frames
colnames(data1) = features$V2
colnames(data2) = features$V2

#Selecting the columns that I want from DATA1 
numbers <- grep("mean", colnames(data1))
datamean <- data1[,numbers]
numbers2 <- grep("std", colnames(data1))
datstd <- data1[,numbers2]
numbers3 <- grep("Mean", colnames(data1))
dataMean <- data1[,numbers3]
datafinaltest <- cbind(datamean, datstd, dataMean)
datafinaltest <- cbind(data1y, datafinaltest)
datafinaltest <- merge(activitynames, datafinaltest, by.x = "V1", by.y = "V1")
datafinaltest <- rename(datafinaltest, Activity = V2)
datafinaltest <- select(datafinaltest, -V1)

#Selecting the columns that I want from Data2
number <- grep("mean", colnames(data2))
datamea <- data2[,number]
number2 <- grep("std", colnames(data2))
datst <- data2[,number2]
number3 <- grep("Mean", colnames(data2))
dataMea <- data2[,number3]
datafinaltrain <- cbind(datamea, datst, dataMea)
datafinaltrain <- cbind(data2y, datafinaltrain)
datafinaltrain <- merge(activitynames, datafinaltrain, by.x = "V1", by.y = "V1")
datafinaltrain <- rename(datafinaltrain, Activity = V2)
datafinaltrain <- select(datafinaltrain, -V1)

#Joining the subjects 
datafinaltest <- cbind(subjecttest, datafinaltest)
datafinaltest <- rename(datafinaltest, Subject = V1)
datafinaltrain <- cbind(subjecttrain, datafinaltrain)
datafinaltrain <- rename(datafinaltrain, Subject = V1)

#Binding both Data Sets 
datafinal <- rbind(datafinaltest, datafinaltrain)

#Obtaining the mean and standard deviation of each element of DATAFINAL
finaldataset <- datafinal %>% 
  group_by(Subject, Activity) %>%
  summarise(across(everything(), mean))
