Codebook for ExDataProject
=============
The project requires the following steps:
Include a R script called run_analysis.R that does the following: 
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

I accomplish these steps mostly in the stated order.  
  * STEP 4 is done in STEP 1 to keep the labels with the data.
  * This codebook is broken up into these 5 steps and the associated run_analysis.RR  program is annotated with these 5 steps as well.

Step 0 -  Downloaded data
  * Download UCI HAR dataset and unzipped in working directory
  * Reviewed readme and other description files to understand the layout of the data
  
Step 1 -  Merges the training and the test sets to create one data set
  * Created table "features" with the features from the features.txt file
  * Saved only col 2 with field names
  * Removed the punctuation characters from the features to make more presentable R labels
  * Recaste "features" as a data frame
  * Named the variable(column) "feature"
  * Open the y data from test and train sets and combine, column name is activityID
  * Open the X data from test and train sets and combine, column names based in feature list
  * Open the subject data from test and train sets and combine, column name is subject
  * Combine the columns
  
Step 2 - Extract only the measurements on the mean and standard deviation for each measurement
  * Use select to order the columns and select the columns that name (feature) contains the std or mean
  * I chose this definition of mean as it is the most general given lack of other information

Step 3 - Use descriptive activity names to name the activities in the data set
  * Create table "activitylabels" with the activity names from the activity_labels.txt file
  * Name the columns activityID and activity to facilitate the join
  * Join the activity names to the dataset using the activityID as the key
  * Since the join is at the right column, use the select function to reorder the columns and drop the activityID

Step 4 - Appropriately labels the data set with descriptive variable names
  * This was needed in STEP 2 to extract the mean and std measurements
  * Also reused in STEP 3 to collect the columns in order

Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable  for each activity and each subject.
  * Set up the index lists
  * Use two for loops to compute the mean of each feature by subject and activity name
  * Use the columnMean call (after removing the subject and activity - we have those in our loop variables)
  * Add the subject and activity back to the vector of means
  * Add those to the result table and continue loop to end
  * Convert to data frame and eliminate Factors
  * Add column names for subject and activity
  * Change character classes to numeric classes except for activity
  * Sort by subject and activity
  * Write out tidy datafile for submission
  * Data can be read using >tidydata<-read.table("./tidydata.txt", header = TRUE)

The resulting table is 180 observations (30 subjects by 6 unique activities)
The column (variable names)  Are listed below:
  
[1] "subject"                           "activity"                          "tBodyAccmeanX"                    
[4] "tBodyAccmeanY"                     "tBodyAccmeanZ"                     "tGravityAccmeanX"                 
[7] "tGravityAccmeanY"                  "tGravityAccmeanZ"                  "tBodyAccJerkmeanX"                
[10] "tBodyAccJerkmeanY"                 "tBodyAccJerkmeanZ"                 "tBodyGyromeanX"                   
[13] "tBodyGyromeanY"                    "tBodyGyromeanZ"                    "tBodyGyroJerkmeanX"               
[16] "tBodyGyroJerkmeanY"                "tBodyGyroJerkmeanZ"                "tBodyAccMagmean"                  
[19] "tGravityAccMagmean"                "tBodyAccJerkMagmean"               "tBodyGyroMagmean"                 
[22] "tBodyGyroJerkMagmean"              "fBodyAccmeanX"                     "fBodyAccmeanY"                    
[25] "fBodyAccmeanZ"                     "fBodyAccmeanFreqX"                 "fBodyAccmeanFreqY"                
[28] "fBodyAccmeanFreqZ"                 "fBodyAccJerkmeanX"                 "fBodyAccJerkmeanY"                
[31] "fBodyAccJerkmeanZ"                 "fBodyAccJerkmeanFreqX"             "fBodyAccJerkmeanFreqY"            
[34] "fBodyAccJerkmeanFreqZ"             "fBodyGyromeanX"                    "fBodyGyromeanY"                   
[37] "fBodyGyromeanZ"                    "fBodyGyromeanFreqX"                "fBodyGyromeanFreqY"               
[40] "fBodyGyromeanFreqZ"                "fBodyAccMagmean"                   "fBodyAccMagmeanFreq"              
[43] "fBodyBodyAccJerkMagmean"           "fBodyBodyAccJerkMagmeanFreq"       "fBodyBodyGyroMagmean"             
[46] "fBodyBodyGyroMagmeanFreq"          "fBodyBodyGyroJerkMagmean"          "fBodyBodyGyroJerkMagmeanFreq"     
[49] "angletBodyAccMeangravity"          "angletBodyAccJerkMeangravityMean"  "angletBodyGyroMeangravityMean"    
[52] "angletBodyGyroJerkMeangravityMean" "angleXgravityMean"                 "angleYgravityMean"                
[55] "angleZgravityMean"                 "tBodyAccstdX"                      "tBodyAccstdY"                     
[58] "tBodyAccstdZ"                      "tGravityAccstdX"                   "tGravityAccstdY"                  
[61] "tGravityAccstdZ"                   "tBodyAccJerkstdX"                  "tBodyAccJerkstdY"                 
[64] "tBodyAccJerkstdZ"                  "tBodyGyrostdX"                     "tBodyGyrostdY"                    
[67] "tBodyGyrostdZ"                     "tBodyGyroJerkstdX"                 "tBodyGyroJerkstdY"                
[70] "tBodyGyroJerkstdZ"                 "tBodyAccMagstd"                    "tGravityAccMagstd"                
[73] "tBodyAccJerkMagstd"                "tBodyGyroMagstd"                   "tBodyGyroJerkMagstd"              
[76] "fBodyAccstdX"                      "fBodyAccstdY"                      "fBodyAccstdZ"                     
[79] "fBodyAccJerkstdX"                  "fBodyAccJerkstdY"                  "fBodyAccJerkstdZ"                 
[82] "fBodyGyrostdX"                     "fBodyGyrostdY"                     "fBodyGyrostdZ"                    
[85] "fBodyAccMagstd"                    "fBodyBodyAccJerkMagstd"            "fBodyBodyGyroMagstd"              
[88] "fBodyBodyGyroJerkMagstd" 

Use of the UCI dataset requires the following:

###License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones 
using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). 
Vitoria-Gasteiz, Spain. Dec 2012  This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed 
to the authors or their institutions or its use or misuse. Any commercial use is prohibited.
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
