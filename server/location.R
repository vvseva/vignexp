
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
      column(12, align="center",
        actionButton("btn_ask_geo1", "Share location", style="background-color: #EBEBEC"),
        actionButton("btn_ask_geo0", "No")
      )
    )
  )
})


output$geo_show_text <- renderUI({
  tagList(HTML(
    str_c(
      "<p>",
      "Your location is ",
      "lattitude:", input$lat,
      "longitude:", input$long,
      "<br>",
      "geolocation:", input$geolocation,
      "</p>",
      sep = " "
    )
  ))
})