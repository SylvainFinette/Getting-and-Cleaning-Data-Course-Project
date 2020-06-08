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
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt", col.names=c("activity_id"))
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt", col.name=c("subject_id"))

# Read the data linked to test
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt", col.names=c("activity_id"))
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt", col.name=c("subject_id"))

# Select only the columns that contain mean or std description
columns<-grep("mean|std",features$feature_name)
columns_names<-features[columns,2]
columns_names<-gsub("[-(,)]","",columns_names)
columns_names<-tolower(columns_names)

# Assemble train and test dataframe together
X<-rbind(X_train,X_test)
X<-X[,columns]
colnames(X)<-columns_names
Y<-rbind(y_train,y_test)
subject<-rbind(subject_train,subject_test)
data_mean_std<-cbind(subject,Y,X)

# Replace activity ID by the corresponding name
data_mean_std$activity_id<-activity_labels[data_mean_std$activity_id,2]
names(data_mean_std)[2]="activity"

# group by subject and activity and apply mean to all column : 
result<-data_mean_std %>% group_by(subject_id,activity) %>% summarise_all(funs(mean))

# write the result in a file
write.table(result,"Result_tidy.txt",row.name=FALSE)

