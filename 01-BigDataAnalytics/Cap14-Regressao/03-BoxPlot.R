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

# Convertendo a variável dayWeek para fator ordenado e plotando em ordem de tempo
bikes$dayWeek <- fact.conv(bikes$dayWeek)

# Denabda de bikes x potenciais variáveis preditoras
labels <- list('Boxplots - Demanda de Bikes por Hora', 
               'Boxplots - Demanda de Bikes por Clima no dia', 
               'Boxplots - Demanda de Bikes por Dia Util',
               'Boxplots - Demanda de Bikes por Dia da Semana')

xAxis <- list('hr',
              'weathersit',
              'isWorking',
              'dayWeek')

# função para criar os boxplots
plot.boxs <- function(X, label){
  ggplot(bikes,
         aes_string(x = X, y = 'cnt', group = X))+
    geom_boxplot() +
    ggtitle(label) +
    theme(text = element_text(size = 18))
}

Map(plot.boxs, xAxis, labels)

# Gera a saída no Azure ML
if(Azure) maml.mapOutputPort('bikes')
