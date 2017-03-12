library(reshape2)

# Set up data directory and download data file 
if (!file.exists("./UCI HAR DataSet"))
{
    dir.create("./UCI HAR DataSet")
}

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./UCI HAR DataSet/HCRDataSet.zip")

# Read in the three files that comprise the subject, activity performed, and measurement data
# for both test and training sets.
subjectTest <- read.table(unz("./UCI HAR DataSet/HCRDataSet.zip", 
                              "UCI HAR Dataset/test/subject_test.txt"), stringsAsFactors=FALSE)
X_test <- read.table(unz("./UCI HAR DataSet/HCRDataSet.zip", 
                         "UCI HAR Dataset/test/X_test.txt"), stringsAsFactors=FALSE)
y_test <- read.table(unz("./UCI HAR DataSet/HCRDataSet.zip", 
                         "UCI HAR Dataset/test/y_test.txt"), stringsAsFactors=FALSE)

subjectTrain <- read.table(unz("./UCI HAR DataSet/HCRDataSet.zip", 
                              "UCI HAR Dataset/train/subject_train.txt"), stringsAsFactors=FALSE)
X_train <- read.table(unz("./UCI HAR DataSet/HCRDataSet.zip", 
                         "UCI HAR Dataset/train/X_train.txt"), stringsAsFactors=FALSE)
y_train <- read.table(unz("./UCI HAR DataSet/HCRDataSet.zip", 
                         "UCI HAR Dataset/train/y_train.txt"), stringsAsFactors=FALSE)

# Merge the 2 sets of test and train files together
subjectTest <- cbind(subjectTest, y_test, X_test)
subjectTrain <- cbind(subjectTrain, y_train, X_train)

# Merge training and test data into one data set.
totalObservations <- rbind(subjectTest, subjectTrain)

# Get the column names for the measurement data
features <- read.table(unz("./UCI HAR DataSet/HCRDataSet.zip", 
                           "UCI HAR Dataset/features.txt"), stringsAsFactors=FALSE)

# Label the data with descriptive variable names.
colnames(totalObservations)[1] <- "Subject"
colnames(totalObservations)[2] <- "Activity"
for(i in 1:nrow(features))
{
    colnames(totalObservations)[i+2] <- features[i,"V2"]    
}

# Extract only the measurements on the mean and standard deviation for each measurement.
featuresPos <- grep("mean\\(\\)|std\\(\\)", features$V2, perl=TRUE)
fieldsToExtract <- c(c("Subject", "Activity") ,features[featuresPos, "V2"])
meansAndStds <- totalObservations[, fieldsToExtract]

# Use descriptive activity names to name the activities of the data set.
activityLabels <- read.table(unz("./UCI HAR DataSet/HCRDataSet.zip", 
                                 "UCI HAR Dataset/activity_labels.txt"), stringsAsFactors=FALSE)
for(i in 1:nrow(activityLabels))
{
    meansAndStds$Activity[meansAndStds$Activity==i] <- activityLabels[i,"V2"]
}

# Create a second, independent tidy data set with the average of each variable for
# each activity and each subject.
meansAndStdsMelt <- melt(meansAndStds, id=c("Activity","Subject"), measure.vars=features[featuresPos, "V2"])
subjectActivityAvg <- dcast(meansAndStdsMelt, Subject + Activity ~ variable,mean)
write.table(subjectActivityAvg, file="./UCI HAR DataSet/tidy_data_submission.txt", sep=",",row.name=FALSE)

