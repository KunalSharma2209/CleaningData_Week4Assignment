### Writing code and setting your working directory

getwd()

dir()

setwd("~/R/CleaningWeek4Assignment")


### Use hyperlink provided to download data to directory

hyperlink <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

rawdata <- "Cleaning Week 4 Assignment Data.zip"

if(!file.exists(rawdata)){
  download.file(hyperlink, rawdata)
}

if(!file.exists("UCI HAR Dataset")){
  unzip(rawdata)
}


### Read in the training data set

subjects_training <- read.table("UCI HAR Dataset/train/subject_train.txt") 
values_training <- read.table("UCI HAR Dataset/train/X_train.txt")
labels_training <- read.table("UCI HAR Dataset/train/Y_train.txt")

training_data <- cbind(subjects_training, labels_training, values_training)
training_data[1:10,1:5]


### Read in the test data set

subjects_testing <- read.table("UCI HAR Dataset/test/subject_test.txt") 
values_testing <- read.table("UCI HAR Dataset/test/X_test.txt")
labels_testing <- read.table("UCI HAR Dataset/test/Y_test.txt")

testing_data <- cbind(subjects_testing, labels_testing, values_testing)
testing_data[1:10,1:5]


### Merge the two data sets

merged_data <- rbind(training_data, testing_data)
merged_data[1:10,1:5]


### Read in the activity and features names

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

colnames(activity_labels) <- c("ActivityNo","Activity")
colnames(features) <- c("FeatureNo", "Feature")

activity_labels[,2] <- as.character(activity_labels[,2])
features[,2] <- as.character(features[,2])


### Change the features columns to use the descriptive names

colnames(merged_data) <- c("subject", "activity", features[,2])
merged_data[1:10,1:5]


### Condense the data set to only mean and SD features

mean_std_cols <- as.numeric(grepl("mean()",colnames(merged_data)))+as.numeric(grepl("std()",colnames(merged_data)))==1
mean_std_cols[1:2] <- TRUE
mean_std_cols

condensed_data <- merged_data[,mean_std_cols==TRUE]
condensed_data[1:5,1:8]


### Use descriptive activity names rather than numbers

condensed_data[,2] <- factor(condensed_data[,2], levels = activity_labels[,1], labels = activity_labels[,2])
condensed_data[1:5,1:8]


### Create an independent tidy data set with average of each variable

library(reshape2)
melted_data <- melt(condensed_data, id=c("subject","activity"))
tidy_averages <- dcast(melted_data, subject + activity ~ variable, mean)
tidy_averages[1:5,1:8]


### Write the data set for submission, to a text file as per the received data

write.table(tidy_averages, "tidy_average_data.txt", row.names = FALSE, quote = FALSE)


