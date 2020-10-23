path <- getwd()
library(data.table)

#Getting the different documents into our program

data1 <- read.csv(file.path(path, "/UCI HAR Dataset/test/X_test.txt"), sep = " ", header = FALSE)
data1y <- read.csv(file.path(path, "/UCI HAR Dataset/test/y_test.txt"), sep = " ", header = FALSE)
data2 <- read.csv(file.path(path, "/UCI HAR Dataset/train/X_train.txt"), sep = " ", header = FALSE)
data2y <- read.csv(file.path(path, "/UCI HAR Dataset/train/y_train.txt"), sep = " ", header = FALSE)
features <- read.csv(file.path(path, "/UCI HAR Dataset/features.txt"), sep = " ", header = FALSE)
subjecttrain <- read.csv(file.path(path, "/UCI HAR Dataset/train/subject_train.txt"), sep = " ", header = FALSE)
subjecttest <- read.csv(file.path(path, "/UCI HAR Dataset/test/subject_test.txt"), sep = " ", header = FALSE)
activitynames <- read.csv(file.path(path, "/UCI HAR Dataset/activity_labels.txt"), sep = " ", header = FALSE)

# Working with the files and creating some intermediary data frames
data1y <- merge(data1y, activitynames, by = "V1")
data2y <- merge(data2y, activitynames, by = "V1")
datafinal <- merge(data1y, data2y)
datafinal <- datafinal[1:300,]
datafinal$average = NA
datafinal$standardeviation = NA
write.table(datafinal, row.names = FALSE , file = "upload.txt")
