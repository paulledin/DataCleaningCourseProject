### Introduction

This is my project submission for Coursera's Getting and Cleaning Data class.
This repo contains the README.md file that you're currently reading, my run_analysis.R script, and my code book for the project.


### Files
-README.md - This beauty of a README file that your eyes are currently feasting upon.

-run_analysis.R - This is the R script that:
1. Merges the training and test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Replaces/Uses the descriptive activity names from the activity_labels file.
4. Appropriately labels the data set with descriptive variable names.
5. Finally, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

-CodeBook.md - The code book describing the independent tidy data set created by run_analysis.R.

*** Additionally the run_analysis.R produces a text file named "tidy_data_submission.txt" which is a comma delimited text file containing the newly created tidy data set.  The tidy data set file has uploaded to Coursera separately.


### Assumptions
I made two major assumptions related to the course project.  The first was related to question of what was meant by mean() and std() since some of the measurement variables were themselves an average of some sort.  I took
getting the means and standard deviations to mean an actual computation from the data set as opposed to a measurement which was itself an average.  My second major assumption was with regard to descriptive variable naming specifically
as it relates to the measurement variable themselves.  I simply recycled the measurement variable names on the assumption that while not real meaningful to me they likely would be understood by somebody more familiar with the 
science underlying the actual experiment.

### Approach
My approach was to merge the three files from the test and train data sets to produce the ID# of the subject (the "subject_"), the activity performed (the "y_"), and the measurement variables (the "X_").  From there I merged the 
test and train data sets into one complete data set.  Next I read in the names of the measurement variables from the features.txt file and gave the subject and activity columns the names "Subject" and "Activity" so the columns were
all descriptively named. At that point my script uses the grep() function to find which columns are means or standard deviations and used that information to subset the original data table for just those measurements.  After that I read
the descriptive activity names from activity_labels.txt and replace the number with the label.  And finally I melt the subsetted data along the Subject and Activity and cast the means of the measurements into the 180 different 
combinations of the 30 subjects and 6 activities.






