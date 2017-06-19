# run_analysis.R 
# It's assumed that all the neccesary files are in data directory: 
# Y_test.txt, Y_train.txt, subject_train.txt, subject_test.txt, X_test.txt, X_train.txt, features.txt, 
# activity_labels.txt

if (!file.exists("data"))
{
    dir.create("data")
}

x.train <- read.table("data/X_train.txt")    
subj.train <- read.table("data/subject_train.txt", col.names="subject")
y.train <- read.table("data/y_train.txt", col.names="label")

x.test <- read.table("data/X_test.txt")
subj.test <- read.table("data/subject_test.txt", col.names="subject")
y.test <- read.table("data/y_test.txt", col.names="label")

##### Step 1. Merges the training and the test sets to create one data set.

# All together in one dataset with the following order:
#   A 561-feature vector with time and frequency domain variables (x.train and x.test) 
#   An identifier of the subject who carried out the experiment (subj.train and subj.test)
#   activity label (y.train and y.test)

dataset <- rbind(cbind(x.train, subj.train, y.train), cbind(x.test, subj.test, y.test))

#set the name of columns in dataset, this allow me to obtain in easy way the subset by finalFeatures in step 2
features <- read.table("data/features.txt",strip.white=TRUE, stringsAsFactors=FALSE)
dataset.colnames <- c(features$V2, "subject", "activity")
names(dataset) <- dataset.colnames

##### Step 2.Extracts only the measurements on the mean and standard deviation for each measurement. 

#Reading features file and filtering on mean and standard deviation

features.Mean.STD <- features[grep("mean\\(\\)|std\\(\\)", features$V2),2]

# add subject and activity label to final features

finalFeatures <- c(features.Mean.STD, "subject", "activity")

# Subset the dataset by selecting just finalFeatures

dataset <- dataset[, finalFeatures]


##### Step 3.Uses descriptive activity names to name the activities in the data set

# Reading activity names from activity_labels file

labels <- read.table("data/activity_labels.txt")

# replace activity labels in dataset with label names in activity_labels file

dataset$activity <- labels[dataset$activity, 2]

##### Step 4.Appropriately labels the data set with descriptive variable names. 

# Taking into account features_info.txt, the following replacements are made it
#   t is replaced by time
#   Acc is replaced by acceleration
#   Gyro is replaced by gyroscope 
#   f is replaced by frequency
#   Mag is replaced by magnitude
#   BodyBody is replaced by Body

names(dataset)<-gsub("^t", "Time", names(dataset))
names(dataset)<-gsub("Acc", "Acceleration", names(dataset))
names(dataset)<-gsub("Gyro", "Gyroscope", names(dataset))
names(dataset)<-gsub("^f", "Frequency", names(dataset))
names(dataset)<-gsub("Mag", "Magnitude", names(dataset))
names(dataset)<-gsub("BodyBody", "Body", names(dataset))

library(data.table)
DT <- as.data.table(dataset)
write.table(DT, file = "tidy_dataset.txt", row.names = FALSE)

##### Step 5. From the data set in step 4, creates a second, independent tidy data set with the
# average of each variable for each activity and each subject.

# It's created the second data set with the average of each variable for each subject and each activity, 180 rows in total.

second.dataset <- DT[, lapply(.SD,mean), by=c("subject","activity")]

# second.dataset is ordered and write it into data file second_dataset.txt

second.dataset <- second.dataset[order(second.dataset$subject,second.dataset$activity),]
write.table(second.dataset, file = "second_dataset.txt", row.names = FALSE)

