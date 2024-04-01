# https://archive.ics.uci.edu/ml/datasets/Statlog+(German+Credit+Data)
setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap15-Classificacao")
getwd()

# Criar um modelo de classificação baseado em randomForest
library(randomForest)

# Cross Tabulation
?table
table(Credit$CreditStatus)

# Função para gerar dados de treino e dados de teste
splitData <- function(dataframe, seed = NULL) {
  if (!is.null(seed)) set.seed(seed)
  index <- 1:nrow(dataframe)
  
  # Para algoritmos de classificação, ideal usar 50% para cada um dos tipos
  trainindex <- sample(index, trunc(length(index)/2))
  trainset <- dataframe[trainindex, ]
  testset <- dataframe[-trainindex, ]
  
  list(trainset = trainset,
       testset = testset)
  
} 

# Gerando dados de treino e de teste
splits <- splitData(Credit, seed = 808)

# verificando dimensões dos data frames
dim(as.data.frame(splits[1]))
dim(splits$testset)

# Separando os dados
dados_treino <- splits$trainset
dados_teste <- splits$testset

# Verificando o número de linha
nrow(dados_treino)
nrow(dados_teste)

# Construindo o modelo
modelo <- randomForest(CreditStatus ~ CheckingAcctStat
                                       + Duration_f
                                       + Purpose
                                       + CreditHistory
                                       + SavingsBonds
                                       + CreditAmount_f,
                                       data = dados_treino,
                                       ntree = 100,
                                       nodesize = 10)
                                       
# Imprimindo o modelo
print(modelo)
