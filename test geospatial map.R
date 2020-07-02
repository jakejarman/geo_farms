##test geom_SF and basemap

library(tidyverse)
library(sf)
library(ggmap)

farms <- read_csv("Farm locations all modified v2 GIS.csv")

#are there NAs or erroneous data?
summary(farms)

#filter out NAs
farms <- farms %>% filter(!is.na(Longitude))

#check again
summary(farms)

#make an sf object
farms_sf = st_as_sf(farms, coords = c("Longitude", "Latitude"), crs = 4326)

ggplot()+
  geom_sf(data = farms_sf)

# Google API key - Mark Neal's - do not abuse!
register_google("AIzaSyBpUFWIOXcwXNzu31Ou6lZpzln3SBMnsog")

nz_map <- get_map(location = "New Zealand", zoom = 6)
waikato_map <- get_map(location = "Waikato", zoom = 7)

ggmap(nz_map) +
  theme_minimal() +
  geom_sf(data = farms_sf, inherit.aes = FALSE) 

ggmap(waikato_map) +
  theme_minimal() +
  geom_sf(data = farms_sf, inherit.aes = FALSE) 

ggsave("my_nzmap.png", width = 8, height = 8)
