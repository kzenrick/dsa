setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap13-DataMunging")
getwd()

# Verifica se excutando no Azure
Azure <- F

# Carga dos dados de acord com local em que executando
if (Azure){
  restaurantes <- maml.mapInputPort(1)
  ratings <- maml.mapInputPort(2)
}else{
  restaurantes <- read.csv("datasets/Restaurant-features.csv",
                    sep = ",",
                    header = T,
                    stringsAsFactors = F)
  
  ratings <- read.csv("datasets/Restaurant-ratings.csv",
                      sep = ",",
                      header = T,
                      stringsAsFactors = F)
  
}

restaurantes <- restaurantes[restaurantes$franchise == 'f' & restaurantes$alcohol != 'No_Alcohol_served', ]

require(dplyr)

#join juntando dois dataframe dataset
df <- as.data.frame(restaurantes %>% 
                      inner_join(ratings, by = 'placeID') %>% 
                      select(name, rating) %>% 
                      group_by(name) %>% 
                      summarize(ave_Rating = mean(rating)) %>% 
                      arrange(desc(ave_Rating))
                    )

df

if (Azure) maml.mapOutputPort("df")
