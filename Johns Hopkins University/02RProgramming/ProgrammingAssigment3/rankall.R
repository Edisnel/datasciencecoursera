
#Programming Assignment 3

best <- function(state="TX", outcome="heart attack") 
{
    ## Read outcome data
    outcomedata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    liststates<-as.character(outcomedata[,7])
    liststates<-unique(liststates)
    
    columns <- list("name","staten", "heart attack","heart failure","pneumonia")
    colindex <- match(outcome,columns)
    
    if (!is.element(outcome,columns)) {stop("invalid outcome")}
    if (!is.element(state,liststates)) {stop("invalid state")}
    
    #The outcomes can be one of heart attack, heart failure pneumonia(11, 17,23)
    outcomeaux<-outcomedata[,c(2,7,11,17,23)]
    outcomeaux[,3] <- as.numeric(outcomeaux[,3])
    outcomeaux[,4] <- as.numeric(outcomeaux[,4])
    outcomeaux[,5] <- as.numeric(outcomeaux[,5])
    names(outcomeaux)<-c("name","staten", "HA","HF","P")
    outcomeaux <- subset(outcomeaux,staten==state)
    if (outcome=="heart attack")
    {
        outcomeaux <- subset(outcomeaux,!is.na(HA),select=c("name","staten", "HA","HF","P"))
    }
    else if (outcome=="heart failure")
    {
        outcomeaux <- subset(outcomeaux,!is.na(HF),select=c("name","staten", "HA","HF","P"))
    }
    else if (outcome=="pneumonia")
    {
        outcomeaux <- subset(outcomeaux,!is.na(P),select=c("name","staten", "HA","HF","P"))
    }
    
    output<-outcomeaux[ order(outcomeaux[,colindex], outcomeaux[,1]), ]
    output
    ## Check that state and outcome are valid
    
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    
}

rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    data<-best(state,outcome)
    canthosp<-nrow(data)
    ## Check that state and outcome are valid--this is checked in best(..)
    ## Return hospital name in that state with the given rank
    if (num > canthosp) {return}
    index <- if (num == "best") { 1 } else if (num == "worst") { canthosp } else { num }
    hospital<-data[index,1]
    hospital    
}

rankall <- function(outcome="heart attack", num = "best") {
    ## Read outcome data
    outcomedata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")    
    liststates<-as.character(outcomedata[,7])
    liststates<-unique(liststates)
    liststates<-sort(liststates)
    c1 <- list()
    c2 <- list()
    mathosp <- matrix()
    for(i in seq_along(liststates))
    {
        hospname <- rankhospital(liststates[i], outcome, num)
        
        c1 <- append(c1, hospname)
        c2 <- append(c2, liststates[i])
    }
    
    mathosp <-cbind(c1,c2)   
    dfr<-data.frame(mathosp)
    colnames(dfr)<-c("hospital", "state")
    dfr   
    
}
