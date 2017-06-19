
Overview

This repository contains R code for the Assignment: Getting and Cleaning Data Course Project

R script run_analysis.R, abstract:
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The code in this script is ordered in accordance with these steps.

Collecting data

It's assumed that all the neccesary files to execute run_analysis.R are in a data directory containing the following files from the data set downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
- Y_test.txt
- Y_train.txt
- subject_train.txt
- subject_test.txt
- X_test.txt
- X_train.txt
- features.txt, 
- activity_labels.txt

The first six files were read it before proceding to merge them in one data set.


Step 1. Merges the training and the test sets to create one data set.

The six files mentioned above were read it(with read.table) to merge data in a data frame named dataset. Using rbind and cbind to put all the variables in one data frame which contains:
- A 561-feature vector with time and frequency domain variables (from x.train and x.test) 
- An identifier of the subject who carried out the experiment (from subj.train and subj.test)
- Activity label (from y.train and y.test)

After, set the name of columns in dataset, this allow me to obtain in an easy way the subset by finalFeatures in step 2. The name of columns were extracted from features.txt file

Step 2.Extracts only the measurements on the mean and standard deviation for each measurement. 

- Reading features file and filtering on mean and standard deviation variables using a regular expression.
- Add subject and activity label to final features
- Subset the dataset by selecting just finalFeatures, and exluding the rest of features that not match with the regular expresion.

Step 3.Uses descriptive activity names to name the activities in the data set

- Activity names were read it from activity_labels.txt file
- Replace the numbers of activity labels in dataset with label names in activity_labels file

Step 4.Appropriately labels the data set with descriptive variable names. 

Taking into account the name of variables in features_info.txt file, the following replacements were made it
- t is replaced by time
- Acc is replaced by acceleration
- Gyro is replaced by gyroscope 
- f is replaced by frequency
- Mag is replaced by magnitude
- BodyBody is replaced by Body

Once the data set is ready, it's stored in a file named tidy_dataset.txt using write.table. 


Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

It's created the second data set with the average of each variable for each subject and each activity, 180 rows and 68 columns in total. 
This data set it's created using the lapply function with the previous dataset converted to a data data.table, grouping by subject and activity.

The second.dataset obtained is ordered and wrote it to a file named second_dataset.txt

