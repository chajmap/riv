src=function(pattern="nature"){
df=read.table("doc/ais.txt",header=T)
pattern=toupper(pattern)
print(df[grep(pattern = pattern, x = df$Journal),][order(df[grep(pattern = pattern, x = df$Journal),]$Ais,
                                                      df[grep(pattern = pattern, x = df$Journal),]$Journal,
                                                      decreasing = T),])
}
