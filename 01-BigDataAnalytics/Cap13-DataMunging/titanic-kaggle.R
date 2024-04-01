# Solução encontrada em: https://www.kaggle.com/patrycjawalicka/r-titanic-k-nearest-neighbors-knn/notebook
setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap13-DataMunging")
getwd()

# ---- Pacote utilizados [1]
library(tidyverse)
library(class) #knn
library(caret) #confusionMatrix
#install.packages("fastDummies")
library(fastDummies) #dummy_cols
library(Amelia) #missmap
#install.packages("mice")
library(mice) #mice
#install.packages("GGally") #ggpairs
library(GGally) #ggpairs
library(cluster) #kmeans, silhouette
library(gmodels) # avaliar o resultado
# ---- Carga inicial [2]
treino <- read.csv('datasets/titanic-train.csv')
head(treino, 2)

teste <- read.csv('datasets/titanic-test.csv')
tail(teste, 2)


# ---- Juntar treino com teste em um novo datasete [3]
treino2 <- treino[-2]
data <- rbind(treino2, teste)
head(data, 2)
dim(treino)
dim(teste)
dim(data)

# ---- Visualizar dados perdidos [4]
missmap(data)
perdidos <- which(is.na(data$Age), T) 

# ---- Imputação de dados [5]
mice_mod <- mice(data[, c("Age", "Fare")], method = 'cart')
mice_complete <- complete(mice_mod)

# ---- Tranferir a predição dos dados perdidos para o dataset principal [6]
data$Age <- mice_complete$Age
data$Fare <- mice_complete$Fare

# mostrar valores ajustados
data[perdidos, "Age"]

# ---- Selecionar as colunas que serão utilizadas [7]
head(data, 2)
data2 <- data[, c(1,2,4,5,6,7,9,11)]
head(data2, 2)

# - - - - - - - - - - - 
# DATA SET PREPARATION
# - - - - - - - - - - - 
# ---- Fatores e Conjuntos Numericos [8]
Survived <- treino$Survived
Id <- data2$PassengerId

# Fatores
data_factor <- select_if(data2, is.factor)
data_numeric <- select_if(data2, is.numeric)

# Retirar PassengerId
data_numeric <- data_numeric[-1]

# Escala de característica porque o cálculo de distância feito em KNN usa valores de característica -> Distância Euclidiana
data_numeric_scale <- data.frame(scale(data_numeric))

# Criando variáveis fictícias
data_factor_dummy <- dummy_cols(data_factor, remove_first_dummy = T)

# Mantem apenas os numéricos
data_factor_dummy <- select_if(data_factor_dummy, is.numeric)

# ---- Reagrupar as variáveis [9]
data3 <- cbind(Id, data_numeric_scale, data_factor_dummy)
colnames(data3)

# Criar dataset de treino
treino_s <- data3[1:891, ]
treino_set <- cbind(treino_s, Survived)
treino_set <- treino_set[-1]

# Criar o dataset de teste
teste_set <- data3[892:1309, ]
teste_set <- teste_set[-1]

# Transformar treino em um fator
str(treino_set$Survived)
treino_set$Survived <- factor(treino_set$Survived, levels = c(0,1))

# - - - - - - - - - - - - 
# KNN K-NEAREST NEIGHBORS
# - - - - - - - - - - - - 
# ---- Verificar dimensões [10]
nrow(treino_set)

# ---- Verificar a melhor condição para o 'K' [11]
sqrt(891)

# será um valor entre 29 e 30

# ---- Verificar conjunto de treino [12]
head(treino_set, 2)

# ---- Encontrar o melhor 'k' [13]
i=1
k.optm=1
for (i in 1:30){
  knn.mod <- knn(train=treino_set[,-10], test=treino_set[,-10], cl=treino_set[,10], k=i)
  k.optm[i] <- 100 * sum(treino_set[,10] == knn.mod)/NROW(treino_set[,10])
  k=i
  cat(k,'=',k.optm[i],'\n')
}
min(k.optm)

# ---- teste de acuracia [14]
plot(k.optm, type="b", xlab="K- Value",ylab="Accuracy level")

# ---- Visualizar dados de teste [15]
head(teste_set, 5)

# ---- realizar os testes apenas com as colunas (PgClass, Age, Fare, Sex_male) [16]
treino_cnj <- treino_set[, c(1,2,5,6,10)]
teste_cnj <- teste_set[, c(1,2,5,6)]

# ---- Criar o modelo 
for (kk in c(25, 29, 30, 31)){
  model_survived <- knn(train = treino_cnj[1:800, -5],  # treino_cnj[, -5],   
                        test = treino_cnj[801:891, -5],  #teste_cnj,
                        cl = treino_cnj[1:800, 5],
                        k = kk)

# ---- avaliar o resultado
  CrossTable(x = Survived[801:891], y =model_survived, prop.chisq=F )
}

## K = 25
# 53.8 + 29.7 = 83.5

## K = 29
# 53.8 + 28.6 = 82.4

## K = 30
# 53.8 + 28.6 = 82.4

## K = 31
# 53.8 + 28.6 = 82.4


# ---- Criar o modelo com 80%
for (kk in c(25, 29, 30, 31)){
  model_survived <- knn(train = treino_cnj[1:640, -5],  # treino_cnj[, -5],   
                        test = treino_cnj[641:891, -5],  #teste_cnj,
                        cl = treino_cnj[1:640, 5],
                        k = kk)
  
  # ---- avaliar o resultado
  CrossTable(x = Survived[641:891], y =model_survived, prop.chisq=F )
}

## K = 25
# 56.2 + 23.5 = 79.7

## K = 29
# 57.4 + 25.5 = 82.9

## K = 30
# 57.0 + 25.1 = 82.1

## K = 31
# 56.6 + 25.9 = 82.5
