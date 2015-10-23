library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("RLC bandpass filter"),
    sidebarPanel(
        numericInput('R', h4('Resistance in ohms'), 1, min=1, max=1000, step=5),
        numericInput('L', h4('Inductance in milliHenries'), 0.1, min=0.1, max=10, step=0.1),
        numericInput('C', h4('Capacitance in microFarads'), 10, min=1, max=20, step=0.5),
              

        radioButtons("units", 
                      label = h4("Units"),
                      choices = list("Absolute" = "absolute", "decibels" = "dB"), 
                                selected = "dB"),
        
        sliderInput('f', 'Determine magnitude response at the frequency of choice', value=5000, min=1, max=10000, step=1)

    ),
    mainPanel(
        #h4('Resistance you chose:'),
	#verbatimTextOutput("R"),
        #h4('Inductance you chose:'),
        #verbatimTextOutput("L"), 
	#h4('Capacitance you chose:'),
	#verbatimTextOutput("C"), 
        #h4('Units you chose:'),
        #verbatimTextOutput("units") 
      tabsetPanel(
        tabPanel("Tool Output", 
                 plotOutput("magResponse"),
                 h4('Resonant frequency (Hz):'),
                 verbatimTextOutput("fres"),
                 h5('At frequency:'),
                 verbatimTextOutput("freq"),
                 h5('Magnitude Response:'),
                 verbatimTextOutput("mag")),
        tabPanel("Documentation", 
                 #includeMarkdown("bpf.md"))
                 includeHTML("bpf.html"))
      )
        
        
    )
))