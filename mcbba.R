#This script is intended to help anyone who wants to load 
#and use data from the Marin County Breeding Bird Atlas
library(sf) #st functions
library(tmap) #mapping
library(dplyr) #select
#load data
grid <- st_read("https://mcbba.github.io/webmap/mcbba.geojson")%>% st_transform(crs = 4326)
ebird <- read.csv("https://mcbba.github.io/webmap/ebird.csv")

#basic map
tm_shape(grid) +
  tm_borders()+
  tm_text("name", size = 1/2)

#join eBird data, and count species
ebird_grid <- grid %>%
  left_join(ebird, by = c("name" = "name")) %>%
  group_by(name)%>%
  count()

#richness map
tm_shape(ebird_grid) +
  tm_fill(col = "n",breaks=c(0,30,60,Inf))+
  tm_borders()+
  tm_layout(legend.position = c("left","bottom"))
  
