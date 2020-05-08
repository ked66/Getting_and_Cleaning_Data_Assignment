## Download/Unzip File
if(!dir.exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./data/zipfile.zip", method = "curl")

## Load Train and Testing Data, combine to 1 dataset
TestData <- read.table(unz("./data/zipfile.zip", "UCI HAR Dataset/test/X_test.txt"))
TrainData <- read.table(unz("./data/zipfile.zip", "UCI HAR Dataset/train/X_train.txt"))
AllData <- rbind(TestData, TrainData)

## Subset desired measures
## Load measure names
ColumnNames <- read.table(unz("./data/zipfile.zip", "UCI HAR Dataset/features.txt"))
## ID measures of mean | std
relevantColumns <- grep("mean|std", ColumnNames$V2) 
## Subset mean/std measures from AllData
subsetData <- AllData[,relevantColumns]
## Add measure names
colnames(subsetData) <- ColumnNames[relevantColumns,]$V2

## Load and Add Subject ID
TestSubjects <- read.table(unz("./data/zipfile.zip", "UCI HAR Dataset/test/subject_test.txt"))
TrainSubjects <- read.table(unz("./data/zipfile.zip", "UCI HAR Dataset/train/subject_train.txt"))
AllSubjects <- rbind(TestSubjects, TrainSubjects)

library(dplyr)
subsetData <- mutate(subsetData, subjects = AllSubjects$V1)

## Load and Add Activity ID
TestActivity <- read.table(unz("./data/zipfile.zip", "UCI HAR Dataset/test/y_test.txt"))
TrainActivity <- read.table(unz("./data/zipfile.zip", "UCI HAR Dataset/train/y_train.txt"))
AllActivity <- rbind(TestActivity, TrainActivity)

subsetData <- mutate(subsetData, activity = AllActivity$V1)

## Convert Activity ID to Descriptive Label
## Read activity key
ActivityKey <- read.table(unz("./data/zipfile.zip", "UCI HAR Dataset/activity_labels.txt"))
subsetData$activity <- sapply(subsetData$activity, function(x){ActivityKey$V2[match(x, ActivityKey$V1)]})


## Convert subjects and activity to factors
subsetData$subjects <- as.factor(subsetData$subjects)
subsetData$activity <- as.factor(subsetData$activity)

## Calculate the means
library(reshape2)
meltData <- melt(subsetData, id = c("subjects", "activity"))
tidy2 <- dcast(meltData, subjects + activity ~ variable, mean)
## Write final tidy dataset to file
write.table(tidy2, file = "./data/tidy2.txt", row.names = FALSE)
