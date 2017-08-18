surveys <- read.csv("data/portal_data_joined.csv")

install.packages("tidyverse")
library(tidyverse)

## select the columns plot_id,species_id and weight from the 
## surveys dataframe
select(surveys, plot_id, species_id, weight)

## using filter select rows where year is 1995
filter(surveys, year == 1995)

#PIPES!!!

## THIS IS A PIPE    %>%

surveys_sml <- surveys %>%
  filter(weight < 5) %>%  ## filter is for rows
  select(species_id, sex, weight) # select is for columns

surveys_sml



