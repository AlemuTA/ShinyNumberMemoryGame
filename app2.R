#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(countdown)
library(shinyjs)
library(bslib)
library(fontawesome)

# Define UI for application that draws a histogram
ui <- fluidPage(
  theme  = bs_theme(version = 5, bootswatch = "minty"), 
  useShinyjs(),
  shiny::tags$style(type="text/css", 
                    ".shiny-output-error { visibility: hidden; }", 
                    ".shiny-output-error:before { visibility: hidden; }" 
  ),
    # Application title
    titlePanel("Number Memory Test"),

    h3("welcome to number memory test. in this app you can train your brain with
       numbers. remember how high level you are how dificult it wil be "),

    fluidRow(
      column(width = 2),
      column(width = 8,
        wellPanel(
          actionButton("startgm", "Start", icon = icon("play")), 
          textOutput("currentLevel"),
          countdown(
            id = "countdown",seconds = 4, minutes = 0,
            right = 0, left = 0,
            border_width	=0,
            box_shadow=NULL,
            color_background = "gray90",
            color_text = "gray",
            color_running_background = "orange",
            color_running_text = "steelblue", 
            style = "position:relative;width: 10em;max-width: 100%;"
          ), 
          textOutput("displayMemoryNumber"),
          uiOutput("answerMemoryUI"),
          uiOutput("checkAnswerUI"),
          uiOutput("evalAnswer"),
          actionButton("nextgm", "Next", icon = icon("forward")),
          actionButton("retrygm", "Try Again", icon = icon("reply")),
          br(),
          br(),
          actionButton("endgm", "Close game", icon = icon("close")),
        )
      ),
      column(width = 2),
    ),
  
  tags$head(tags$style("#displayMemoryNumber{color: steelblue;
                                 font-size: 50px;
                                 font-style: bold;
                                 text-align: center;
                                 }"
                       )
            ),
  
  tags$head(tags$style("#evalAnswer{color: steelblue;
                                 font-size: 50px;
                                 font-style: bold;
                                 text-align: center;
                                 }"
  )
  )
) 

# Define server logic required to draw a histogram
server <- function(input, output, session) {

  gm.lvl <- reactiveVal()
   
  disable("nextgm")
  disable("retrygm")
  
  observeEvent(input$startgm, {
    gm.lvl(1)
    disable("startgm")
    
    enable("retrygm")
    
    countdown_action("countdown", "start")
  })
  
  observeEvent(input$nextgm, {
    nw.lvl = gm.lvl()+1
    gm.lvl(nw.lvl) 
    countdown_action("countdown", "start")
  })
  
  observeEvent(input$retrygm, {
    gm.lvl(0) 
    enable("startgm")
  })
  
  output$currentLevel <- renderText({
    req(gm.lvl()>=1)
    paste("level = ", gm.lvl())
  })
  
  memoryNumber <- reactive({
    req(gm.lvl()>=1)
    k <- gm.lvl()
    nbr <- round(runif(1, 10^(k-1), 10^k-1))
    nbr
  })
  output$displayMemoryNumber <- renderText({ 
    req(memoryNumber())
    if(input$countdown$timer$is_running){
      paste(memoryNumber())
    }
    
  })
  
  output$answerMemoryUI <- renderUI({
    req(memoryNumber())
    if(!input$countdown$timer$is_running){
      textInput("answerMemory", "Answer")
    }
    
  }) 
  
  output$checkAnswerUI <- renderUI({
    req(input$answerMemory, memoryNumber())
    if(!input$countdown$timer$is_running){
      actionButton("checkAnswer", "Check", icon = icon("clipboard-check"))
    } 
  }) 
  
  output$evalAnswer <- renderUI({
    req(input$checkAnswer, memoryNumber())
    
    if(memoryNumber() == as.numeric(input$answerMemory)){
      enable("nextgm")
      tags$p(
        fa("check-square", fill = "green"),
        "Correct!",
        style = 'text-size: 100px; margin-bottom: 100px; display: block;'
      )
      
    } else {
      disable("nextgm")
      tags$p(
        fa("times-circle", fill = "red"),
        "Wrong!",
        style = 'text-size:100px; margin-bottom: 100px; display: block;'
      )
      
    }
  }) 
  
  observeEvent(input$endgm,{
    #session$onSessionEnded(function() {
      stopApp()
    #})
  })

}

# Run the application
shinyApp(ui = ui, server = server) 
