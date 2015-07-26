## Coursera Getting and Cleaning Data- Course Project
## Bharat Mantha created on 2015 July 26
#install and load packages
install.packages("plyr")
library(plyr)
#set working directory
setwd('c:/Users/h169703/My Documents/')

#part1____________________________________________________________________________________
# Load and Merge training and testing datasets into one dataset
x_traindata <- read.table("UCI HAR Dataset/train/X_train.txt")
y_traindata <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_traindata <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_testdata <- read.table("UCI HAR Dataset/test/X_test.txt")
y_testdata <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_testdata <- read.table("UCI HAR Dataset/test/subject_test.txt")

# creating x,y, and subject  data frames
x_data <- rbind(x_traindata, x_testdata)
y_data <- rbind(y_traindata, y_testdata)
subject_data <- rbind(subject_traindata, subject_testdata)


#part2_________________________________________________________________________________
# Extract mean and standard deviation for each measurement
features <- read.table("UCI HAR Dataset/features.txt")

# extract columns with mean() or std() in their names
mean_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subsetting the desired columns and modifying column names
x_data <- x_data[, mean_std_features]
names(x_data) <- features[mean_std_features, 2]

#part3______________________________________________________________________________
# Use descriptive activity names to name the activities in the data set
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# update values with correct activity names and change column name
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "activity"

#part4______________________________________________________________________________# Appropriately label the data set with descriptive variable names
#Appropriately labels the data set with descriptive variable names 
#Columnbinds into one dataset 
names(subject_data) <- "subject"
all_data <- cbind(x_data, y_data, subject_data)

#part5______________________________________________________________________________# Appropriately label the data set with descriptive variable names
# creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# for each activity and each subject
# 66 <- 68 columns but last two (activity & subject)
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "tidy_dataset.txt", row.name=FALSE)
