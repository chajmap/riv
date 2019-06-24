riv = function(q=0,domaci=1,cizi.cr=0,cizi.zahr=0,afiliace2=0,afiliace3=0,poradi=1){
  
  # D1
  if(q<=.1){
    riv.body=250 # celkovy pocet bodu za publikaci
  } else if(q<=.25){
    # Q1
    riv.body=100 # celkovy pocet bodu za publikaci
  } else if(q<=.5){
    # Q2
    riv.body=40 # celkovy pocet bodu za publikaci
  } else if(q<=.75){
    # Q3
    riv.body=15 # celkovy pocet bodu za publikaci
  } else {
    # Q4
    riv.body=10 # celkovy pocet bodu za publikaci
  } 
  riv.instituce=round(riv.body*(((domaci-afiliace2-afiliace3)+(afiliace2/2)+(afiliace3/3))/(domaci+cizi.cr+cizi.zahr/2)),2)
  if(domaci==1){
    riv.autor=riv.instituce
  } else if(domaci==2){
    koef=c(0.6,0.4)
    riv.autor=round(koef[poradi]*riv.instituce,2)
  } else if(domaci==3){
    koef=c(0.5,0.3,0.2)
    riv.autor=round(koef[poradi]*riv.instituce,2)
  } else {
    koef=c(0.4,0.3,0.2,0.1/(domaci-3))
    if(poradi<=4){
      riv.autor=round(koef[poradi]*riv.instituce,2)
    } else {
      riv.autor=round(koef[4]*riv.instituce,2)
    }  
  }
  output=data.frame(Subject=c("Article","Institution","Author"),Points=c(riv.body,riv.instituce,riv.autor))
  return(output)
}
  