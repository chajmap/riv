fluidPage(
  titlePanel("Kalkulačka RIV bodů (RIV points calculator)"),
  
  fluidRow(
    
    column(2, wellPanel(
      textInput("journal", "Název časopisu (Journal title)",
                  "Feminist media studies"
      )
    ),
    withTags({
      div(class="paticka", checked=NA,
          p("Created by Petr Chajma, chajmap@fzp.czu.cz"),
          a(href="https://chajma.shinyapps.io/fordy/", "AIS časopisů dle panelů FORD")
      )
    })),
    
    column(4, tableOutput("AIS")),
    
    column(2, uiOutput("ui")),
    
    column(2, tableOutput("riv"),
           
           tags$p("Nature / Science... 500 p."),
           tags$br(),
           tags$p("Q1: [0-0.25]"),
           tags$p("Q2: (0.25-0.5]"),
           tags$p("Q3: (0.5-0.75]"),
           tags$p("Q4: (0.75-1]")
           )
    
  )
)
