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
- To run this code you must have installed the packages ```R dplyr``` and ```R tidyr```;
- If you already have downloaded the raw dataset, you should store it in your working directory under the folowing path ```R "./Data/UCI HAR Dataset"```;
..- To make sure, check if the following code returns a TRUE ```R file.exists("./Data/UCI HAR Dataset/test/X_test.txt")```;
- If you do not have the dataset properly placed in your working directory the code will download the dataset and unzip it properly;
- In order to read the output file properly into R, run the following code ```R read.table("./Data/samsung_tidy.txt", header = TRUE)```.

0. Preparation
--------------

In this section, the code will check if the raw dataset have already been downloaded and unziped in the correct path. In case you have not downloaded the raw dataset or not placed it properly according to the instructions above, it will download and unzip the raw dataset in the path it was programed to look for (it is important to follow this part of the instructions in case you don't want to download multiple copies of the dataset).

Also in this item, the code will load the used packages, and import the used data from raw dataset folder.

1. Merging data
---------------

