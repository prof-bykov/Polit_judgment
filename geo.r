# Local digital platforms for public administration in Russia (2021)
# New administrative borders with Crimea and Sevastopol are developed from https://github.com/logvik/d3_russian_map

# Check working directory
getwd()

# Loading required packages

library(cartography)
library(sf)
library(ggplot2)

# Load map of Russia with subjects 
RUS <- st_read("./Data/current_russia_mercator.shp")

# Check how it looks

View(RUS)
plot(RUS)

# Loading data to visualize

map.data <- read.csv('mapstat.csv', header=T, encoding = 'UTF-8')
row.names(map.data) <- as.character(map.data$ID_1)

# Creating dataframe with both polygons and data to be visualized

map.df <- merge(RUS, map.data, by="ID_1")

# Check data

View(map.df)

# Simple plot

plot(st_geometry(map.df))
choroLayer(x=map.df, var="Platforms", breaks=c(1,2), nclass=NULL)

# Advanced pot

ggplot(data=map.df) +
  geom_sf(aes(fill = Platforms), color="black", size=.1) +
  scale_fill_gradient(low = "white", high="black") +
  theme(legend.position="bottom") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank())
  
# save image

ggsave("map.png", width=6, height=6, dpi=600)