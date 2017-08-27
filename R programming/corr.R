corr<-function(directory,threshold=0) {
  files<-list.files(directory,full.names=TRUE)
  cList<-c()
  for (i in 1:length(files)) {
    data<-read.csv(files[i])
    con<-complete.cases(data)
    if (sum(con)>threshold) {
      cList<-c(cList,cor(data$sulfate, data$nitrate,use="complete.obs"))
    }
  }
  cList
}