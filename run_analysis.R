# remove all uneccesary documents
rm(list = ls())

# read data - MAIN
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)

# read data - .test
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE)

# read data - .test/Inertial Signals
body_gyro_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", 
                                   stringsAsFactors = FALSE)
body_gyro_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", 
                                   stringsAsFactors = FALSE)
body_gyro_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", 
                                   stringsAsFactors = FALSE)
total_acc_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", 
                                   stringsAsFactors = FALSE)
total_acc_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", 
                                   stringsAsFactors = FALSE)
total_acc_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", 
                                   stringsAsFactors = FALSE)
body_acc_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", 
                                   stringsAsFactors = FALSE)
body_acc_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", 
                                   stringsAsFactors = FALSE)
body_acc_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", 
                                   stringsAsFactors = FALSE)

# read data - .train
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE)

# read data - .train/Inertial Signals
body_gyro_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", 
                               stringsAsFactors = FALSE)
body_gyro_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt", 
                               stringsAsFactors = FALSE)
body_gyro_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt", 
                               stringsAsFactors = FALSE)
total_acc_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", 
                               stringsAsFactors = FALSE)
total_acc_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", 
                               stringsAsFactors = FALSE)
total_acc_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", 
                               stringsAsFactors = FALSE)
body_acc_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", 
                              stringsAsFactors = FALSE)
body_acc_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", 
                              stringsAsFactors = FALSE)
body_acc_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", 
                              stringsAsFactors = FALSE)

# data to select
### mean
with.mean <- setdiff(grep("mean()", features[, 2]), grep("meanFreq()", features[, 2]))
features[with.mean, 2]
### std
with.std <- grep("std()", features[, 2])
features[with.std, 2]
### to select
to.select <- union(with.std, with.mean)
features[to.select, 2]

# rename activity columns
colnames(y_train) <- "activity"
colnames(y_test) <- "activity"
y_train$activity <- activity_labels[y_train$activity, 2]
y_test$activity <- activity_labels[y_test$activity, 2]

#########################################   TRAINING
# rename columns
colnames(body_acc_x_train) <- paste(colnames(body_acc_x_train), "body_acc_x", sep = "_")
colnames(body_acc_y_train) <- paste(colnames(body_acc_x_train), "body_acc_y", sep = "_")
colnames(body_acc_z_train) <- paste(colnames(body_acc_x_train), "body_acc_z", sep = "_")
colnames(total_acc_x_train) <- paste(colnames(total_acc_x_train), "total_acc_x", sep = "_")
colnames(total_acc_y_train) <- paste(colnames(total_acc_y_train), "total_acc_y", sep = "_")
colnames(total_acc_z_train) <- paste(colnames(total_acc_z_train), "total_acc_z", sep = "_")
colnames(body_gyro_x_train) <- paste(colnames(body_gyro_x_train), "body_gyro_x", sep = "_")
colnames(body_gyro_y_train) <- paste(colnames(body_gyro_y_train), "body_gyro_y", sep = "_")
colnames(body_gyro_z_train) <- paste(colnames(body_gyro_z_train), "body_gyro_z", sep = "_")
colnames(subject_train) <- "subject"
colnames(x_train) <- features[, 2]
group <-  rep("train", nrow(y_train))
names(group) <- "group"

# cbind the corresponding datasets
big_dataset_tr <- cbind(subject_train, y_train, group, x_train[, to.select],
                        body_acc_x_train, body_acc_y_train, body_acc_z_train,
                        total_acc_x_train, total_acc_y_train, total_acc_z_train,
                        body_gyro_x_train, body_gyro_y_train, body_gyro_z_train)

#########################################   TEST
# rename columns
colnames(body_acc_x_test) <- paste(colnames(body_acc_x_test), "body_acc_x", sep = "_")
colnames(body_acc_y_test) <- paste(colnames(body_acc_x_test), "body_acc_y", sep = "_")
colnames(body_acc_z_test) <- paste(colnames(body_acc_x_test), "body_acc_z", sep = "_")
colnames(total_acc_x_test) <- paste(colnames(total_acc_x_test), "total_acc_x", sep = "_")
colnames(total_acc_y_test) <- paste(colnames(total_acc_y_test), "total_acc_y", sep = "_")
colnames(total_acc_z_test) <- paste(colnames(total_acc_z_test), "total_acc_z", sep = "_")
colnames(body_gyro_x_test) <- paste(colnames(body_gyro_x_test), "body_gyro_x", sep = "_")
colnames(body_gyro_y_test) <- paste(colnames(body_gyro_y_test), "body_gyro_y", sep = "_")
colnames(body_gyro_z_test) <- paste(colnames(body_gyro_z_test), "body_gyro_z", sep = "_")
colnames(subject_test) <- "subject"
colnames(y_test) <- "activity"
colnames(x_test) <- features[, 2]
group <-  rep("test", nrow(y_test))
names(group) <- "group"

# cbind the corresponding datasets
big_dataset_te <- cbind(subject_test, y_test, group, x_test[, to.select],
                        body_acc_x_test, body_acc_y_test, body_acc_z_test,
                        total_acc_x_test, total_acc_y_test, total_acc_z_test,
                        body_gyro_x_test, body_gyro_y_test, body_gyro_z_test)

# putting train and test dataset together
big_dataset <- rbind(big_dataset_te, big_dataset_tr)

# remove all not needed datasets
rm(list = setdiff(ls(), "big_dataset"))

# install ddplyr and use it to the final exercise
install.packages("plyr")
require("plyr")
big_dataset_wo_group <- big_dataset[, -3]
dataset_with_means <- ddply(big_dataset_wo_group, c("activity", "subject"), 
                            function(x) colMeans(x[,-c(1,2)]))

# save it
write.table(dataset_with_means, file = "final_5.txt", row.name=FALSE)
