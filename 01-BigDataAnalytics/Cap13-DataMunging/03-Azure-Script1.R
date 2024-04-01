# Verifica se excutando no Azure
Azure <- F

if (!Azure){
  setwd("~/Documentos/dsa/BigDataAnalytics")
  source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

  setwd("~/Documentos/dsa/BigDataAnalytics/Cap13-DataMunging")
  getwd()
}

# Carga dos dados de acordo com local em que executando
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
print("Dimensões do datafram antes das operações de transformação:")
print(dim(Bikes))

# Filtrando o dataframe
Bikes <- Bikes %>% filter(cnt > 100)

 print("Dimensões do datafram após as operações de transformação:")
 print(dim(Bikes))
 
 # ggplot2
 require(ggplot2)
 qplot(dteday,
       cnt,
       data = subset(Bikes, hr== 9),
       geom = "line")
 
 if (Azure) maml.mapOutputPort("Bikes")