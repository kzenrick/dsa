setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap12-MSAzure_ML")
getwd()

# carregar os pacotes
# http://topepo.github.io/caret/index.html

library(caret)
library(randomForest)

library(datasets)

# Usar o dataset mtcars
View(mtcars)

# - - - - - - - - - - - 
# Aplicando o Caret ---------

# Função do Caret para divisão dos dados
# ?createDataPartition
split <- createDataPartition(y = mtcars$mpg,
                             p = 0.7,
                             list = F)

# Criando dataset de treino e de teste
dados_treino <- mtcars[split,]
dados_teste <- mtcars[-split,]

# Treinando o modelo
# ?train
names(getModelInfo())

# mostrando a importancia das variaveis para a criação do modelo
# ?varImp
modelol_v1 <- train(mpg ~ .,
                    data = dados_treino,
                    method = "lm")

varImp(modelol_v1)

# regressão linear
modelol_v1 <- train(mpg ~ wt + hp + qsec + drat,   #  .78.29
# modelol_v1 <- train(mpg ~ gear + am + wt + disp, #  .72.55
                    data = dados_treino,
                    method = "lm")

varImp(modelol_v1)

# Random Forest
modelol_v2 <- train(mpg ~ wt + hp + qsec + drat,
                    data = dados_treino,
                    method = "rf")

varImp(modelol_v2)

# resumo do modelo
summary(modelol_v1)
summary(modelol_v2)

# - - - - - - - - - - - 
# Ajustando o modelo ------------------------

#? expand.grid
#? trainControl

controle1 <- trainControl(method = "cv",
                          number = 10)

modelo1_v3 <- train(mpg ~ wt + hp + qsec + drat,
                    data = dados_treino,
                    method = "lm",
                    trControl = controle1,
                    metric = "Rsquared")

# resumo do modelo
summary(modelo1_v3)     # 78.29

# Coletando os resíduos
residuals <- resid(modelo1_v3)
residuals

# Previsões
?predict
predictedVales <- predict(modelol_v1, dados_teste)
predictedVales
plot(dados_teste$mpg, predictedVales)

# plot das variáveis mais relevantes no modelo
plot(varImp(modelol_v1))
