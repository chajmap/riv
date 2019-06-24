riv = function(rank=1,total=64,cat=1,rank2=1,total2=64,rank3=1,total3=64,rank4=1,total4=64,rank5=1,total5=64,rank6=1,total6=64,domaci=1,cizi.cr=0,cizi.zahr=0,afiliace2=0,afiliace3=0,poradi=1){
  
  # clanek je pouze v jednom ranku
  if(cat==1){
    n=(rank-1)/(total-1) # normovane poradi
    faktor=(1-n)/(1+(n/0.057))
    riv.body=round(10+(295*faktor),2)# celkovy pocet bodu za publikaci
  } else if(cat==2){
    # clanek je ve dvou rancich
    n1=(rank-1)/(total-1) # normovane poradi
    n2=(rank2-1)/(total2-1) # normovane poradi
    faktor=(1-mean(c(n1,n2)))/(1+(mean(c(n1,n2))/0.057))
    riv.body=round(10+(295*faktor),2)# celkovy pocet bodu za publikaci
  } else if(cat==3){
    # clanek je ve trech rancich
    n1=(rank-1)/(total-1) # normovane poradi
    n2=(rank2-1)/(total2-1) # normovane poradi
    n3=(rank3-1)/(total3-1) # normovane poradi
    faktor=(1-mean(c(n1,n2,n3)))/(1+(mean(c(n1,n2,n3))/0.057))
    riv.body=round(10+(295*faktor),2)# celkovy pocet bodu za publikaci
  } else if(cat==4){
    # clanek je ve ctyrech rancich
    n1=(rank-1)/(total-1) # normovane poradi
    n2=(rank2-1)/(total2-1) # normovane poradi
    n3=(rank3-1)/(total3-1) # normovane poradi
    n4=(rank4-1)/(total4-1) # normovane poradi
    faktor=(1-mean(c(n1,n2,n3,n4)))/(1+(mean(c(n1,n2,n3,n4))/0.057))
    riv.body=round(10+(295*faktor),2)# celkovy pocet bodu za publikaci
  } else if(cat==5){
    # clanek je v peti rancich
    n1=(rank-1)/(total-1) # normovane poradi
    n2=(rank2-1)/(total2-1) # normovane poradi
    n3=(rank3-1)/(total3-1) # normovane poradi
    n4=(rank4-1)/(total4-1) # normovane poradi
    n5=(rank5-1)/(total5-1) # normovane poradi
    faktor=(1-mean(c(n1,n2,n3,n4,n5)))/(1+(mean(c(n1,n2,n3,n4,n5))/0.057))
    riv.body=round(10+(295*faktor),2)# celkovy pocet bodu za publikaci
  } else {
    # clanek je v sesti rancich
    n1=(rank-1)/(total-1) # normovane poradi
    n2=(rank2-1)/(total2-1) # normovane poradi
    n3=(rank3-1)/(total3-1) # normovane poradi
    n4=(rank4-1)/(total4-1) # normovane poradi
    n5=(rank5-1)/(total5-1) # normovane poradi
    n6=(rank6-1)/(total6-1) # normovane poradi
    faktor=(1-mean(c(n1,n2,n3,n4,n5,n6)))/(1+(mean(c(n1,n2,n3,n4,n5,n6))/0.057))
    riv.body=round(10+(295*faktor),2)# celkovy pocet bodu za publikaci
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
  output=data.frame(Who=c("Article","Institution","Author"),Points=c(riv.body,riv.instituce,riv.autor))
  return(output)
}
