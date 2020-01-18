library(shiny)
library(shinydashboard)


ui <- dashboardPage(skin = "blue",
                    dashboardHeader(title = "Klasteryzacja"),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Dane", tabName = "dashboard", icon = icon("database")),
                        menuItem("Wykresy", tabName = "Charts", icon = icon("stats", lib = "glyphicon"))
                      )
                    ),
                    dashboardBody(
                      tabItems(
                        # Dane
                        tabItem(tabName = "dashboard",
                                fluidRow(
                                  box(title="Dane", fileInput("file1", "Wybierz plik CSV"), status = "primary", solidHeader = TRUE, width = "12"),
                                  box(title = "Podglad danych",DT::dataTableOutput("contents"), status = "primary", solidHeader = TRUE, width = "12"),
                                  box(title = "Podsumowanie danych",verbatimTextOutput("summary"), status = "primary", solidHeader = TRUE, width = "12")
                                  
                                )
                        ),
                        
                        # Wykresy
                        tabItem(tabName = "Charts",
                                h2("Analiza"),
                                
                               
                                fluidRow(
                                  box(title = "Hierarchiczna - zstepujaca", plotOutput("h_zstepujaca"), status = "primary", solidHeader = TRUE, width = 12),
                                  box(title = "Hierarchiczna - wstepujaca", plotOutput("h_wstepujaca"), status = "primary", solidHeader = TRUE, width = 12),
                                  
                                  
                                  box(selectInput("var",
                                                  label = "Wybierz argumenty",
                                                  choices = c("High i Low"=1, "Open i Close"=2),
                                                  selected = 1),
                                      selectInput("liczbaKlastrow",
                                                  label = "Wybierz liczbe klasatrow",
                                                  choices = c("1"=1, "2"=2,"3"=3),
                                                  selected = 3),
                                      
                                      title = "K-Srednich", plotOutput("ksrednich"), status = "primary", solidHeader = TRUE, width = 12),
                                  box(title = "Sylwetka", plotOutput("sylwetka"), status = "primary", solidHeader = TRUE),
                                  box(title = "Separowalnosc", plotOutput("separowalnosc"), status = "primary", solidHeader = TRUE)
                                  
                                  
                                  
                                )   
                                
                        )
                      ) 
                    )
)