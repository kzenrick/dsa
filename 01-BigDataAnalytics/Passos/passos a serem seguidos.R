setwd("~/Documentos/dsa/BigDataAnalytics/Passos")


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Passo 01 - Leitura de arquivos -------------------------------

source('01-leitura.R')

df <- abrir_txt_f('~/Documentos/dsa/BigDataAnalytics/Cap18-MiniProjetosAnaliseCredito/credit_dataset.csv')

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 2.Preparar os dados ----------------------------------------------

# Exploração dos dados
source("02-explorarDados.R")
info_bd(df)

# Conversão de dados
# 02  - Conversão de chr para datas - do pacote 

source("03-conversao.R")
df$tem.telefone <- converte_factor(df$telephone, c('não', 'sim'))
str(df$tem.telefone)

mostre_info_fatores(df$tem.telefone)

# 03 - Subconjuntos

source("04-subconjuntos.R")
# Faz um filtro fixo - apenas exemplo
df1 <- sc_subset(df)
dim(df1)

df1 <- sc_indices(df)
dim(df1)

df1 <- sc_indices_neg(df)
dim(df1)

df1 <- sc_which(df, 
                campo = 'credit.amount', 
                valor = 841,
                c('credit.amount', 'savings', 'credit.rating'))
dim(df1)

df1 <- sc_sem_which(df)
dim(df1)

df1 <- sc_dplyr(df)
dim(df1)

df1 <- sc_dplyr_2(df)
dim(df1)

# ----- Verificar campos faltantes
# Criando um data.table
df_na = data.table(x=c(1,NaN,NA,3), y=c(NA_integer_, 1:3), z=c("a", NA_character_, "b", "c"))
df_na

# Verifica se há faltantes
sum(is.na(df_na))

# omitir campos faltantes
dim(df_na)

# Apenas o campo sem na retorna os valores
dim(na.omit(df_na))

df_na_1 <- df_na
# Aplicar função para criação de novos campos
getAleatorio <- function(x) {
  if (is.na(x)){
    return(sample(1:10, 1))
  } else{
    return(x)
  }
}

df_na_1$x = sapply(df_na_1$x, getAleatorio)
df_na_1

# 3.Transformar os dados ------------------------------
# cbind: para juntar as colunas de 2 datasets
# rbind: para juntar as linhas de 2 datasets
# remover a 3ª coluna: df[-3]

df_na_coluna <- data.table(w=c(3, 2, NaN, NaN))
df_na <- cbind(df_na, df_na_coluna)
df_na

df_na_liha <- data.table(x=c(0), z=c('w'))
df_na <- rbind(df_na, df_na_liha, fill = T)
df_na

# visualmente verificar dados perdidos
library(Amelia) #missmap
missmap(df_na,
        main = "Meus Testes", 
        col = c("lightpink", "seagreen"), 
        legend = FALSE)

####################################
# Ajuste de dados - Para informações que estão nulas, imputação de dados
## ---
library(mice)
# ---- Imputação de dados [5]
mice_mod <- mice(df_na[, c("x", "y", "w")], method = 'cart')
mice_complete <- complete(mice_mod)

# ---- Tranferir a predição dos dados perdidos para o dataset principal [6]
df_na$x <- mice_complete$x
df_na$y <- mice_complete$y
df_na$w <- mice_complete$w


# mostrar valores ajustados
df_na

# Normalizar as variaveis preditoras numericas
cols <- c('x', 'y', 'w')
df_na_2 <- as.data.frame(df_na)
df_na_2[, cols] <- scale(df_na_2[,cols])
df_na_2


# mostrar os dados perdidos
perdidos <- which(is.na(df_na_2$z), T) 
df_na_2[perdidos, ]




###########
# Função para imputação

##########
# Desblanceamento de classes - CLASSIFICAÇÃO
# Qdo houver oversampling, criar instâncias para equiparação
# Aplicando ROSE (Random OverSampling Example) 

# Com ROSE conseguimos balancear as clases usando a técnica de Oversampling, conforme explicamos no manual em pdf.
# O help oferece informações adicionais preciosas.
rose_treino <- ROSE(Class ~ ., data = dados_treino, seed = 1)$data
prop.table(table(rose_treino$Class))

# Conseguimos uma proporção quase 50/50 para as duas classes. Não pecisa ser exatamente assim, mas ficou muito bom!

# Aplicando ROSE em dados de teste e checando a proporção de classes
rose_teste <- ROSE(Class ~ ., data = dados_teste, seed = 1)$data
prop.table(table(rose_teste$Class))

# Agora criamos o modelo usando dados de treino balanceados
modelo_v2 <- C5.0(Class ~ ., data = rose_treino)


# importância das variáveis ------------------------
# Modelo randomForest para criar um plot de importância das variáveis
library(randomForest)

modelo <- randomForest(CreditStatus ~ .
                       - Duration
                       - Age
                       - CreditAmount
                       - ForeignWorker
                       - NumberDependents
                       - Telephone
                       - ExistingCreditsAtBank
                       - PresentResidenceTime
                       - Job
                       - Housing
                       - SexAndStatus
                       - InstallmentRatePecnt
                       - OtherDetorsGuarantors
                       - Age_f
                       - OtherInstalments,
                       data = Credit,
                       ntree = 100,
                       nodesize = 10,
                       importance = T)

# Gerar modelos de treino e teste-------------------------------
# Valores aleatórios
set.seed(7)
linhas <- sample(1:nrow(dados), 0.7 * nrow(dados))

dados_treino <- dados[linhas,]
dados_teste <- dados[-linhas,]

####### # Para algoritmos de classificação, ideal usar 50% para cada um dos tipos 
splitData <- function(dataframe, seed = NULL) {
  if (!is.null(seed)) set.seed(seed)
  index <- 1:nrow(dataframe)
  
  
  trainindex <- sample(index, trunc(length(index)/2))
  trainset <- dataframe[trainindex, ]
  testset <- dataframe[-trainindex, ]
  
  list(trainset = trainset,
       testset = testset)
  
} 


library(caTools)
amostras <- sample.split(df$age, SplitRatio = 0.70)


#9. Fazer o modelo preditivo

# --------- Avaliando modelo
# Gerando Confusion Matrix com o Cart
library(caret)

previsoes <- data.frame(observado <- dados_teste$CreditStatus,
                        previsto <- predict(modelo, newdata = dados_teste))

confusionMatrix(previsoes$observado, previsoes$previsto)

#  Criando uma curva ROC em R
library('ROCR')

# Gerando as classes do modelo
class1 <- predict(modelo, newdata = dados_teste, type = 'prob')
class2 <- dados_teste$CreditStatus

# Gerando a curva ROC

pred <- prediction(class1[, 2], class2)
perf <- performance(pred, 'tpr', 'fpr')

plot(perf, col = rainbow(10))