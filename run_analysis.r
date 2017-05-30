# Tom McCutchen
# Getting and Cleaning Data Course Project
# The purpose of this program is to collect and clean (make tidy) a data set
# of readings of human activity on a smart phone.
# For additional information please see the readme file.

# Download and unzip the data from the data source.

library(downloader)

library(dplyr)

setwd("C:/Users/Tom/Documents/Coursera")

if (!file.exists("clean")){dir.create("clean")}
    
setwd("C:/Users/Tom/Documents/Coursera/clean")
    
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download(url, dest="Data.zip", mode="wb")

unzip(zipfile="Data.zip",exdir="./data")

# Read data into data frames

y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")

subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")

subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")


# Combine test and training data - "stack" test data on top of training data
# This achieves the first requirement of the assignment
# 1. Merges the training and the test sets to create one data set. 

y_combined <- rbind(y_test,y_train)

X_combined <- rbind(X_test,X_train)

subject_combined <- rbind(subject_test, subject_train)

# Step 2
# Identify measurements on the mean and standard deviation in order to achieve step 2.
# Combine these into a single data frame
# Note that the approach below assumes that mean and standard deviation values
# have parenthesis "()" following them.  We do not include other features where the
# string "mean" may appear without double parenthesis.


features <- read.table("./data/UCI HAR Dataset/features.txt")
features <- rename(features, index = V1, desc = V2)
features_mean <- features[grepl("mean()",features$desc),]
features_std <- features[grepl("std()",features$desc),]
features_stats <- rbind(features_mean,features_std) 

# Steps 3 and 4; 
# replace numbers in y_combined with more meaningful descriptions. 
# rename columns
# create tidy data set

for (i in 1:nrow(y_combined)) {
  if (y_combined[i,1] == 1)  {y_combined[i,1] <- "WALKING"} else
    if (y_combined[i,1] == 2)  {y_combined[i,1] <- "WALKING_UPSTAIRS"} else
      if (y_combined[i,1] == 3)  {y_combined[i,1] <- "WALKING_DOWNSTAIRS"} else  
        if (y_combined[i,1] == 4)  {y_combined[i,1] <- "SITTING"} else    
          if (y_combined[i,1] == 5)  {y_combined[i,1] <- "STANDING"} else    
            if (y_combined[i,1] == 6)  {y_combined[i,1] <- "LAYING"} 
}

y_combined <- rename(y_combined, label = V1)
subject_combined <- rename(subject_combined, subject = V1)


X_tidy <- X_combined[features_stats$index]

names(X_tidy) <- features_stats$desc

Data_Tidy <- cbind(subject_combined, y_combined,X_tidy)

# Step 5
# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

# removing the "label" data as it cannot be averaged:
Data_tidy_label_removed <- subset(Data_Tidy, select = -c(label) )

mean_by_subject <-  Data_tidy_label_removed %>% group_by(subject) %>% summarize_each(funs(mean))


