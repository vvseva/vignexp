load("map.RData")
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


output$geo_show_text <- renderUI({
  
  if (is.null(input$lat)) {
    tagList(HTML("
                 no location, please select manually
                 "))
    
    fluidRow(
      column(10, align="center",
             select2Input("select2Input1",
               "This is a multiple select2Input",
                choices=c("a","b","c"),
                selected=c("b","a"),
                width = "600px"
                )
      )
    )
  } else {
  geo_state = str_glue(
    "http://open.mapquestapi.com/nominatim/v1/reverse.php?key={key_}&format=json&lat={lat_}&lon={long_}",
    key_ = OSM_API_KEY,
    lat_ = input$lat,
    long_ = input$long) |> 
    GET() |>
    httr::content() |>
    purrr::pluck("address") |>
    purrr::pluck("state")
  
  tagList(HTML(
    str_c(
      "<p>",
      "Your location is ",
      "lattitude:", input$lat,
      "<br>",
      "longitude:", input$long,
      "<br>",
      "geolocation:", 
      geo_state,
      "</p>",
      sep = " "
    )
  ))
}
  
})