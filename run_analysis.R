##
#
# Pre-requisite : the input file must downloaded and unziped in the working directory
#
library(dplyr)

# Read the activity labels
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt", col.names=c("activity_id","activity_name"))

# Read the features
features<-read.table("./UCI HAR Dataset/features.txt", col.names=c("feature_id","feature_name"))

# Read the data linked to training
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt", col.names=features$feature_name)
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt", col.names=c("activity_id"))
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt", col.name=c("subject_id"))

# Read the data linked to test
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt", col.names=features$feature_name)
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt", col.names=c("activity_id"))
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt", col.name=c("subject_id"))

# Assemble train and test dataframe together
train<-cbind(subject_train,y_train,X_train)
test<-cbind(subject_test,y_test,X_test)
data<-rbind(train,test)

# Select only the columns that contain mean or std description
data_mean_std<-select(data,subject_id,activity_id,contains("mean"),contains("std"))

# Replace activity ID by the corresponding name
data_mean_std$activity_id<-activity_labels[data_mean_std$activity_id,2]
names(data_mean_std)[2]="activity"

# Simplify the label names (remove uppercase)
names(data_mean_std)<-gsub("-mean()","mean",names(data_mean_std))
names(data_mean_std)<-gsub("-std()","std",names(data_mean_std))
names(data_mean_std)<-tolower(names(data_mean_std))

# group by subject and activity and apply mean to all column : 
result<-data_mean_std %>% group_by(subject_id,activity) %>% summarise_all(funs(mean))

# write the result in a file
write.table(result,"Result.txt",row.name=FALSE)

