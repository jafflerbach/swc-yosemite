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

surveys %>%
  filter(!is.na(weight)) %>%
  mutate(weight_kg = weight / 1000,
         weight_kg2 = weight_kg * 2) %>%
  head

## Challenge
## Create a new data frame from the surveys data that 
## meets the following criteria: contains only the species_id 
## column and a new column called  hindfoot_half containing values 
## that are half the hindfoot_length values. In this hindfoot_half
## column,there are no NAs and all values are less than 30.

challenge1 <- surveys %>%
  mutate(hindfoot_half = 0.5 * hindfoot_length) %>%
  select(species_id, hindfoot_half) %>%
  filter(!is.na(hindfoot_half), hindfoot_half < 30)

## group_by and summarize

surveys %>%
  filter(sex == "F" | sex == "M") %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = T),
            min_weight = min(weight, na.rm = T))

## tally counts the total number of observations for the variable
surveys %>%
  group_by(sex) %>%
  tally

## Challenge

## 1. How many individuals were caught in each plot_type surveyed?

surveys %>% 
  group_by(plot_type) %>%
  tally

## 2. Use group_by() and summarize() to find the mean, min, and 
## max hindfoot length for each species (using species_id).

surveys %>%
  select(hindfoot_length, species_id) %>%
  filter(!is.na(hindfoot_length)) %>%
  group_by(species_id) %>%
  summarize(mean_length = mean(hindfoot_length),
            min_length = min(hindfoot_length),
            max_length = max(hindfoot_length))

## 3. What was the heaviest animal measured in each year? Return
## the columns year, genus, species_id, and weight.
surveys %>%
  select(year, genus, species_id, weight) %>%
  group_by(year) %>%
  top_n(1, weight) %>%
  arrange(year)

## answer 2
surveys %>%
    filter(!is.na(weight)) %>%
    group_by(year) %>%
    filter(weight == max(weight)) %>%
    select(year, genus, species, weight) %>%
    arrange(year)

## 4. You saw above how to count the number of individuals of each sex using a
## combination of group_by() and tally(). How could you get the same result using
## group_by() and summarize()? Hint: see ?n.

surveys %>% 
  group_by(sex) %>% 
  summarise(n())

## EXPORTING DATA ----

surveys_complete <- surveys %>%
  filter(species_id != "")%>%  ##remove missing species_id
  filter(!is.na(weight))%>%
  filter(!is.na(hindfoot_length))%>%
  filter(sex != "")
  
surveys_complete <- surveys %>%
  filter(species_id != "",
         !is.na(weight),
         !is.na(hindfoot_length),
         sex != "")
  
## Extract the most common species_id

species_counts <- surveys_complete %>%
  group_by(species_id) %>%
  tally %>%
  filter( n >= 50)

## Only keep the most common species

surveys_comm_spp <- surveys_complete %>%
  filter(species_id %in% species_counts$species_id) 

## save the surveys_comm_spp dataframe to disk by using write.csv()

write.csv(surveys_comm_spp, file = "data_output/surveys_complete.csv")
  
  
  
  
  
  
  
  


