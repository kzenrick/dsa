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


# Plots usando ggplot2
library(ggplot2)

lapply(colNames2,
       function(x){
         if (is.factor(Credit[, x])) {
           ggplot(Credit, aes_string(x)) +
             geom_bar() +
             facet_grid(. ~ CreditStatus) +
             ggtitle(paste('Total de Credito Bom/Ruim por', x))
         }
       }
       )

# Plots CreditStatus vs CheckingAcctStat
lapply(colNames2,
       function(x){
         if (is.factor(Credit[, x]) & x != "CheckingAcctStat") {
           ggplot(Credit, aes(CheckingAcctStat)) +
             geom_bar() +
             facet_grid(paste(x, "~ CreditStatus")) +
             ggtitle(paste('Total de Credito Bom/Ruim por CheckingAcctStat e', x))
         }
       }
)


# retorno no Azure
if (Azure) maml.mapOutputPort('Credit')