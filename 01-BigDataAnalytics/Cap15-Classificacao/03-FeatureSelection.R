# https://archive.ics.uci.edu/ml/datasets/Statlog+(German+Credit+Data)
setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap15-Classificacao")
getwd()

# Variável de controle de execução do script
Azure <- F

# Execução de acordo com o local

if (Azure) {
  source('src/ClassTools.R')
  Credit <- maml.mapInputPort(1)
} 


# Modelo randomForest para criar um plot de importância das variáveis
library(randomForest)

modelo <- randomForest(CreditStatus ~ .
                       - Duration
                       - Age
                       - CreditAmount
                       - ForeignWorker
                       - NumberDependents
                       - Telephone
                       - ExistingCreditsAtBank
                       - PresentResidenceTime
                       - Job
                       - Housing
                       - SexAndStatus
                       - InstallmentRatePecnt
                       - OtherDetorsGuarantors
                       - Age_f
                       - OtherInstalments,
                       data = Credit,
                       ntree = 100,
                       nodesize = 10,
                       importance = T)

varImpPlot(modelo)

outFrame <- serList(list(credit.model = modelo))


# retorno no Azure
if (Azure) maml.mapOutputPort('Credit')