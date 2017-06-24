Getting-and-Cleaning-Data_Assign
================================

Introduction
------------

This README was created in order to explain how the code on the file run_analysis.R works, and how the output of this code is tidy. It was divided into 8 items in order to make it easier for whoever is grading this assignment:

0. Preparation and importing data
1. Merging data
2. Selecting data
3. Naming activity labels
4. Naming Variables
5. Tyding dataset
6. Saving and cleaning workspace

The itens from 1 to 5 correspond each to a requirement from the assignment. I'm not sure on how this assignment will be evaluated so if you have any doubts on how a particular step was fullfiled in the R code, you may want to come to this README and consult the corresponding part.

Before starting the code explanation here are somethings you should now before runing it (in case you need to).
* To run this code you must have installed the packages ```dplyr``` and ```tidyr```;
* If you already have downloaded the raw dataset, you should store it in your working directory under the folowing path ```"./Data/UCI HAR Dataset"```;
  * To make sure, check if the following code returns a TRUE ```file.exists("./Data/UCI HAR Dataset/test/X_test.txt")```;
* If you do not have the dataset properly placed in your working directory the code will download the dataset and unzip it properly;
* In order to read the output file properly into R, run the following code ```read.table("./Data/samsung_tidy.txt", header = TRUE)```.

Preparation
--------------

In this section, the code will check if the raw dataset have already been downloaded and unziped in the correct path. In case you have not downloaded the raw dataset or not placed it properly according to the instructions above, it will download and unzip the raw dataset in the path it was programed to look for (it is important to follow this part of the instructions in case you don't want to download multiple copies of the dataset).

Also in this item, the code will load the used packages and import the used data from raw dataset folder.

Merging data
---------------

This section merges the four datasets into one, first it inserts the activity variable in both train and test datasets and creates a variable to identify them (not really necessary in this case but I couldn't bring myself to merge 2 kinds of data without identifying them):
```R
trainData <- mutate(trainData, activity = trainLabels$V1, datatype = "train")
testData <- mutate(testData, activity = testLabels$V1, datatype = "test")
```

After this, both datasets were merged into one:
```R
totalData <- bind_rows(trainData, testData)
```

Selecting data
--------------

As the assignment requested the code should extract only the measurements for the mean and the standard deviation for each measurement. The strategy used to accomplish this was searching for the terms ```"mean()"``` and ```"std()"``` in the features dataset which contains the names of all the variables, and using it to select the variables returned by the search. The order of the columns were also changed for better visualization.
```R
interestVars <- grepl("mean\\()|std\\()", features$V2)
selectedData <- select(totalData, 563, 562, which(interestVars))
``` 

I did not include the meanFreq() variables as, in my understanding of the dataset, this variable does not show the mean of the refered measurement, it rather shows the mean frequency of aquisition which was not requested in the assignment. I understand that some people may disagree on that understanding and in this case to include meanFreq, substitute "mean\\()" by "mean.*\\()" (this may generate some NAs in the final step of the Tidying dataset item, so you may want also to remove the section were it separates the means and the standard deviations into 2 variables).

Naming activity labels
----------------------

There are many ways to accomplish this objective. The strategy I used was defining the activity variable as a vector and then changing the levels based on the data on the activity_labels.txt file:
```R
selectedData <- mutate(selectedData, activity = as.factor(activity))
levels(selectedData$activity) <- act_labels$V2
```

Naming variables
----------------

In this part, the code uses the variable names in the file features.txt to names all the variables gathed in the Selecting data section. The only change made to the names contained in the features.txt file was the removal of the "()" from the end of the part that indicates the applied operations.
```R
varNames <- as.character(features$V2[interestVars])
varNames <- gsub("\\()", "", varNames)
names(selectedData)[3:length(selectedData)] <- varNames
```

Some could say that it is possible to be more descriptive in the variable names. However, the names as they are in the features.txt file serves my well as they show the subject, the applied operation to the raw data and the axis (when they exist), and as I do not have a full undertanding on the measured subjects it is unlikely that I would be able to give them names that describe them better. Besides that, the names are well formated and these variables will be stored as observations in the further steps of the analysis which will serve me well.















