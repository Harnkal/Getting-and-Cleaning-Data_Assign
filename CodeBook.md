Getting and Cleaning Data Assignment - Code Book
------------------------------------------------

### samsung_tidy  
This data set was generated from the Samsung [Human Activity Recognition Using Smart Phones Data Set] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). To generate this data set, all the values for the mean and stardard deviation for each subject where merged along with the activities that were being executed in the moment, and then the mean values for the mean and standard deviation for each combination between activities and subjects.  
Observations: 5940  
Variables: 5  
	
1. subject  
	This variable indentify the subject in which the experiments where being applied.  
	The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.  
	Class: Integer
	
2. activity  
	This variable indicates the activity that was being executed at the moment of the acquisition  
	Class: Factor  
	Levels: 6  
	1. WALKING
	2. WALKING_UPSTAIRS
	3. WALKING_DOWNSTAIRS
	4. SITTING
	5. STANDING
	6. LAYING
	
3. features  
	The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.  
	Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).  
	Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).  
	Class: Character  
	1. fBodyAcc-X
	2. fBodyAcc-Y
	3. fBodyAcc-Z
	4. fBodyAccJerk-X
	5. fBodyAccJerk-Y
	6. fBodyAccJerk-Z
	7. fBodyAccMag
	8. fBodyBodyAccJerkMag
	9. fBodyBodyGyroJerkMag
	10. fBodyBodyGyroMag
	11. fBodyGyro-X
	12. fBodyGyro-Y
	13. fBodyGyro-Z
	14. tBodyAcc-X
	15. tBodyAcc-Y
	16. tBodyAcc-Z
	17. tBodyAccJerk-X
	18. tBodyAccJerk-Y
	19. tBodyAccJerk-Z
	20. tBodyAccJerkMag
	21. tBodyAccMag
	22. tBodyGyro-X
	23. tBodyGyro-Y
	24. tBodyGyro-Z
	25. tBodyGyroJerk-X
	26. tBodyGyroJerk-Y
	27. tBodyGyroJerk-Z
	28. tBodyGyroJerkMag
	29. tBodyGyroMag
	30. tGravityAcc-X
	31. tGravityAcc-Y
	32. tGravityAcc-Z
	33. tGravityAccMag
	
4. mean  
	This variable presents the mean value for each combination of subject, activity and feature.  
	Class: numeric
	
5. std  
	This variablepresents the mean standard deviation of the measurements for each combination of subject, activity and feature.
	Class: numeric 
