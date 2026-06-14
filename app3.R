library(shiny)

library(countdown)

library(shinyWidgets)
library(bslib)
library(tidyverse)

library(shinyjs)

library(fontawesome)



# Define UI for application that draws a histogram

ui <- fluidPage(
  theme  = bs_theme(version = 5, bootswatch = "minty"), 
  useShinyjs(),
  
  shiny::tags$style(type="text/css",
                    
                    ".shiny-output-error { visibility: hidden; }",
                    
                    ".shiny-output-error:before { visibility: hidden; }"
                    
  ),
  
  
  
  tags$style(".bttn-bordered[disabled] {cursor: not-allowed;}"),
  
  
  
  
  
  # Application title
  
  titlePanel("Number Memory Test"),
  
  
  
  h3("welcome to number memory test. in this app you can train your brain with

       numbers. remember how high level you are how dificult it wil be "),
  
  
  
  fluidRow(
    
    column(width = 2),
    
    column(width = 8,
           
           wellPanel(
             
             fluidRow(
               
               column(width = 3,
                      
                      actionBttn("startgm", "Start", icon = icon("play"))
                      
               ),
               
               column(width = 6,
                      
                      radioGroupButtons("gametype", label = NULL, choices = c("Easy", "Medium", "Hard"),
                                        
                                        selected = "Medium")
                      
               ),
               
               column(width = 3,
                      
                      actionBttn("endgm", icon = icon("close"))
                      
               )
               
             ),
             
             textOutput("currentLevel"),
             
             countdown(
               
               id = "countdown_easy", seconds = 8, minutes = 0,
               
               right = 0, left = 0,
               
               border_width        =0,
               
               box_shadow=NULL,
               
               color_background = "gray90",
               
               color_text = "gray",
               
               color_running_background = "orange",
               
               color_running_text = "steelblue",
               
               style = "position:relative;width: 10em;max-width: 100%;"
               
             ),
             
             countdown(
               
               id = "countdown", seconds = 5, minutes = 0,
               
               right = 0, left = 0,
               
               border_width        =0,
               
               box_shadow=NULL,
               
               color_background = "gray90",
               
               color_text = "gray",
               
               color_running_background = "orange",
               
               color_running_text = "steelblue",
               
               style = "position:relative;width: 10em;max-width: 100%;"
               
             ),
             
             countdown(
               
               id = "countdown_hard", seconds = 3, minutes = 0,
               
               right = 0, left = 0,
               
               border_width        =0,
               
               box_shadow=NULL,
               
               color_background = "gray90",
               
               color_text = "gray",
               
               color_running_background = "orange",
               
               color_running_text = "steelblue",
               
               style = "position:relative;width: 10em;max-width: 100%;"
               
             ),
             
             
             
             textOutput("displayMemoryNumber"),
             
             uiOutput("answerMemoryUI"),
             
             br(),
             
             uiOutput("checkAnswerUI"),
             
             br(),
             
             uiOutput("evalAnswer"),
             
             actionBttn("nextgm", "Next", icon = icon("forward")),
             
             actionBttn("retrygm", "Try Again", icon = icon("reply")),
             
             br(), br(),  
             
             uiOutput("usrperformanceUI"),
             
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
  
  hide("countdown")
  
  hide("countdown_easy")
  
  hide("countdown_hard")
  
  
  
  id.counter <- reactive({
    
    if(input$gametype=="Easy"){
      
      id.counter = "countdown_easy"
      
    }else if(input$gametype=="Hard"){
      
      id.counter = "countdown_hard"
      
    }else{
      
      id.counter = "countdown"
      
    }
    
    id.counter
    
  })
  
  
  
  
  
  observeEvent(input$startgm, {
    
    gm.lvl(1)
    
    disable("startgm")
    
    disable("gametype")
    
    enable("retrygm")
    
    
    
    if(input$gametype=="Easy"){
      
      hide("countdown")
      
      show("countdown_easy")
      
      hide("countdown_hard")
      
      countdown_action("countdown_easy", "start")
      
    }else if(input$gametype=="Hard"){
      
      hide("countdown")
      
      hide("countdown_easy")
      
      show("countdown_hard")
      
      countdown_action("countdown_hard", "start")
      
    }else{
      
      show("countdown")
      
      hide("countdown_easy")
      
      hide("countdown_hard")
      
      countdown_action("countdown", "start")
      
      
      
    }
    
  })
  
  
  
  observeEvent(input$nextgm, {
    
    nw.lvl = gm.lvl()+1
    
    gm.lvl(nw.lvl)
    
    if(input$gametype=="Easy"){
      
      hide("countdown")
      
      show("countdown_easy")
      
      hide("countdown_hard")
      
      countdown_action("countdown_easy", "start")
      
    }else if(input$gametype=="Hard"){
      
      hide("countdown")
      
      hide("countdown_easy")
      
      show("countdown_hard")
      
      countdown_action("countdown_hard", "start")
      
    }else{
      
      show("countdown")
      
      hide("countdown_easy")
      
      hide("countdown_hard")
      
      countdown_action("countdown", "start")
      
    }
    
  })
  
  
  
  observeEvent(input$retrygm, {
    
    gm.lvl(0)
    
    enable("startgm")
    
    enable("gametype")
    
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
    
    #browser()
    
    if(input[[id.counter()]]$timer$is_running){
      
      frmt.number = formatC(memoryNumber(), format = "d", big.mark = " ")
      
      paste(frmt.number)
      
    }
    
    
    
  })
  
  
  
  output$answerMemoryUI <- renderUI({
    
    req(memoryNumber())
    
    if(!input[[id.counter()]]$timer$is_running){
      
      textInput("answerMemory", "Answer")
      
    }
    
    
    
  })
  
  
  
  output$checkAnswerUI <- renderUI({
    
    req(input$answerMemory, memoryNumber())
    
    if(!input[[id.counter()]]$timer$is_running){
      
      actionBttn("checkAnswer", "Check", icon = icon("clipboard-check"))
      
    }
    
  })
  
  
  
  output$evalAnswer <- renderUI({
    
    req(input$checkAnswer, memoryNumber())
    
    
    
    if(memoryNumber() == as.numeric(input$answerMemory)){
      
      enable("nextgm")
      
      tags$p(
        
        fa("check-square", fill = "green"),
        
        "Correct!",
        
        style = 'text-size: 50px; margin-bottom: 10px; display: block;'
        
      )
      
      
      
    } else {
      
      disable("nextgm")
      
      tags$p(
        
        fa("times-circle", fill = "red"),
        
        "Wrong!",
        
        style = 'text-size:50px; margin-bottom: 10px; display: block;'
        
      )
      
      
      
    }
    
  })
  
  
  
  observeEvent(input$endgm,{
    
    #session$onSessionEnded(function() {
    
    stopApp()
    
    #})
    
  })
  
  
  
  output$usrperformanceUI <- renderUI({
    
    req(input$checkAnswer, input$answerMemory,
        
        memoryNumber(), gm.lvl() >= 1,
        
        !input[[id.counter()]]$timer$is_running)
    
    
    
    select.colr <- function(x) {
      
      rainbow_colors <- c(
        
        "#FF0000", "#FF7F00", "#FFFF00", "#7FFF00", "#00FF00",
        
        "#00FF7F", "#00FFFF", "#007FFF", "#0000FF", "#7F00FF",
        
        "#FF00FF", "#FF007F", "#FF1493", "#FF4500", "#FFD700"
        
      )
      
      if (x <= length(rainbow_colors)) {
        
        return(rainbow_colors[x])
        
      } else {
        
        return("#FFFFFF") # Default to white if index is out of bounds
        
      }
      
    }
    
    
    
    if(memoryNumber() == as.numeric(input$answerMemory)){
      
      gm.perf.data <- data.frame(x = 1:gm.lvl(), y = 1) %>%
        
        mutate(color = sapply(x, select.colr))
      
    }else{
      
      gm.perf.data <- data.frame(x = 1:(gm.lvl()-1), y = 1) %>%
        
        mutate(color = sapply(x, select.colr))
      
    }
    
    
    
    
    
    gp <- ggplot(data.frame(x = 1:15, y = rep(1, 15)), aes(x, y)) +
      
      geom_point(shape = 22, color = "gray", fill = "gray95", size = 12) +
      
      geom_point(data = gm.perf.data, aes(fill = color), shape = 22, color = "gray", size = 12, show.legend = FALSE) +
      
      theme_void() +
      
      scale_fill_identity()
    
    
    
    renderPlot(gp, height = 40)
    
  })
  
}



# Run the application

shinyApp(ui = ui, server = server)