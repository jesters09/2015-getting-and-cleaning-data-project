#set working directory and initate required libraries

setwd('C:/Users/ryan.c.thomas/Desktop/Clients/Cousera/3_Data/Course Project')
library(dplyr)
library(sqldf)
library(tidyr)

#download data

url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
download.file(url,"Dataset.zip")
unzip("Dataset.zip", exdir = "Dataset")

#read datasets into r

y_test<-read.table("./Dataset/UCI HAR Dataset/test/y_test.txt")
y_train<-read.table("./Dataset/UCI HAR Dataset/train/y_train.txt")
features<-read.table("./Dataset/UCI HAR Dataset/features.txt")
x_test<-read.table("./Dataset/UCI HAR Dataset/test/X_test.txt",header=F)
x_train<-read.table("./Dataset/UCI HAR Dataset/train/X_train.txt",header=F)
subject_train<-read.table("./Dataset/UCI HAR Dataset/train/subject_train.txt")
subject_test<-read.table("./Dataset/UCI HAR Dataset/test/subject_test.txt")
alabels<-read.table("./Dataset/UCI HAR Dataset/activity_labels.txt")

#create column names for each dataset

colnames(x_test)<-features[,2]
colnames(x_train)<-features[,2]
colnames(subject_train)<-("subject_id")
colnames(subject_test)<-"subject_id"
colnames(y_test)<-"activity_id"
colnames(y_train)<-"activity_id"
colnames(alabels)<-c("activity_id","activity_name")

#combined the test and train results data with the subject data

train<-cbind(subject_train,y_train,x_train)
test<-cbind(subject_test,y_test,x_test)
dat<-rbind(train,test)

# merge the results and subject data with the actvity data to bring in the
# activity the subject was doing. Then combine the test and train data into one.


data<-merge(dat,alabels,by.x="activity_id",by.y="activity_id")
data_combined<-rbind(test,train)

#subset the dataset to only include observations that are either a mean or standard deviation

data_columns<-data_combined[,grepl("-mean|-std",colnames(data_combined))]

#add the activity and subject to the mean and standard deviation dataset

data_obs<-data[,c(2,564)]
data_final<-cbind(data_obs,data_columns)


#group the data by activity and subject and calculate the mean for each column

group_data<- data_final%>% group_by(activity_name,subject_id) %>% summarise_each(funs(mean))

#create long tidy data

data_tidy<-gather(data_final,"variable","mean",3:81)

#write table to upload tidy data

write.table(data_tidy,file="tidy_data.txt",row.name=F)


View(alabels)
