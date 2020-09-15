setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap04-Graficos")
getwd()

# library(plotrix)
# ablineclip(v=4, lty=3, col="paleturquoise4", lwd = 1)
install.packages("googleVis")
library(googleVis)
?googleVis

# Criando um Dataframe
df = data.frame(País = c("BR", "CH", "AR"),
                Exportações = c(10, 13, 14),
                Importações = c(23, 12, 32)
                )
head(df)


# Gráfico de linha
Line <- gvisLineChart(df)
plot(Line)

# Gráfico de Barras
Column <- gvisColumnChart(df)
plot(Column)

# Gráfico de Barras Horizontais
df$Saldo <- df$Exportações - df$Importações
Bar <- gvisBarChart(df)
plot(Bar)

# Gráfico de Pizza
Pie <- gvisPieChart(CityPopularity)
plot(Pie)

# Gráficos combinados
Combo <- gvisComboChart(df,
                        xvar = "País",
                        yvar = c("Exportações", "Importações", "Saldo"),
                        options = list(seriesType = "bars",
                                       series='{2: {type:"line"}}')
                        )
plot(Combo)             

# Scatter Chart
Scatter <- gvisScatterChart(women,
                            options = list(
                              legend="none",
                              lineWidth = 2,
                              pointsSize = 0,
                              title = "Women",
                              vAxis = "{title:'weight (lbs)'}",
                              hAxis = "{title:'height (in)'}",
                              width = 800,
                              heigth = 300)
                            )
plot(Scatter)                        

# Bubble
Bubble <- gvisBubbleChart(Fruits,
                          idvar = "Fruit",
                          xvar = "Sales",
                          yvar = "Expenses",
                          colorvar = "Year",
                          sizevar = "Profit",
                          options = list(hAxis = '{minValue:75, maxValue:125}')
                          )
plot(Bubble)

# Customizado
M <- matrix(nrow = 6, ncol = 6)
M[col(M) == row(M)] <- 1:6
M

dat <- data.frame(X = 1:6, M)
SC <- gvisScatterChart(dat,
                       options = list(
                         title = "Customizing points",
                         legend = "right",
                         pointSize = 30,
                         series = "{
                         0: { pointShape: 'circle' },
                         1: { pointShape: 'triangle' },
                         2: { pointShape: 'square' },
                         3: { pointShape: 'diamond' },
                         4: { pointShape: 'star' },
                         5: { pointShape: 'polygon' }
                         }")
                       )
plot(SC)

# Gauge
Gauge <- gvisGauge(
  CityPopularity,
  options = list(min = 0,
                 max = 800,
                 greenFrom = 500,
                 greenTo = 800,
                 yellowFrom = 300,
                 yellowTo = 500,
                 redFrom = 0,
                 redTo = 300,
                 width = 400,
                 heigth = 300)
  )
plot(Gauge)

# Mapas
Intensity <- gvisIntensityMap(df)
plot(Intensity)

# Geo Chart
Geo = gvisGeoChart(Exports,
                   locationvar = "Country",
                   colorvar = "Profit",
                   options = list(projection = "kavrayskiy-vii"))
plot(Geo)

# Google Maps
AndrewMap <- gvisMap(Andrew,
                     "LatLong",
                     "Tip",
                     options = list(
                       showTip = T,
                       showLine = T,
                       enableScrollWhell = T,
                       mapType = 'terrain',
                       useMapTypeControle = T
                     )
                    )
plot(AndrewMap)

# Dados em gráficos. Nível de analfabetismo nos EUA
require(datasets)
states <- data.frame(state.name, state.x77)
GeoStates <- gvisGeoChart(states, 
                          "state.name", 
                          #"Illiteracy",
                          "Murder",
                          options = list(
                            region="US",
                            displayMode = "regions",
                            resolution = "provinces",
                            width = 600,
                            height = 400
                            )
                          )
plot(GeoStates)
