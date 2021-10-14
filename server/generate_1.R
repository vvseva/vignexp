random_df <- tibble(
  motivation = c("egoistic", "altruistic", "no_motivation"),
  social = c("weak", "strong", "no_social"),
  geo = c("geo", "no_geo", "no_geo")
) |> tidyr::expand(motivation, social, geo) |>
  slice_sample(prop = 1)


# vign_1 <- reactiveValues(values = random_df |> head(1))


output$vign_1_text <- renderUI({
  tagList(HTML(
    str_c(
      "<p>", 
      "motivation:", random_df$motivation[1],
      "social:", random_df$social[1],
      "geo:",random_df$geo[1],
      "</p>",
      sep = " "
    )
  ),
  sliderInput(inputId = "n", 
              label = div(style='width:400px;', 
                          div(style='float:left;', 'more likely'), 
                          div(style='float:right;', 'less likely')),  
              min = 0, max = 100, value = 1,
              width = 400
  ))
})

output$vign_2_text <- renderUI({
  tagList(HTML(
    str_c(
      "<p>", 
      "motivation:", random_df$motivation[2],
      "social:", random_df$social[2],
      "geo:",random_df$geo[2],
      "</p>",
      sep = " "
    )
  ),
  sliderInput(inputId = "n", 
              label = div(style='width:400px;', 
                          div(style='float:left;', 'more likely'), 
                          div(style='float:right;', 'less likely')),  
              min = 0, max = 100, value = 1,
              width = 400
  ))
})
