#1.Merges the training and the test sets to create one data set.
#Suppose the files have already been unziped and are in the working directory,
xtrain<-read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain<-read.table("./UCI HAR Dataset/train/y_train.txt")
strain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
xtest<-read.table("./UCI HAR Dataset/test/X_test.txt")
ytest<-read.table("./UCI HAR Dataset/test/y_test.txt")
stest<-read.table("./UCI HAR Dataset/test/subject_test.txt")
train<-cbind(strain,ytrain,xtrain)
test<-cbind(stest,ytest,xtest)
fulldata<-rbind(train,test)

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
feature<-read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)[,2]
mean_std <- grep(("mean\\(\\)|std\\(\\)"), feature)
finaldata<-fulldata[,c(1,2,mean_std+2)]
colnames(finaldata) <- c("subject", "activity", feature[mean_std])

#3.Uses descriptive activity names to name the activities in the data set.
activity<-read.table("./UCI HAR Dataset/activity_labels.txt")
finaldata$activity<-factor(finaldata$activity,levels=activity[,1],labels = activity[,2])

#4.Appropriately labels the data set with descriptive variable names.
names(finaldata) <- gsub("\\()", "", names(finaldata))
names(finaldata) <- gsub("^t", "time", names(finaldata))
names(finaldata) <- gsub("^f", "frequence", names(finaldata))
names(finaldata) <- gsub("-mean", "Mean", names(finaldata))
names(finaldata) <- gsub("-std", "Std", names(finaldata))

#5.From the data set in step 4, 
#creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
groupdata <- finaldata %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))
write.table(groupdata, "groupdata.txt", row.names = FALSE)
