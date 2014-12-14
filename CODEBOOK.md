Codebook for ExDataProject
=============
The project requires the following steps:
Include a R script called run_analysis.R that does the following: 
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This codebook is broken up into these 5 steps and the associated run_analysis.R  program is annoted with these 5 steps as well.
0. Downloaded data
  * Download UCI HAR dataset and unzipped in working directory
  * Reviewed readme and other description files to understand the layout of the data
1. Merges the training and the test sets to create one data set
  * Created table "features" with the features from the features.txt file
    * Saved only col 2 with field names
    * Removed the punctuation characters from the features to make more presentable R labels
    * Recaste "features" as a data frame
    * Named the variable(column) "feature"
  * Created table "activitylabels" with the activity names from the activity_labels.txt file
    * Assigned column names "activityID" and "activity"

Use of the UCI dataset requires the following:

###License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones 
using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). 
Vitoria-Gasteiz, Spain. Dec 2012  This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed 
to the authors or their institutions or its use or misuse. Any commercial use is prohibited.
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
