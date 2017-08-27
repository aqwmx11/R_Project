best <- function(state, outcome) {
  ## Read outcome data
  my_data<-read.csv("outcome-of-care-measures.csv")
  ## Check that state and outcome are valid
  my_state<-my_data$State
  disable<-c("heart attack", "heart failure", "pneumonia")
  if (!any(my_state==state))
    stop("invalid state")
  if (!any(disable==outcome))
    stop("invalid outcome")
  ## Return hospital name in that state with lowest 30-day death
  my_data2<-subset(my_data,State==state)
  if (outcome == "heart attack") { 
    my_data2 <- my_data2[c("Hospital.Name", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack")]
  }
  else if (outcome == "heart failure"){
    my_data2 <- my_data2[c("Hospital.Name", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure")]
  }
  else {
    my_data2 <- my_data2[c("Hospital.Name", "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")]
  }
  colnames(my_data2)<-c("hospital","rates")
  my_data2[,"rates"]<-as.numeric(as.character(my_data2[,"rates"]))
  my_data2[,"hospital"]<-as.character(my_data2[,"hospital"])
  my_data2<-my_data2[order(my_data2$rates,my_data2$hospital),]
  best<-my_data2[1,"hospital"]
  best
  ## rate
}