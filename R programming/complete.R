complete<-function(directory,id=1:332) {
  files<-list.files(directory,full.names=TRUE)
  ccase<-data.frame()
  for (index in id) {
    temp<-read.csv(files[index],comment.char=" ")
    temp2<-complete.cases(temp)
    c<-temp[temp2,]
    ccase<-rbind(ccase,c(index,nrow(c)))
  }
  names(ccase)<-c("id","nobs")
  ccase
}