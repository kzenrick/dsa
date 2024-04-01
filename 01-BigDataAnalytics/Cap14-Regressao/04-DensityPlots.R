# https://archive.ics.uci.edu/ml/datasets/bike+sharing+dataset

setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap14-Regressao")
getwd()

# Variável de controle de execução do script
Azure <- F

require(ggplot2)

source('src/Tools.R')
if (Azure) {
  # source('src/Tools.R')
  bikes <- maml.mapInputPort(1)
  bikes$dteday <- set.asPOSIXct(bikes)
} else {
  # source('src/Tools.R')
  bikes <- bikes
}

# Visualizando o relacionamento entre as variáveis preditores e demanda por bike
labels <- c('Demanda de Bikes vs Temperatura', 
            'Demanda de Bikes vs Humidade', 
            'Demanda de Bikes vs Velocidade do Vento',
            'Demanda de Bikes vs Hora')

xAxis <- list('temp',
              'hum',
              'windspeed',
              'hr')

# função para criar os boxplots
plot.scatter <- function(X, label){
  ggplot(bikes,
         aes_string(x = X, y = 'cnt')) +
    geom_point(aes_string(colour = 'cnt'), alpha = 0.1) +
    scale_colour_gradient(low = 'green', high = 'blue') +
    geom_smooth(method = 'loess') +
    ggtitle(label) +
    theme(text = element_text(size = 20))
}

Map(plot.scatter, xAxis, labels)

# Explorando a interação entre tempo e dia, em dias da semana e fins de semana
labels <- list('Box plots - Demanda por Bikes as 09:00 para \n dias da semana e fins de semana',
               'Box plots - Demanda por Bikes as 18:00 para \n dias da semana e fins de semana')

Times <- list(9, 18)

plot.box2 <- function(time, label){
  ggplot(bikes[bikes$hr == time,],
         aes(x = isWorking, y = cnt, group = isWorking)) +
    geom_boxplot() +
    ggtitle(label) +
    theme(text = element_text(size = 18))
}

Map(plot.box2, Times, labels)

# Gera a saída no Azure ML
if(Azure) maml.mapOutputPort('bikes')
