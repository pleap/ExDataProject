library(dplyr)

## STEP 1 (Includes STEP 4) Merges the training and the test sets to create one data set

## Create the variable name list from features.txt 
tmpfeatures<-read.table("./UCI HAR Dataset-2/features.txt")
features<-tmpfeatures[2]
features<-gsub( "[^[:alnum:][:space:]']" , "", features[,1])
features<-data.frame(features)
colnames(features)<-"feature"


## Open the Y data
ydata <- read.table("./UCI HAR Dataset-2/test/y_test.txt", col.names="activityID")
ydata1 <- read.table("./UCI HAR Dataset-2/train/y_train.txt", col.names="activityID")
ydata<-rbind(ydata, ydata1)
rm(ydata1)


##Open the X data
Xdata <- read.table("./UCI HAR Dataset-2/test/X_test.txt", col.names = features$feature)
Xdata1 <- read.table("./UCI HAR Dataset-2/train/X_train.txt", col.names = features$feature)
Xdata<-rbind(Xdata, Xdata1)
rm(Xdata1)


##Open the subject data
subjectdata <- read.table("./UCI HAR Dataset-2/test/subject_test.txt", col.names="subject")
subjectdata1 <- read.table("./UCI HAR Dataset-2/train/subject_train.txt", col.names="subject")
subjectdata<-rbind(subjectdata, subjectdata1)
rm(subjectdata1)

##Combine columns
dataset<-cbind(subjectdata, ydata, Xdata)

## Remove Temp variables
rm(tmpfeatures, subjectdata, Xdata, ydata, features)

## STEP 2 - Extract only the measurements on the mean and standard deviation for each measurement. 
## Select the std and mean columns
dataset<-select(dataset, subject, activityID, contains("mean"), contains("std"))

## STEP 3 - Use descriptive activity names to name the activities in the data set

## Create table "activitylabels" with the activity names from the activity_labels.txt file
activitylabels<-read.table("./UCI HAR Dataset-2/activity_labels.txt")
names(activitylabels)<-c("activityID", "activity")
dataset<-inner_join(dataset, activitylabels, by = "activityID")
dataset<-select(dataset,subject, activity, -activityID, contains("mean"), contains("std"))
rm(activitylabels)

## STEP 4 - Appropriately labels the data set with descriptive variable names. 
# This was needed in STEP 2 to extract the mean and std measurements. Reused in STEP 3 to collect the columns in order

## STEP 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Compute the mean of each test
result <- dataset %>% 
  select(subject, activity,contains("mean"), contains("std")) %>% 
  group_by(subject) %>% 
  group_by(activity, add = TRUE) %>% 
  summarise_each(funs(mean), contains("mean"), contains("std")) %>%
  arrange(subject, activity)


## Write out tidy datafile for submission
write.table(result, "tidydata.txt", row.name=FALSE)
