#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(dotenv)
library(dplyr)
library(highcharter)
library(httr)
library(lubridate)
library(mlr)
library(plyr)
library(rlist)
library(shiny)
library(shinybusy)
library(shinyjs)
library(shinyWidgets)
# library(spotifyr)
library(sass)
library(stringr)
library(waiter)
library(shinysky)

source("server/functions.R")

# Define UI for application that draws a histogram
css <- sass(sass_file("www/styles.scss"))
ui <- source(file.path("ui", "ui.R"), local = TRUE)$value


# Define server logic required to draw a histogram
ui <- source(file.path("ui", "ui.R"), local = TRUE)$value
# Define server logic required to draw a histogram
server <- function(input, output, session) {
  # runjs(jscode)
  # get_access_token <- reactive({
  #   url_hash <- getUrlHash()
  #   access_token <- url_hash %>% str_replace('&.*', '') %>% str_replace('.*=', '')
  #   access_token
  # })
  # a <- reactive({
  #   getUrlHash()
  # })
  # print("am here")
  # print(isolate(get_access_token()))
  # print(isolate(a()))
  # source(file.path("server", "functions.R"), local = TRUE)$value
  # if (local) {
  #   load("files.RData")
  # } else {
  #   source(file.path("server", "create_spotify_thingys.R"), local = TRUE)$value
  # }
  
  source(file.path("server", "generate_1.R"), local = TRUE)$value
  source(file.path("server", "location.R"), local = TRUE)$value
  # source(file.path("server", paste("generate_2.R", random_df[1, 1])), local = TRUE)$value
  # source(file.path("server", "cluster_react.R"), local = TRUE)$value
  # source(file.path("server", "highcharts.R"), local = TRUE)$value
  # source(file.path("server", "ui_outputs.R"), local = TRUE)$value
  # source(file.path("server", "modal.R"), local = TRUE)$value
  # source(file.path("server", "reactive_values.R"), local = TRUE)$value
  # source(file.path("server", "event_observer.R"), local = TRUE)$value
  # source(file.path("server", "text_outputs.R"), local = TRUE)$value
}

# Run the application
shinyApp(
  ui = ui,
  server = server
)
