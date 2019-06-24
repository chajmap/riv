riv.jcr=function(q,journal,poradi=1,domaci=1,cizi.cr=0,cizi.zahr=0,afiliace2=0,afiliace3=0){
  source("doc/riv2.R")
  df=read.table("doc/ais.txt",header=T)
  return(riv(q=q,
             domaci=domaci,cizi.cr = cizi.cr,cizi.zahr = cizi.zahr,afiliace2 = afiliace2,
             afiliace3 = afiliace3,poradi = poradi))
}

