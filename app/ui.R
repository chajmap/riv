fluidPage(
  
  
  fluidRow(
    
    column(3, wellPanel(
      textInput("journal", "Journal title","")),
      
      strong(textOutput("selected")),
      # tags$br(),
  
      tableOutput("riv"),
      
      wellPanel(
      tags$p(strong("Nature / Science: + 500 p.")),
      tags$br(),
      tags$p("D1 (0.00-0.10]: 250 p."),
      tags$p("Q1 (0.10-0.25]: 100 p."),
      tags$p("Q2 (0.25-0.50]: 40 p."),
      tags$p("Q3 (0.50-0.75]: 15 p."),
      tags$p("Q4 (0.75-1.00]: 10 p.")    
      )
    
    # ,
    # withTags({
    #   div(class="paticka", checked=NA,
    #       p("Created by Petr Chajma, chajmap@fzp.czu.cz"),
    #       a(href="https://shiny.fzp.czu.cz/fordy/", "AIS časopisů dle panelů FORD")
    #   )
    # })
    
    ),
    
    column(7, dataTableOutput("AIS")
           ),
    
    column(2, uiOutput("ui"))#,
    
    # column(2, tableOutput("riv"),
    #        
    #        tags$p("Nature / Science... 500 p."),
    #        tags$br(),
    #        tags$p("Q1: [0-0.25]"),
    #        tags$p("Q2: (0.25-0.5]"),
    #        tags$p("Q3: (0.5-0.75]"),
    #        tags$p("Q4: (0.75-1]")
    #        )
    
  )
)
