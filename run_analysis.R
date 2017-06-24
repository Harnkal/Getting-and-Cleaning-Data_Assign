### Introduction
# This program was made in order to complete the assignment of the course 
# "Getting and Cleaning Data - Week 4". To make the evaluation easier I divided 
# the code in 8 main itens:
# - Introduction
# - 0. Preparation and importing data
# - 1. Merging data
# - 2. Selecting data
# - 3. Naming activity labels
# - 4. Naming Variables
# - 5. Tyding dataset
# - 6. Saving and cleaning workspace
# The itens from 1 to 5 correspond each to a requirement from the assignment.
# From more information on how each of the steps fulfills the requirements 
# please consult the README.md file.

### 0. Preparation and importing data
## Loading packages
library(plyr)
library(dplyr)
library(tidyr)

## Downloading and extracting the dataset (if necessary)
dataName <- "./Data/samsung.zip"
if(!dir.exists("./Data/UCI HAR Dataset")) {
      if(!file.exists(dataName)) {
            # Defining file URL
            fileUrl <- paste("https://d396qusza40orc.cloudfront.net", 
                             "/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                             sep = "")
            # Downloading in temporary file
            download.file(fileUrl, dataName)
            # Cleaning workspace
            rm(fileUrl)
      }
      unzip(dataName)
}

## Importing data
trainData <- read.table("./Data/UCI HAR Dataset/train/X_train.txt")
trainLabels <- read.table("./Data/UCI HAR Dataset/train/y_train.txt")
testData <- read.table("./Data/UCI HAR Dataset/test/X_test.txt")
testLabels <- read.table("./Data/UCI HAR Dataset/test/y_test.txt")
features <- read.table("./Data/UCI HAR Dataset/features.txt")
act_labels <- read.table("./Data/UCI HAR Dataset/activity_labels.txt")

### 1. Merging Data Sets
# Merging labels and data and creating a column to identify the data type
trainData <- mutate(trainData, activity = trainLabels$V1, 
                    datatype = "train")
testData <- mutate(testData, activity = testLabels$V1, 
                   datatype = "test")
# Merging the train and test datasets
totalData <- bind_rows(trainData, testData)

### 2. Selecting data 
# I did not include the meanFreq() variables as, in my point of view, this 
# variable does not show the mean of the refered measurement, it rather shows 
# the mean frequency of aquisition which was not requested in the assignment. 
# To include meanFreq, substitute "mean\\()" by "mean.*\\()"
interestVars <- grepl("mean\\()|std\\()", features$V2)
selectedData <- select(totalData, 563, 562, which(interestVars))

### 3. Naming activity labels
selectedData <- mutate(selectedData, activity = as.factor(activity))
levels(selectedData$activity) <- act_labels$V2

### 4. Naming variables
varNames <- as.character(features$V2[interestVars])
varNames <- gsub("\\()", "", varNames)
names(selectedData)[3:length(selectedData)] <- varNames

### 5. Tidying dataset and gathering means
tidyData <- selectedData %>% 
      gather(subject, values, -c(datatype, activity)) %>%
      group_by(activity, subject) %>%
      summarize(mean = mean(values))
# The dataset creted until now is arguably tidy, however, there are two kinds 
# of measurements for each activity and subject and, in my see, they should be 
# split in 6 variables as they measure different things (mean and standard
# deviation).
tidyData <- tidyData %>%
      separate(subject, c("subject", "variables", "axis"), fill = "right") %>%
      mutate(subject = paste(subject, axis, sep = "-"), 
             subject = gsub("-NA$", "", subject)) %>%
      select(-axis) %>%
      spread(variables, mean)
# As you could see above I separated the subject from the axis, but I had to put
# paste them back together. Although some could say that each axis should stored
# as a variable, this dataset has 2 kinds of data, axial and angular, and the 
# second type doesn't have axial information (as it doesn't exist), so, trying 
# to create a variable for each axis would insert NAs in the dataset. In my 
# opinion, the correct call here would be split this data into 2 separte tables 
# and then tidy them both. However, doing this would be against the requirements 
# of the assignment.

### 6. Saving dataset and cleaning workspace
write.table(tidyData, file = "./Data/samsung_tidy.txt")
rm(act_labels, features, selectedData, testData, testLabels, totalData, 
   trainData, trainLabels, dataName, interestVars, varNames, tidyData)

