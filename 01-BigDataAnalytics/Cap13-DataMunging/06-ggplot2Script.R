setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap13-DataMunging")
getwd()

# Verifica se excutando no Azure
Azure <- F

# Carga dos dados de acord com loca em que executando
if (Azure){
  source("src/Tools.R")
  Bikes <- maml.mapInputPort(1)
  Bikes$dteday <- set.asPOSIXct(Bikes)
}else{
  source("Tools.R")
  Bikes <- read.csv("datasets/bikes.csv",
                    sep = ",",
                    header = T,
                    stringsAsFactors = F)
  Bikes$dteday <- char.toPOSIXct(Bikes)
}

require(dplyr)
# Filtrando o dataframe
Bikes <- Bikes %>% filter(hr == 9)

# ggplot2
require(ggplot2)

ggplot(Bikes,
      aes(x = dteday, y = cnt)) + 
  geom_line() +
  ylab("Nº de Bikes") +
  xlab("Linha to Tempo") +
  ggtitle("Demanda de Bike às 09hs") +
  theme(text = element_text(size = 20))

if (Azure) maml.mapOutputPort("Bikes")

