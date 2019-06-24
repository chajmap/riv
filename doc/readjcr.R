read.jcr=function(){
  data={}
  for (i in list.files("doc/reports/")){
    df=read.table(paste0("doc/reports/",i),sep=",",skip=1,nrows=-2,header=T,fill=T)
    df=df[-c((nrow(df)-1):nrow(df)),]
    df[,1]=paste(df[,1],nrow(df),sep="/")
    df[,2]=toupper(df[,2])
    df[,3]=ifelse(df[,3]=="Not Available",NA,as.character(df[,3]))
    df[,4]=ifelse(df[,4]=="Not Available",NA,as.character(df[,4]))
    df=type.convert(df)
    data[[gsub(pattern = ".csv",replacement = "",x = i)]]=df
  }
  return(data)
}

