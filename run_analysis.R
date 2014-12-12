library(dplyr)

##Create the common tables
## Create the features name list
tmpfeatures<-read.table("./UCI HAR Dataset-2/features.txt")
features<-tmpfeatures[2]


## Clean the punctionation from the labels
features<-gsub( "[^[:alnum:][:space:]']" , "", features[,1])
features<-data.frame(features)
colnames(features)<-"feature"
rm(tmpfeatures)

## Create the activity labels
activitylabels<-read.table("./UCI HAR Dataset-2/activity_labels.txt")
names(activitylabels)<-c("activityID", "activity")

## Process the test dataset
## Open the Y test data
ytestdata <- read.table("./UCI HAR Dataset-2/test/y_test.txt", col.names="activityID")

## Tidy actvity variable by replacing number with text
ytestdata<-inner_join(ytestdata, activitylabels, by = "activityID")
ytestdata<-select(ytestdata, -activityID)

##Open the X test data
Xtestdata <- read.table("./UCI HAR Dataset-2/test/X_test.txt", col.names = features$feature)

##Open the test subject data
subjects_test <- read.table("./UCI HAR Dataset-2/test/subject_test.txt", col.names="subject")

##Combine columns
test<-cbind(subjects_test, ytestdata, Xtestdata)

## Remove Temp Variables
rm(ytestdata,Xtestdata, subjects_test)

## Process the train dataset

##Open the Y train data
ytraindata <- read.table("./UCI HAR Dataset-2/train/y_train.txt", col.names="activityID")

## Tidy actvity variable by replacing number with text
ytraindata<-inner_join(ytraindata, activitylabels, by = "activityID")
ytraindata<-select(ytraindata, -activityID)

##Open the X train data
Xtraindata <- read.table("./UCI HAR Dataset-2/train/X_train.txt", col.names = features$feature)

##Open the train subject data
subjects_train <- read.table("./UCI HAR Dataset-2/train/subject_train.txt", col.names="subject")

##Combine columns
train<-cbind(subjects_train, ytraindata, Xtraindata)

## Remove Temp Variables
rm(ytraindata,Xtraindata, subjects_train)

## Merge train & test datasets
dataset<-rbind(test, train)

## Remove Temp Variables
rm(train, test)

## Tidy the dataset
##Zero the results dataframe
tmp_res<-NULL   

## Select the std and mean columns
dataset<-select(dataset, subject, activity, contains("mean"), contains("std"))

## Set up the index lists
activities <- unique(dataset$activity)
subjects <- unique(dataset$subject)

##Compute the mean of each test
for (i in subjects){                                    ## for each subject
  for(j in activities){                                 ## for each activity
    tmp_df<-dataset[which(dataset$subject==i), ]              ## Subset the subject
    tmp_df<-tmp_df[which(tmp_df$activity==j), ]               ## Subset the activity
    tmp_df<-select(tmp_df,contains("mean"), contains("std"))  ## remove activity and subject columns
    tmp_cm<-colMeans(tmp_df)                                  ## Calculate the mean for each of the tests
    tmp_cm<-c(i, j, tmp_cm)                                   ## Add in the subject/activiy values
    tmp_res<-rbind(tmp_res,tmp_cm, deparse.level = 0)         ## Add them to the data frame
    }
}

## Convert to data frame and eleiminate Factors
result<-data.frame(tmp_res, stringsAsFactors = FALSE)

## Column names for subject and activity
colnames(result)[2] <- "activity"
colnames(result)[1] <- "subject"

## Change character classes to numeric classes
result$subject<-as.numeric(result$subject)
for (i in 3:ncol(result)){
  result[i]<- as.numeric(as.character(result[,i]))
}

## Sort by subject and activity
result<-arrange(result, subject, activity)

## Cleanup variables
rm(i,j,tmp_cm, tmp_df, activities, activitylabels, features, tmp_res, subjects, dataset)

## Write out tidy datafile for submission
write.table(result, "tidydata.txt", row.name=FALSE)
