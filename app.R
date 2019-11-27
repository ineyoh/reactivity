library(shiny)

ui<-
  fluidPage(
    fluidRow(
      column(4,
             h2("Reactive Test"),
             textInput("Test_Reactive1","Test Reactive 1"),
             textInput("Test_Reactive2","Test Reactive 2"),
             textInput("Test_Reactive3","Test Reactive 3"),
             tableOutput("React_Out")
      ),
      column(4,
             h2("Observe Test"),
             textInput("Test_Observe1","Test Observe 1"),
             textInput("Test_Observe2","Test Observe 2"),
             textInput("Test_Observe3","Test Observe 3"),
             tableOutput("Observe_Out")
      ),
      column(4,
             h2("Observe Event Test"),
             textInput("Test_ObserveEvent1","Test ObserveEvent 1"),
             textInput("Test_ObserveEvent2","Test ObserveEvent 2"),
             textInput("Test_ObserveEvent3","Test ObserveEvent 3"),
             tableOutput("Observe_Out_E"),
             actionButton("Go","Test")
      )
      
    ),
    fluidRow(
      column(8,
             h4("Note that observe and reactive work very much the same on the surface,
       it is when we get into the server where we see the differences, and how those
       can be exploited for diffrent uses.")
      ))
    
  )

server<-function(input,output,session){
  
  # Create a reactive Evironment. Note that we can call the varaible outside same place
  # where it was created by calling Reactive_Var(). When the varaible is called by
  # renderTable is when it is evaluated. No real difference on the surface, all in the server.
  
  Reactive_Var <-reactive ({c(input$Test_Reactive1, 
                            input$Test_Reactive2, 
                            input$Test_Reactive3)})
  
  output$React_Out <- renderTable({
    Reactive_Var()
  })
  
  # Create an observe Evironment. Note that we cannot access the created "df" outside 
  # of the env. A, B,and C will update with any input into any of the three Text Feilds.
  observe({
    A<-input$Test_Observe1
    B<-input$Test_Observe2
    C<-input$Test_Observe3
    df<-c(A,B,C)
    output$Observe_Out<-renderTable({df})
  })
  
  #We can change any input as much as we want, but the code wont run until the trigger
  # input$Go is pressed.
  observeEvent(input$Go, {
    A<-input$Test_ObserveEvent1
    B<-input$Test_ObserveEvent2
    C<-input$Test_ObserveEvent3
    df<-c(A,B,C)
    output$Observe_Out_E<-renderTable({df})
  })
  
}
shinyApp(ui, server)
