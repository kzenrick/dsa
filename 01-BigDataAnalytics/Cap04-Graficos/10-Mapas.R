setwd("~/Documentos/dsa/BigDataAnalytics/Cap04-Graficos")
getwd()

cores = c("red", "green", "blue", "yellow", "orange", "brown", "cyan", "black", 
          "brown", "gray", "whitesmoke")

# library(plotrix)
# ablineclip(v=4, lty=3, col="paleturquoise4", lwd = 1)

# Instala os pacotes
install.packages(c( "maps", "mapdata"))

# Carrega os pacotes
library(ggplot2)
library(maps)
library(mapdata)

# Função para as coordenadas dos países
?map_data
mapa <- map_data("world")

# Visualização do data frame
dim(mapa)
View(mapa)

# Gerando o Mapa
ggplot() +
  geom_polygon(data = mapa,
               aes(x = long,
                   y = lat,
                   group = group)) +
  coord_fixed(1.3)


ggplot() +
  geom_polygon(data = mapa,
               aes(x = long,
                   y = lat,
                   group = group),
               fill = NA,
               color = "blue"
               ) +
  coord_fixed(1.3)


gg1 <- ggplot() +
  geom_polygon(data = mapa,
               aes(x = long,
                   y = lat,
                   group = group),
               fill = "seagreen",
               color = "blue"
               ) +
  coord_fixed(1.3)
gg1

# Marcando alguns pontos no mapa
labs <- data.frame(
  long = c(69.24140, -2.8456051),
  lat = c(-78.38995, 22.44512),
  names = c("Ponto1", "Ponto2"),
  stringsAsFactors = F
)

# Pontos no mapa
gg1 + 
  geom_point(data = labs,
             aes(x = long, y = lat),
             color = "black",
             size = 2
             ) +
  geom_point(data = labs,
             aes(x = long, y = lat),
             color = "yellow",
             size = 2
             )

# Divisão por países
ggplot(data = mapa) +
  geom_polygon(aes(x = long,
                   y = lat,
                   fill = region,
                   group = group),
               color = "white") +
  coord_fixed(1.3) +
  guides(fill = F)
