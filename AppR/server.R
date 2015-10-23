library(shiny)

magnitude_response <- function(Rin, Lin, Cin, fin){
     Rin<-Rin
     Lin<-Lin*0.001
     Cin<-Cin*0.000001
     Hmag<-Rin/sqrt(Rin^2 + (2*pi*fin*Lin-(1/(2*pi*fin*Cin)))^2)
     Hmag

}

shinyServer(
   function(input, output){
    

    output$magResponse<-renderPlot({
      R<-input$R
      L<-input$L
      C<-input$C
      f<-1:10000
      Hf<-data.frame(mag=numeric(length(f)))
      for (i in f){
       Hf$mag[i]<-magnitude_response(R,L,C,i)
      }
      Hf$mag<-as.numeric(Hf$mag)
      if(input$units=="dB"){
      Hf$mag<-20*log10(Hf$mag)
      }
      plot(f, Hf$mag, type="n", xlab="frequency", ylab="magnitude", main="Magnitude Response")
      lines(f, Hf$mag, type="l")
      freq<-input$f
      lines(c(freq, freq), c(min(Hf$mag), max(Hf$mag)), col="green", lwd=5)
      mag<-magnitude_response(R,L,C,freq)
      #text(40,-10, paste("frequency=",freq))
      #text(40,-15, paste("mag. resp=", round(mag,4)))

    })
    output$fres<-renderPrint({1/(2*pi*sqrt(input$L*0.001*input$C*0.000001))})
    output$mag<-renderPrint({if(input$units=="absolute"){round(magnitude_response(input$R, input$L, input$C, input$f),4)}else{round(20*log10(magnitude_response(input$R, input$L, input$C, input$f)),4)} })
    output$freq<-renderPrint({input$f})
    
    #output$R <-renderPrint({input$R})
    #output$L <-renderPrint({input$L})
    #output$C <-renderPrint({input$C})
    #output$units <-renderPrint({input$units})
   }
)