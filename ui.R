# Load shiny library
library(datasets)
library(shiny)
library(shinyAce)

# All UI elements must be inside shinyUI()
shinyUI(
  
  pageWithSidebar(
    headerPanel("Immigrants in Iceland"),
    
    sidebarPanel(
      tabsetPanel(
        tabPanel("Editor", 
                 # Code editor window.
                 aceEditor("plotCode", 
                           mode = "r", 
                           value = "ggplot(data = cars,\n    aes(x = speed, y = dist)) + \n    geom_line(col = 'red')")
                 
                 #downloadButton(
                  # outputId = "downloadCode", 
                   #label    = "Download Code")
        ),
        
        tabPanel("How To",
                 list(
                   h5("1. Upload your data file(s) in CSV format. You may use multiple files in your plot, but you must upload them one at a time."),
                   h5("2. Enter your ggplot2 code on the 'Editor' tab. Enter only the command to create your plot. All data manipulation should be done prior to using this app."),
                   h5("3. Click the 'Update Plot' button on the 'Plot' tab to see the results."),
                   h5("4. If you need to consult ggplot2 docs or resources, use the links on the 'Debug' tab."),
                   p()
                 )
        )
      )
      
    ),
    
    mainPanel(
      tabsetPanel(
        
        tabPanel("Data Manager",
                 # User uploads data file here.
                 fileInput(
                   inputId = "uploadFile",
                   label   = "Upload a CSV data file. You may upload multiple files and use them all in your plot, but you must upload them one at a time. Note: If you upload a file with a name that's already being used, the app will append a numeric suffix to ensure no data is overwritten."),
                 
                 h5("Data available:"),
                 
                 # This is returned once a valid data.frame name is entered
                 # above. It allows the user to pick an x-variable and y-variable
                 # from the column names of the selected data.frame.
                 uiOutput(outputId = "dataInfo")
        ),
        
        tabPanel("Plot",
                 # Show the plot itself.
                 plotOutput(outputId = "plot"),
                 
                 # Button to update plot.
                 actionButton("plotButton", "Update Plot")
        ),
        
        tabPanel("Download", 
                 
                 # Allow the user to choose the download file type.
                 selectInput(
                   inputId = "downloadPlotType",
                   label   = h5("Select download file type"),
                   choices = list(
                     "PDF"  = "pdf",
                     "BMP"  = "bmp",
                     "JPEG" = "jpeg",
                     "PNG"  = "png")),
                 
                 # Allow the user to set the height and width of the plot download.
                 h5(HTML("Set download image dimensions<br>(units are inches for PDF, pixels for all other formats)")),
                 
                 numericInput(
                   inputId = "downloadPlotHeight",
                   label = "Height (inches)",
                   value = 7,
                   min = 1,
                   max = 100),
                 
                 numericInput(
                   inputId = "downloadPlotWidth",
                   label = "Width (inches)",
                   value = 7,
                   min = 1,
                   max = 100),
                 
                 # Choose download filename.
                 textInput(
                   inputId = "downloadPlotFileName",
                   label = h5("Enter file name for download")),
                 
                 div(),
                 
                 # File downloads when this button is clicked.
                 downloadButton(
                   outputId = "downloadPlot", 
                   label    = "Download Plot")
        )
        
        
        
      )
    )
  )
)
