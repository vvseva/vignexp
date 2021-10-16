# shinyjs::hide("selectInput_geo_manual_row")
# 
# observeEvent(input$btn_ask_geo0, {
#   req(input$btn_ask_geo0)
#   shinyjs::show("selectInput_geo_manual_row")
# })

observeEvent(input$btn_ask_geo1, {
  # Run JS code that simply shows a message
  runjs('  $(document).ready(function () {
    navigator.geolocation.getCurrentPosition(onSuccess, onError);

    function onError (err) {
    Shiny.onInputChange("geolocation", false);
    }

   function onSuccess (position) {
      setTimeout(function () {
          var coords = position.coords;
          console.log(coords.latitude + ", " + coords.longitude);
          Shiny.onInputChange("geolocation", true);
          Shiny.onInputChange("lat", coords.latitude);
          Shiny.onInputChange("long", coords.longitude);
      }, 1100)
  }
  });')
  runjs(
    '$(document).ready(function () {
      window.scrollBy(10, 0);
    }
    '
  )
})


output$geo_collect <- renderUI({
  tagList(
    # useShinyjs(),
    HTML("<p>
       gimme your location
    </p>"),
    # Set up shinyjs
    fluidRow(
      column(10, align="center",
        actionButton("btn_ask_geo1", "Share location", style="background-color: #EBEBEC"),
        actionButton("btn_ask_geo0", "No")
      )
    )
  )
})

output$geo_collect_manual <- renderUI({
  if (input$btn_ask_geo0) {
    fluidRow(
      column(10, align = "center",
             selectInput(
               inputId = "selectInput_geo_manual",
               label = "Select one of the cities",
               choices = c("San Francisco",
                           "New York",
                           "Chicago",
                           "Other")
             )
      )
    )
  } else {
    HTML("<p>
       you location will not be stored
    </p>")
  }
})

# toListen_geo <- reactive({
#   list(input$lat,input$selectInput_geo_manual)
# })

rtc_geo_state <- reactiveVal("your city")

observeEvent(
  input$lat, {
  if (!is.null(input$lat)) {
    geo_state <- str_glue(
      "http://open.mapquestapi.com/nominatim/v1/reverse.php?key={key_}&format=json&lat={lat_}&lon={long_}",
      key_ = OSM_API_KEY,
      lat_ = input$lat,
      long_ = input$long) |> 
      GET() |>
      httr::content() |>
      purrr::pluck("address") |>
      purrr::pluck("state")
    
    rtc_geo_state(geo_state)
  } else {
    rtc_geo_state("your city")
  }
})

observeEvent(
  input$selectInput_geo_manual,{
    if (input$selectInput_geo_manual == "Other") {
      rtc_geo_state("your city")
    } else {
      rtc_geo_state(input$selectInput_geo_manual)
    }
})

output$geo_show_text <- renderUI({
  if (is.null(input$lat)) {
    
    fluidRow(column(
      10,
      align = "center",
    tagList(HTML("
                <p>
                 no location, please select manually
                 </p>
                 ")),
    tagList(HTML(str_glue("
                <p>
                 selected city: {location}
                 </p>
                 ", location = rtc_geo_state()
                          )))
    ))
  } else {
  tagList(HTML(
    str_c(
      "<p>",
      "Your location is ",
      "lattitude:", input$lat,
      "<br>",
      "longitude:", input$long,
      "<br>",
      "geolocation:", 
      # geo_state,
      rtc_geo_state(),
      "</p>",
      sep = " "
    )
  ))
}
  
})