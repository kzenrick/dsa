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

# Avaliando a demanda por aluguel de bikes ao longo do tempo
# Construindo um time series plot para alguns determinados horários
# em dias úteis e dias de fim de semana.
times <- c(7, 9, 12, 15, 18, 20, 22)

# Time Series Plots
tms.plot <- function(times){
  ggplot(bikes[bikes$workTime == times, ],
         aes(x = dteday, y = cnt)) +
    geom_line() +
    ylab('Numero de Bikes') + 
    labs(title = paste('Demanda de Bikes as ', as.character(times), ':00', sep = '')) +
    theme(text = element_text(size = 20))
}

lapply(times, tms.plot)

# Gera a saída no Azure ML
if(Azure) maml.mapOutputPort('bikes')