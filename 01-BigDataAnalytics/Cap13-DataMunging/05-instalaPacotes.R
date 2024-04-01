setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap13-DataMunging")
getwd()

# Verifica se excutando no Azure
Azure <- F

# Carga dos dados de acord com local em que executando
if (Azure){
  # instala os pacotes tidyr e as dependencias
  install.packages('src/rlang_0.3.1.zip', lib = '.', repos = NULL, verbos = T)
  install.packages('src/tibble_2.0.1.zip', lib = '.', repos = NULL, verbos = T)
  install.packages('src/tidyr_0.8.2.zip', lib = '.', repos = NULL, verbos = T)
  
  require(tibble, lib.loc = '.')
  require(rlang, lib.loc = '.')
  require(tidyr, lib.loc = '.')
}else{
  require(tidyr)
}


if (Azure) maml.mapOutputPort("dataset")
