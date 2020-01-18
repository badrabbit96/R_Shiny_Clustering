library(shinydashboard)
library(shiny)
#library(PerformanceAnalytics)
#library(ellipse)
#library(caret)
library(DT)
library(cluster)
#library(MASS)
server <- function(input, output, session) 
{
 
  
  #pobieram plik
  data <- reactive({ 
    req(input$file1) 
    inFile <- input$file1
   })
  
  #https://www.cryptodatadownload.com/data/euro/
  #wpisuje dane do tabeli
  output$contents <- DT::renderDataTable({
    req(input$file1)
    df <- read.csv(input$file1$datapath,sep=";")
    #data <- data.frame(df),
    library(DT)
    DT::datatable(df, options = list(pageLength = 10), width = "4")
  })
  
  #wyświetlam informacje o danych
  output$summary <- renderPrint({
    req(input$file1)
    df <- read.csv(input$file1$datapath,sep=";")
    datas <- data.frame(df)
    library(skimr)
    print(skim(datas))
  })
  
  #https://www.saedsayad.com/clustering_hierarchical.htm
  #https://stat.ethz.ch/R-manual/R-devel/library/stats/html/hclust.html
  #hierarchiczna - zstępująca
  output$h_zstepujaca<- renderPlot({
    tab <- read.csv(input$file1$datapath,sep=";")
    kl.h<-agnes(x=tab, metric="euclidean",method="single");
    plot(kl.h, which.plots=2,main="Zstępująca");
    #klastry.h<-cutree(kl.h, k=2);
    #wynik.h<-cbind(tab, klastry.h);

  })
  #hierarchiczna - wstępująca
  output$h_wstepujaca<- renderPlot({
    tab <- read.csv(input$file1$datapath,sep=";")
    kl.h<-agnes(x=tab, metric="euclidean",method="complete");
    plot(kl.h, which.plots=2,main="Wstępująca");
  })
  
  #obliczam k-średnich
  #https://www.youtube.com/watch?v=sAtnX3UJyN0
  output$ksrednich<- renderPlot({
    tab <- read.csv(input$file1$datapath,sep=";")
    tab.features = tab[3:8]
    results <- kmeans(tab.features,input$liczbaKlastrow)
    #results$size
    #results$cluster
    if (input$var==1) {
      plot(tab[c("High","Low")], col = results$cluster,pch = 19,cex = 1.5)
    } else {
      plot(tab[c("Open","Close")], col = results$cluster,pch = 19,cex = 1.5)
    }
  })
 
  
 
  
 
  
  #wpisuje dane do tabeli
  output$data123 <- DT::renderDataTable({
    tab <- read.csv(input$file1$datapath,sep=";")
    tab.features = tab[3:8]
    results <- kmeans(tab.features,3)
    wynik.i<-cbind(tab, results);
    library(DT)
    DT::datatable(wynik.i, options = list(pageLength = 5), width = "4")
  })
} #server end