# fluidRow(column(width = 2,
#                 verbatimTextOutput("lat"),
#                 verbatimTextOutput("long"),
#                 verbatimTextOutput("geolocation"))
# )



tags$section(
  class = "content_page",
  uiOutput("geo_show_text")
             )
