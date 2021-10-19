random_df <- tibble(
  motivation = c("egoistic", "altruistic", "no_motivation"),
  social = c("weak", "strong", "no_social"),
  geo = c("geo", "no_geo", "no_geo")
) |> tidyr::expand(motivation, social, geo) |>
  slice_sample(prop = 1) |> 
  right_join(table_texts) |> 
  mutate(text  = replace_na(text, "I did not come up with a text"))



# generate_vignette <- function(i = 1, city_location = rtc_geo_state()){
#   tagList(
#     HTML(
#     str_c(
#       "<p>", 
#       str_glue(random_df$text[i], city_name = city_location),
#       "</p>",
#       sep = " "
#     )
#   ),
#   sliderInput(inputId = paste0("sliderInput_", i),
#               label = div(style='width:400px;',
#                           div(style='float:left;', 'more likely'),
#                           div(style='float:right;', 'less likely')),
#               min = 0, max = 100, value = 1,
#               width = 400
#   )
#   )
# 
# }

generate_conjoint <- function(i = 1, city_location = rtc_geo_state()){
  tagList(
    fluidRow(
      HTML(
        "<h3>
            Which message would most likely prompt you to participate today? 
        </h3>"
      )
    ),
    fluidRow(
      column(4,
        HTML(
         str_c(
           "<p>", 
           "<i>message A:</i> <br>",
           str_glue(random_df$text[i], city_name = city_location),
           "</p>",
           sep = " "
         )
       )
             ),
      column(4,
             HTML(
               str_c(
                 "<p>", 
                 "<i>message B:</i> <br>",
                 str_glue(random_df$text[i+1], city_name = city_location),
                 "</p>",
                 sep = " "
               )
             )
      ),
      column(4,
             HTML(
               str_c(
                 "<p>", 
                 "<i>message C:</i> <br>",
                 str_glue(random_df$text[i+2], city_name = city_location),
                 "</p>",
                 sep = " "
               )
             )
      )
    ),
    fluidRow(
      column(10, align = "center",
             radioGroupButtons(
               inputId =  paste0("awesomeCheckboxGroup_", i),
               label = "Select one", 
               choices = c("A", "B", "C", "None of them"),
               selected = "None of them",
               individual = TRUE,
               # selected = "A",
               # checkIcon = list(
               #   yes = tags$i(class = "fa fa-check-square", 
               #                style = "color: steelblue"),
               #   no = tags$i(class = "fa fa-square-o", 
               #               style = "color: steelblue"))
             )
      )
    )
  )
}

output$vign_1_text <- renderUI({
  generate_conjoint(i = 1, 
                    city_location = rtc_geo_state())
})

output$vign_2_text <- renderUI({
  generate_conjoint(i = 4, 
                    city_location = rtc_geo_state())
})

# output$vign_1_text <- renderUI({
#     generate_vignette(i = 1, 
#     city_location = rtc_geo_state())
#   })
# 
# output$vign_2_text <- renderUI({
#   generate_vignette(i = 2, 
#                     city_location = rtc_geo_state())
# })

# output$vign_3_text <- renderUI({
#   generate_vignette(i = 3, 
#                     city_location = rtc_geo_state())
# })
# 
# output$vign_4_text <- renderUI({
#   generate_vignette(i = 4, 
#                     city_location = rtc_geo_state())
# })
# 
# output$vign_5_text <- renderUI({
#   generate_vignette(i = 5, 
#                     city_location = rtc_geo_state())
# })
# 
# output$vign_6_text <- renderUI({
#   generate_vignette(i = 6, 
#                     city_location = rtc_geo_state())
# })
# 
# output$vign_7_text <- renderUI({
#   generate_vignette(i = 7, 
#                     city_location = rtc_geo_state())
# })
# 
# output$vign_8_text <- renderUI({
#   generate_vignette(i = 8, 
#                     city_location = rtc_geo_state())
# })
# 
# output$vign_9_text <- renderUI({
#   generate_vignette(i = 9, 
#                     city_location = rtc_geo_state())
# })
# 
# output$vign_10_text <- renderUI({
#   generate_vignette(i = 10, 
#                     city_location = rtc_geo_state())
# })
# 
# output$vign_11_text <- renderUI({
#   generate_vignette(i = 11, 
#                     city_location = rtc_geo_state())
# })
# output$vign_12_text <- renderUI({
#   generate_vignette(i = 12, 
#                     city_location = rtc_geo_state())
# })
# output$vign_13_text <- renderUI({
#   generate_vignette(i = 13, 
#                     city_location = rtc_geo_state())
# })
# output$vign_14_text <- renderUI({
#   generate_vignette(i = 14, 
#                     city_location = rtc_geo_state())
# })
# output$vign_15_text <- renderUI({
#   generate_vignette(i = 15, 
#                     city_location = rtc_geo_state())
# })
# output$vign_16_text <- renderUI({
#   generate_vignette(i = 16, 
#                     city_location = rtc_geo_state())
# })
# output$vign_17_text <- renderUI({
#   generate_vignette(i = 17, 
#                     city_location = rtc_geo_state())
# })
# output$vign_18_text <- renderUI({
#   generate_vignette(i = 18, 
#                     city_location = rtc_geo_state())
# })


# output$vign_1_text <- renderUI({
#   tagList(HTML(
#     str_c(
#       "<p>", 
#       str_glue(random_df$text[1], city_name = rtc_geo_state()),
#       "</p>",
#       sep = " "
#     )
#   ),
#   sliderInput(inputId = "sliderInput_1", 
#               label = div(style='width:400px;', 
#                           div(style='float:left;', 'more likely'), 
#                           div(style='float:right;', 'less likely')),  
#               min = 0, max = 100, value = 1,
#               width = 400
#   ))
# })
# 
# output$vign_2_text <- renderUI({
#   tagList(HTML(
#     str_c(
#       "<p>", 
#       str_glue(random_df$text[2], city_name = rtc_geo_state()),
#       "</p>",
#       sep = " "
#     )
#   ),
#   sliderInput(inputId = "sliderInput_2", 
#               label = div(style='width:400px;', 
#                           div(style='float:left;', 'more likely'), 
#                           div(style='float:right;', 'less likely')),  
#               min = 0, max = 100, value = 1,
#               width = 400
#   ))
# })
