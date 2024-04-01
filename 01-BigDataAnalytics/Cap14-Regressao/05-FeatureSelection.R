# https://archive.ics.uci.edu/ml/datasets/bike+sharing+dataset

setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap14-Regressao")
getwd()

# --------------------- Variável de controle de execução do script
Azure <- F


source('src/Tools.R')
if (Azure) {
  # source('src/Tools.R')
  bikes <- maml.mapInputPort(1)
  bikes$dteday <- set.asPOSIXct(bikes)
} else {
  # source('src/Tools.R')
  bikes <- bikes
}

# --------------------- Feature Selection

# Verifica pacotes nulos
dim(bikes)
any(is.na(bikes))

# Criando um modelo para identificar os atributos com maior importância para o modelo preditivo
require(randomForest)

# Avaliando a importância de todas as variáveis
modelo <- randomForest(cnt ~ .,
                       data = bikes,
                       ntree = 100,
                       nodesize = 10,
                       importance = T)

# Plotando as variaveis por grau de importância
varImpPlot(modelo)

# removendo as variáveis colineares
modelo <- randomForest(cnt ~ . 
                       - mnth
                       - hr
                       - workingday
                       - isWorking
                       - dayWeek
                       - xformHr
                       - workTime
                       - holiday
                       - windspeed
                       - monthCount
                       - weathersit,
                       data = bikes,
                       ntree = 100,
                       nodesize = 10,
                       importance = T)

# Plotando as variaveis por grau de importância nvoamente
varImpPlot(modelo)
                       
# Gravando o resultado
df_saida <- bikes[, c('cnt', rownames(modelo$importance))]


# --------------------- Gera a saída no Azure ML
if(Azure) maml.mapOutputPort('df_saida')