# https://archive.ics.uci.edu/ml/datasets/Statlog+(German+Credit+Data)
setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap15-Classificacao")
getwd()

# Modelo randomForest ponderado
# O pacote C50 permite que você dê peso aos erros, construindo assim um resultado ponderado
#install.packages("C50")
library(C50)

# Criando uma Cost Function - Pesos alterados do original para não gerar exceção (0, 1.5, 1, 0)
Cost_func <- matrix(c(0, 3, 2, 0),
                    nrow = 2,
                    dimnames = list(
                      c('1', '2'), 
                      c('1', '2')
                      )
                    )
 # Criando o modelo 
# ?randomForest
# ?C5.0

# Cria o modelo
modelo_v2 <- C5.0(CreditStatus ~ CheckingAcctStat
                  + Purpose
                  + CreditHistory
                  + SavingsBonds
                  + Employment,
                  data = dados_treino,
                  trials = 100,
                  cost = Cost_func,
                  rules = T)

print(modelo_v2)

# Dataframes com valores observados e previstos
previsoes_v2 <- data.frame(observado = dados_teste$CreditStatus,
                           previsto = predict(object = modelo_v2, newdata = dados_teste))
# Criando a confunsion matrix
confMat_v2 <- matrix(
  unlist(
    Map(
      function(x,y){
        sum(ifelse(previsoes_v2[, 1] == x & previsoes_v2[, 2] == y, 1, 0))
      },
      c(2, 1, 2, 1),
      c(2, 2, 1, 1)
    )
  ),
  nrow = 2
)

# Criando um dataframe com as estatisticas dos testes
df_mat_v2 <- data.frame(Category = c('Credito Ruim', 'Credito Bom'),
                     Classificado_como_ruim = c(confMat_v2[1,1], confMat_v2[2,1]),
                     Classificado_como_bom = c(confMat_v2[1,2], confMat_v2[2,2]),
                     Accuracy_Recall = c(Accuracy(confMat_v2), Recall(confMat_v2)),
                     Precision_WAcc = c(Precision(confMat_v2), W_Accuracy(confMat_v2))
)

print(df_mat_v2)

# Gerando Confusion Matrix com o Cart
#library(caret)
#?confusionMatrix

confusionMatrix(previsoes_v2$observado, previsoes_v2$previsto)

# ------------- Não executa devido ao tipo do campo
tryCatch(
  {
    Cost_func_v3 <- matrix(c(0, 3, 2, 0),
                        nrow = 2,
                        dimnames = list(
                          c('1', '2'), 
                          c('1', '2')
                        )
    )
    
    modelo_v3 <- C5.0(CreditStatus ~ CheckingAcctStat
                      + Duration
                      + CreditAmount_f
                      + Purpose
                      + CreditHistory
                      #+ Employment
                      + SavingsBonds,
                      data = dados_treino,
                      trials = 100,
                      cost = Cost_func_v3
                      #rules = T
                      )
    
    # Dataframes com valores observados e previstos
    previsoes_v3 <- data.frame(observado = dados_teste$CreditStatus,
                               previsto = predict(object = modelo_v3, newdata = dados_teste))
    # Criando a confunsion matrix
    confMat_v3 <- matrix(
      unlist(
        Map(
          function(x,y){
            sum(ifelse(previsoes_v3[, 1] == x & previsoes_v3[, 2] == y, 1, 0))
          },
          c(2, 1, 2, 1),
          c(2, 2, 1, 1)
        )
      ),
      nrow = 2
    )
    
    # Criando um dataframe com as estatisticas dos testes
    df_mat_v3 <- data.frame(Category = c('Credito Ruim', 'Credito Bom'),
                            Classificado_como_ruim = c(confMat_v3[1,1], confMat_v3[2,1]),
                            Classificado_como_bom = c(confMat_v3[1,2], confMat_v3[2,2]),
                            Accuracy_Recall = c(Accuracy(confMat_v3), Recall(confMat_v3)),
                            Precision_WAcc = c(Precision(confMat_v3), W_Accuracy(confMat_v3))
    )
    
    print(df_mat_v3)
    
    confusionMatrix(previsoes$observado, previsoes$previsto)
    confusionMatrix(previsoes_v2$observado, previsoes_v2$previsto)
    confusionMatrix(previsoes_v3$observado, previsoes_v3$previsto)
  },
  error = function(e){
    message('erro ao processar modelo v3')
    print(e)
  },
  finally = {
    message('Calculando próximas previsões\n\n')
  }
)

