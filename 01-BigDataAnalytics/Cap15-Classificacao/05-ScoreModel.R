# https://archive.ics.uci.edu/ml/datasets/Statlog+(German+Credit+Data)
setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap15-Classificacao")
getwd()

# Previsões com um modelo de classficiação baseado em randomFores
require(randomForest)

# Gerando previsões nos dados de teste
previsoes <- data.frame(observado <- dados_teste$CreditStatus,
                        previsto <- predict(modelo, newdata = dados_teste))

# Visualizando o resultado
View(previsoes)
View(dados_teste)
