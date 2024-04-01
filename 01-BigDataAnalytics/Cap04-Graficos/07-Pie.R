setwd("~/Documentos/dsa/BigDataAnalytics/Cap04-Graficos")
getwd()

cores = c("red", "green", "blue", "yellow", "orange", "brown", "cyan", "black", 
          "brown", "gray", "whitesmoke")

library(plotrix)
# ablineclip(v=4, lty=3, col="paleturquoise4", lwd = 1)

?pie

# Criando as fatias
fatias = c(40,20,40)

# Criando os lables
paises = c("Brasil", "Argentina", "Chile")

# unindo países e fatias
paises = paste(paises, fatias)

# incluindo mais detalhes no label
paises = paste(paises, "%", sep = "")

# Construindo um gráfico
pie(fatias
    , labels = paises
    , col = c("darksalmon", "gainsboro", "lemonchiffon4")
    , main = "Distribuição de Vendas")

# Trabalhando com dataframes
?iris
attach(iris)
values = table(Species)
labels = paste(names(values))

pie(values, 
    labels = labels,
    col = c("steelblue1", "tomato2", "tan3"),
    main = "Distribuiçção de Espécies"
    )

# 3D
library(plotrix)

pie3D(fatias
      , labels = paises
      , explode = 0.1
      , col = c("steelblue1", "tomato2", "tan3")
      , main = "Distribuição de vendas")
