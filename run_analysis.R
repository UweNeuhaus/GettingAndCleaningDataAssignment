## This script produces a tidy data set

## Include necessary libraries
library(reshape)

## Read all necessary files (assume, they are in a subfolder "UCI HAR Dataset")

# Files from main "UCI HAR Dataset" folder: feature names and activity names
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# Files from "train" subfolder: training data ("X_train.txt"), 
# training activity ("y_train.txt"), training subjects ("subject_train.txt")
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
train_act <- read.table("UCI HAR Dataset//train/y_train.txt")
train_sub <- read.table("UCI HAR Dataset//train/subject_train.txt")

# Files from "test" subfolder: test data ("X_test.txt"), 
# test activity ("y_test.txt"), test subjects ("subject_test.txt")
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
test_act <- read.table("UCI HAR Dataset//test/y_test.txt")
test_sub <- read.table("UCI HAR Dataset//test/subject_test.txt")

## Combine read-in data to one data frame
# Combine training data to one frame
train_frame <- cbind(train_data, train_act, train_sub)
# Combine test data to one frame
test_frame <- cbind(test_data, test_act, test_sub)
# Combine training and test frame
data <- rbind(train_frame, test_frame)

## Rename colums and replace activity numbers by activity names
names(data) <- c(as.character(features$V2), "Activity", "Subject")
for (i in activity_labels$V1) {
    data$Activity <- gsub(pattern=i, x=data$Activity, 
        replacement=activity_labels$V2[activity_labels$V1 == i])
}

## Delete column not dealing with means or standard deviations, i. e.
## keep only columns with "mean()" or "std()" in their name
data <- data[,grep("mean\\(\\)|std\\(\\)|Activity|Subject", names(data))]

## Melting and reshaping data to create the average of each variable for 
## each activity and each subject.
mdata <- melt(data, id=c("Activity", "Subject"))
tidy <- cast(mdata, Activity + Subject ~ variable, mean)

## Save the tidy data matrix as a text file
write.table(x=tidy, file="tidy_data.txt", row.names=FALSE)