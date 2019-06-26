library(shiny)
library(DT)

# Nacteni funkce
#source("doc/rivjcr.R", encoding = "UTF-8")
#source("doc/printj.R", encoding = "UTF-8")
#source("doc/src.R", encoding = "UTF-8")

.df=read.table("./doc/ais.txt",header=T) 

src=function(pattern="nature"){
  
  pattern=toupper(pattern)
  if (nchar(pattern)<=3) return(NULL)
  print(.df[grep(pattern = pattern, x = .df$Journal),][order(.df[grep(pattern = pattern, x = .df$Journal),]$Ais,
                                                             .df[grep(pattern = pattern, x = .df$Journal),]$Journal,
                                                             decreasing = TRUE),])
}

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

riv.jcr=function(q,journal,poradi=1,domaci=1,cizi.cr=0,cizi.zahr=0,afiliace2=0,afiliace3=0){
  #source("doc/riv2.R")
  #df=read.table("doc/ais.txt",header=T)
  if (is.na(q)) return()
  return(riv(q=q,
             domaci=domaci,cizi.cr = cizi.cr,cizi.zahr = cizi.zahr,afiliace2 = afiliace2,
             afiliace3 = afiliace3,poradi = poradi))
}



shinyServer(function(input, output) {

  data0 <- reactive({
    if (is.null(input$journal)) return()
    sele = input$AIS_rows_selected
    q = as.numeric(src(pattern = input$journal)$Quantile)
    q = if (length(sele)) {q[sele]} else {
      if (length(q)==1) {q} else {return(NA)}
      }
    #q=min(as.numeric(src(pattern =input$journal)$Quantile) )
  })
  
  output$ui <- renderUI({
    if (is.null(input$journal)) return()
    switch(
      is.null(input$input_type),
      F = wellPanel(
        numericInput(
          "q",
          label = "Quantile",
          value = data0(),
          min = 0,
          max = 1, step = 0.001
        ),
        numericInput(
          "domaci",
          label = "Number of authors with CULS affiliation",
          value = 1,
          min = 1
        ),
        numericInput(
          "cizi.cr",
          label = "Number of authors with other Czech affiliation",
          value = 0,
          min = 0
        ),
        numericInput(
          "cizi.zahr",
          label = "Number of authors with foreign affilitation",
          value = 0,
          min = 0
        ),
        numericInput(
          "poradi",
          label = "Author order in the list of authors",
          value = 1,
          min = 1
        ),
        numericInput(
          "afiliace2",
          label = "Number of CULS authors with two affiliations",
          value = 0,
          min = 0
        ),
        numericInput(
          "afiliace3",
          label = "Number of CULS authors with three affiliations",
          value = 0,
          min = 0
        )
      )
    )
  })
  data <- reactive({
    if (is.null(input$journal) | (nchar(input$journal)<4) | is.na(input$journal)) return()
    data.frame(cbind(
      riv.jcr(
        q=input$q,
        journal = input$journal,
        domaci = input$domaci,
        cizi.cr = input$cizi.cr,
        cizi.zahr = input$cizi.zahr,
        afiliace2=input$afiliace2,
        afiliace3=input$afiliace3,
        poradi = input$poradi
      )
    )
    )
  })
  output$riv <- renderTable({
    if (is.null(input$journal) | is.na(input$journal)) {
      return()
    } else data()
  })
  
  data2 <- reactive({
    if (is.null(input$journal)) return()
    data.frame(cbind(
      src(pattern = input$journal)
    )
    )
  })
  output$AIS <- renderDataTable({
    if (is.null(input$journal)) {
      return()
    } else data2()
  }, selection = list(mode = 'single', selected = 1))
  
  output$selected = renderText({
    if (is.null(input$journal)|is.na(input$journal)) return()
     sele = input$AIS_rows_selected
     nam = as.character(src(pattern = input$journal)$Journal)
     if (length(sele) ) {return(nam[sele])}
     if (length(nam)==1) {return(nam)}
     ###as.character(src(pattern = input$journal)$Journal[input$AIS_rows_selected])
   })
})