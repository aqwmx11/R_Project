rankall <- function(outcome, num = "best") {
  ## Read outcome data
  my_data<-read.csv("outcome-of-care-measures.csv")
  
  ## Check that state and outcome are valid
  disable<-c("heart attack", "heart failure", "pneumonia")
  if (!any(disable==outcome))
    stop("invalid outcome")
  
  ## For each state, find the hospital of the given rank
  my_list<-as.character(unique(my_data$State))
  my_list<-my_list[order(my_list)]
  if (outcome == "heart attack") { 
    my_data2 <- my_data[c("Hospital.Name", "State","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack")]
  }
  else if (outcome == "heart failure"){
    my_data2 <- my_data[c("Hospital.Name", "State","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure")]
  }
  else {
    my_data2 <- my_data[c("Hospital.Name", "State","Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")]
  }
  colnames(my_data2)<-c("hospital","state","rates")
  my_data2[,"rates"]<-as.numeric(as.character(my_data2[,"rates"]))
  my_data2[,"hospital"]<-as.character(my_data2[,"hospital"])
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  result<-data.frame()
  for (i in my_list) {
    my_state<-subset(my_data2,state==i)
    my_state<-my_state[order(my_state$rates,my_state$hospital),]
    n<-sum(!is.na(my_state$rates))
    if (num=="best")
      num<-1
    else if (num=="worst")
      num<-n
    hosname<-my_state[num,"hospital"]
    tmp<-data.frame(hosname,i)
    colnames(tmp)<-c("hospital","state")
    result<-rbind(result,tmp)
  }
  result
}