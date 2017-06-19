

work1<-"specdata/"

pollutantmean <- function(directory=work1, polutant="sulfate", id=1:332)
{
    totalsum <- totalen <- 0   
    totalvect = numeric()
    for (monitorid in id){
        px <- if (monitorid < 10) {"00"} else if (monitorid < 100) { "0" } else { "" }
        file=paste(px,as.character(monitorid),".csv",sep="")
        pathfile<-paste(directory,"/",file,sep="")
        dfm <- read.csv(pathfile, header=TRUE)        
        
        #         polutantvect <- subset(dfm, na.rm=true, select = polutant)
        polutantvect <- na.omit(dfm[,polutant])   
        
        totalvect <- append(totalvect, polutantvect)            
    }
    
    mean(totalvect)
}

complete <- function(directory=work1, id=1:332)
{
    output <- matrix()
    index<-1
    c1 <- list()
    c2 <- list()
    
    for (monitorid in id){
        px <- if (monitorid < 10) {"00"} else if (monitorid < 100) { "0" } else { "" }
        file=paste(px,as.character(monitorid),".csv",sep="")
        pathfile<-paste(directory,"/",file,sep="")
        dfm <- read.csv(pathfile, header=TRUE)        
        
        completedcases <- subset(dfm, !is.na(sulfate) & !is.na(nitrate), select="nitrate")
        c1 <- append(c1, monitorid)
        c2 <- append(c2, length(completedcases[,1]))        
        index <- index+1
    }
    
    output<-cbind(c1,c2)   
    dfr<-data.frame(output)
    colnames(dfr)<-c("id", "nobs")
    dfr
}

corr <- function(directory=work1, threshold=0)
{
    output <- matrix()
    index<-1
    c <- numeric()
    
    for (monitorid in 1:332){
        px <- if (monitorid < 10) {"00"} else if (monitorid < 100) { "0" } else { "" }
        file=paste(px,as.character(monitorid),".csv",sep="")
        pathfile<-paste(directory,"/",file,sep="")
        dfm <- read.csv(pathfile, header=TRUE)        
        
        completedcases <- subset(dfm, !is.na(sulfate) & !is.na(nitrate), select=c(sulfate, nitrate))
        if (length(completedcases[,1])>threshold)
        {
            v1 <- completedcases[,1]
            v2 <- completedcases[,2]
            corr<-cor(v1,v2)
            c <- append(c, corr)            
        }
    }    
    c
}



