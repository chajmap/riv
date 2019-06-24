library(shiny)

# Nacteni funkce
source("doc/rivjcr.R", encoding = "UTF-8")
source("doc/printj.R", encoding = "UTF-8")
source("doc/src.R", encoding = "UTF-8")

shinyServer(function(input, output) {
  output$ui <- renderUI({
    if (is.null(input$journal)) return()
    
    switch(
      is.null(input$input_type),
      F = wellPanel(
        numericInput(
          "domaci",
          label = "Počet autorů z domácí instituce (Number of home authors)",
          value = 1,
          min = 1
        ),
        numericInput(
          "cizi.cr",
          label = "Počet autorů z jiné instituce (ČR) (Number of other Czech authors)",
          value = 0,
          min = 0
        ),
        numericInput(
          "cizi.zahr",
          label = "Počet autorů z jiné instituce (Zahraničí) (Number of foreign authors)",
          value = 0,
          min = 0
        ),
        numericInput(
          "poradi",
          label = "Pořadí autora v rámci autorů z domácí instituce (Author order)",
          value = 1,
          min = 1
        ),
        numericInput(
          "afiliace2",
          label = "Počet autorů (z této instituce) se dvěma afiliacemi (Number of home authors with two affiliations)",
          value = 0,
          min = 0
        ),
        numericInput(
          "afiliace3",
          label = "Počet autorů (z této instituce) se třemi afiliacemi (Number of home authors with three affiliations)",
          value = 0,
          min = 0
        )
      )
    )
  })
  data <- reactive({
    if (is.null(input$journal)) return()
    data.frame(cbind(
      riv.jcr(
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
    if (is.null(input$journal)) {
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
  output$AIS <- renderTable({
    if (is.null(input$journal)) {
      return()
    } else data2()
  })
})