# --------------
Cost_func_v4 <- matrix(c(0, 3, 1, 0),
                    nrow = 2,
                    dimnames = list(
                      c('1', '2'), 
                      c('1', '2')
                    )
)

# Alterar Duration_f e CreditAmount_f para valores grupo de valores
dados_treino_v4 <- dados_treino
dados_teste_v4 <-  dados_teste

# Ajustar variável DURATION
dados_treino_v4$Duration_f_v4 <- dados_treino_v4$Duration_f
levels(dados_treino_v4$Duration_f_v4) <- c("AT17",
                                           "AT31",
                                           "AT44",
                                           "AT58",
                                           "AC58")

dados_teste_v4$Duration_f_v4 <- dados_teste_v4$Duration_f
levels(dados_teste_v4$Duration_f_v4) <- c("AT17",
                                           "AT31",
                                           "AT44",
                                           "AT58",
                                           "AC58")

# Ajustar variável CREDIT_AMOUT
dados_treino_v4$CreditAmount_f_v4 <- dados_treino_v4$CreditAmount_f
levels(dados_treino_v4$CreditAmount_f_v4) <- c("AT_3.8K",
                                           "AT_7.5K",
                                           "AT_11.2K",
                                           "AT_14.8K",
                                           "AC_14.8K")

dados_teste_v4$CreditAmount_f_v4 <- dados_teste_v4$CreditAmount_f
levels(dados_teste_v4$CreditAmount_f_v4) <- c("AT_3.8K",
                                          "AT_7.5K",
                                          "AT_11.2K",
                                          "AT_14.8K",
                                          "AC_14.8K")

# Criar o modelo
modelo_v4 <- C5.0(CreditStatus ~ CheckingAcctStat
                  + Duration_f_v4
                  + CreditAmount_f_v4
                  + Purpose
                  + CreditHistory
                  + SavingsBonds,
                  data = dados_treino_v4,
                  trials = 100,
                  cost = Cost_func_v4)

# Dataframes com valores observados e previstos
previsoes_v4 <- data.frame(observado = dados_teste_v4$CreditStatus,
                           previsto = predict(object = modelo_v4, newdata = dados_teste_v4))

confusionMatrix(previsoes$observado, previsoes$previsto)
confusionMatrix(previsoes_v2$observado, previsoes_v2$previsto)
#confusionMatrix(previsoes_v3$observado, previsoes_v3$previsto)
confusionMatrix(previsoes_v4$observado, previsoes_v4$previsto)

# -----------
# Criar o modelo
modelo_v5 <- C5.0(CreditStatus ~ CheckingAcctStat
                  + Duration_f_v4
                  + CreditAmount_f_v4
                  + Purpose
                  + CreditHistory
                  + SavingsBonds,
                  data = dados_treino_v4,
                  trials = 100)

# Dataframes com valores observados e previstos
previsoes_v5 <- data.frame(observado = dados_teste_v4$CreditStatus,
                           previsto = predict(object = modelo_v4, newdata = dados_teste_v4))

confusionMatrix(previsoes$observado, previsoes$previsto)
confusionMatrix(previsoes_v2$observado, previsoes_v2$previsto)
#confusionMatrix(previsoes_v3$observado, previsoes_v3$previsto)
confusionMatrix(previsoes_v4$observado, previsoes_v4$previsto)
confusionMatrix(previsoes_v5$observado, previsoes_v5$previsto)

