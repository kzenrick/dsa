# https://archive.ics.uci.edu/ml/datasets/Statlog+(German+Credit+Data)
setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap15-Classificacao")
getwd()

# Variável de controle de execução do script
Azure <- F

# Execução de acordo com o local
source('src/ClassTools.R')

if (Azure) {
  Credit <- maml.mapInputPort(1)
} else {
  Credit <- read.csv('credito.csv',
                    sep = ',',
                    header = F,
                    stringsAsFactors = F)
  
  # Cria um data frame de metadata, para 'ensinar' a configurar o data frame Cedit
  metaFrame <- data.frame(colNames,
                          isOrdered,
                          I(factOrder)
                          )
  
  # Converte os campos não numéricos e o campo alvo para fatorial
  Credit <- fact.set(Credit, metaFrame)
  
  # Balancear o número de casos positivos e negativos
  Credit <- equ.Frame(Credit, 2)
}

# Transformar variáveis númericas em variáveis categóricas
toFactors <- c('Duration', 'CreditAmount', 'Age')
maxVals <- c(100, 1000000, 100)

facNames <- unlist(lapply(toFactors, 
                          function(x) paste(x, '_f', sep='')
                          )
                   )

Credit[, facNames] <- Map(function(x, y) quantize.num(Credit[, x], maxval = y),
                          toFactors,
                          maxVals
                          )

if (Azure) maml.mapOutputPort('Credit')