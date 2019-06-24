print.j=function(dtf.=dtf,journal){
  source("doc/readjcr.R", encoding = "UTF-8")
  if(exists("dtf")) {
  } else {
    dtf.=read.jcr()
  }
  prt={}
  journal=toupper(journal)
  for(i in 1:length(dtf.)){
    for(j in 1:nrow(dtf.[[i]]))
      if(dtf.[[i]][j,2]==journal){
        prt=rbind(prt,dtf.[[i]][dtf.[[i]][2]==journal,])
        prt[,2]=names(dtf.)[i]
      }
  }
  names(prt)=c("Order","Rank","IF","AIS")
  return(prt)
}

