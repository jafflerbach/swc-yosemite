## Data Visualization 

library(tidyverse)

surveys_complete <- read.csv('data_output/surveys_complete.csv')

## ggplot2 

ggplot(data = surveys_complete, aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color = species_id))

## Challenge

## Use what you just learned to create a scatter plot of weight over species_id
## with the plot types showing in different colors. Is this a good way to show
## this type of data?

ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
  geom_point(alpha = 0.1, aes(color = plot_type))


## boxplot instead of a scatter

ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
  geom_boxplot(aes(color = plot_type)) +
  facet_grid(sex ~ .)+
  labs(x = "Species",
       y = "Weight",
       title = "Plot")


## Time Series ----

## examining time series of species 

yearly_counts <- surveys_complete %>%
  group_by(year, species_id) %>%
  tally

ggplot(data = yearly_counts, 
       aes(x = year, y = n, 
           group = species_id, 
           color = species_id)) +
  geom_line() +
  facet_wrap(~ species_id)

## examining time series of species + sex

yearly_sex_counts <- surveys_complete %>%
  group_by(year, species_id, sex) %>%
  tally

ggplot(data = yearly_sex_counts, 
       aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~ species_id)

##Challenge

## Use what you just learned to create a plot that
## depicts how the average weight of each species
## changes through the years.












