# https://archive.ics.uci.edu/ml/datasets/Statlog+(German+Credit+Data)
setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap15-Classificacao")
getwd()

# Label 1 = Credito Ruim
# Label 2 = Credito Bom

# Formulas
Accuracy <- function(x){
  (x[1, 1] + x[2, 2]) / (x[1, 1] + x[1, 2] + x[2, 1] + x[2, 2])
}

Recall <- function(x){
  x[1, 1] / (x[1, 1] + x[1, 2])
}

Precision <- function(x){
  x[1, 1] / (x[1, 1] + x[2, 1])
}

W_Accuracy <- function(x){
  (x[1, 1] + x[2, 2]) / (x[1,1] + 5 * x[1, 2] + x[2, 1] + x[2, 2])
}

F1 <- function(x){
  (2 * x[1, 1])/ (2 * x[1, 1] + x[1, 2] + x[2, 1])
}

# Criando a confunsion matrix
confMat <- matrix(
  unlist(
    Map(
      function(x,y){
        sum(ifelse(previsoes[, 1] == x & previsoes[, 2] == y, 1, 0))
        },
      c(2, 1, 2, 1),
      c(2, 2, 1, 1)
    )
  ),
  nrow = 2
)

# Criando um dataframe com as estatisticas dos testes
df_mat <- data.frame(Category = c('Credito Ruim', 'Credito Bom'),
                     Classificado_como_ruim = c(confMat[1,1], confMat[2,1]),
                     Classificado_como_bom = c(confMat[1,2], confMat[2,2]),
                     Accuracy_Recall = c(Accuracy(confMat), Recall(confMat)),
                     Precision_WAcc = c(Precision(confMat), W_Accuracy(confMat))
                     )

print(df_mat)

# Criando uma curva ROC em R
# install.packages('ROCR')
library('ROCR')

# Gerando as classes do modelo
class1 <- predict(modelo, newdata = dados_teste, type = 'prob')
class2 <- dados_teste$CreditStatus

# Gerando a curva ROC
?prediction
?performance

pred <- prediction(class1[, 2], class2)
perf <- performance(pred, 'tpr', 'fpr')

plot(perf, col = rainbow(10))

# Gerando Confusion Matrix com o Cart
library(caret)
?confusionMatrix

confusionMatrix(previsoes$observado, previsoes$previsto)
