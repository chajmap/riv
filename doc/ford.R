ford=function(name="Biol scis"){
  df=read.table("doc/ais.txt",header=T)
  df=df[df$ford==toupper(Journal),]
  rownames(df)=1:nrow(df)
  print(df)
}
