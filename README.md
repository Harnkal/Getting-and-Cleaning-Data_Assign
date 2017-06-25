Getting-and-Cleaning-Data_Assign
================================

Introduction
------------

This README was created in order to explain how the code on the file run_analysis.R works, and how the output of this code is tidy. It was divided into 8 items in order to make it easier to whoever is grading this assignment:

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

Also in this item, the code will load the used packages and import the used data from the raw dataset folder.

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

As the assignment requested, the code should extract only the measurements for the mean and the standard deviation for each measurement. The strategy used to accomplish this was searching for the terms ```"mean()"``` and ```"std()"``` in the features dataset which contains the names of all the variables, and using it to select the variables returned by the search. The order of the columns were also changed for better visualization.
```R
interestVars <- grepl("mean\\()|std\\()", features$V2)
selectedData <- select(totalData, 563, 562, which(interestVars))
``` 

I did not include the meanFreq() variables as, in my understanding of the dataset, this variable does not show the mean of the refered measurement, it rather shows the mean frequency of aquisition which was not requested in the assignment. I understand that some people may disagree on that understanding and in this case to include meanFreq, substitute "mean\\()" by "mean.*\\()" (this may generate some NAs in the final step of the Tidying dataset item, so you may want also to remove the section were it spreads the means and the standard deviations into 2 variables).

Naming activity labels
----------------------

There are many ways to accomplish this objective. The strategy I used was defining the activity variable as a factor and then changing the levels based on the data on the activity_labels.txt file:
```R
selectedData <- mutate(selectedData, activity = as.factor(activity))
levels(selectedData$activity) <- act_labels$V2
```

Naming variables
----------------

In this part, the code uses the variable names in the file features.txt to name all the variables gathared in the Selecting data section. The only change made to the names contained in the features.txt file was the removal of the "()" from the end of the part that indicates the applied operations.
```R
varNames <- as.character(features$V2[interestVars])
varNames <- gsub("\\()", "", varNames)
names(selectedData)[3:length(selectedData)] <- varNames
```

Some could say that it is possible to be more descriptive in the variable names. However, the names as they are in the features.txt file serves me well as they show the subject, the applied operation to the raw data and the axis (when they exist), and as I do not have a full undertanding on the measured subjects it is unlikely that I would be able to give them names that describe them better. Besides that, the names are well formated and these variables will be stored as observations in the further steps of the analysis.

Tidying dataset
---------------

This is the part of the assignment that is more open for discussions. This is because a tidy dataset is not the same for everybody and it varies acording to it's application and as this dataset will not have any application at all (at least not on this course) the tidy format is up to the previous experiences (or even lack of it) of the future (or current) scientist. So, this section tries to explain why this dataset is tidy for me and how I tidyied it.

In the first part of this section the code put the dataset created until now through a pipe which gather all the columns of the data set but the datatype and the activity and stores them as observations under the variable subject, then it group this data by activity and subject and summirizes their values by mean storing the results in a variable called mean. The result of this pipe is then stored in a new dataset called tidyData.
```R
tidyData <- selectedData %>% 
      gather(subject, values, -c(datatype, activity)) %>%
      group_by(activity, subject) %>%
      summarize(mean = mean(values))
```

Here is were the discutions begin. The dataset creted until now is arguably tidy and some would even say that it is not necessary to gather the variables into observations (see [Getting and Cleaning the Assignment](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/) article). However, there are two kinds of measurements for each activity and subject and, in my see, they should be split in 2 variables as they measure different things (mean and standard deviation). The following part of the code takes care of the (if you included the meanFreq() variables in the Selecting data section, running this part of the code may generate some NAs).
```R
tidyData <- tidyData %>%
      separate(subject, c("subject", "variables", "axis"), fill = "right") %>%
      mutate(subject = paste(subject, axis, sep = "-"), 
             subject = gsub("-NA$", "", subject)) %>%
      select(-axis) %>%
      spread(variables, mean)
```

As you could see above I separated the subject from the axis, but I had to put paste them back together. Although some could say that each axis should stored as a variable, this dataset has 2 kinds of data, axial and angular, and the second type doesn't have axial information (as it doesn't exist), so, trying to create a variable for each axis would insert NAs in the dataset. In my opinion, the correct call here would be split this data into 2 separate tables and then tidy them both. However, doing this would be against the requirements of the assignment.

Saving and cleaning workspace
-----------------------------

Finaly the new tidy dataset is saved in the same folder as the raw data (```"./Data"```) as (```"samsung_tidy.txt"```) and all the variables created during the this scrip were erased in order to return your workspace to the inital state.













