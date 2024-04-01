# Solução Lista de Exercícios - Capítulo 13

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap13-DataMunging")
getwd()


# Para este exemplo, usaremos o dataset Titanic do Kaggle. 
# Este dataset é famoso e usamos parte dele nas aulas de SQL.
# Ele normalmente é usado por aqueles que estão começando em Machine Learning.

# Vamos prever uma classificação - sobreviventes e não sobreviventes

# https://www.kaggle.com/c/titanic/data


# Comecamos carregando o dataset de dados_treino
dados_treino <- read.csv('datasets/titanic-train.csv')
View(dados_treino)

# Analise exploratória de dados
# Vamos usar o pacote Amelia e suas funções para definir o volume de dados Missing
# Clique no zoom para visualizar o grafico
# Cerca de 20% dos dados sobre idade estão Missing (faltando)
#install.packages("Amelia")
library(Amelia)

?missmap
missmap(dados_treino, 
        main = "Titanic Training Data - Mapa de Dados Missing", 
        col = c("yellow", "black"), 
        legend = FALSE)

# Visualizando os dados
library(ggplot2)
ggplot(dados_treino,aes(Survived)) + geom_bar()
ggplot(dados_treino,aes(Pclass)) + geom_bar(aes(fill = factor(Pclass)), alpha = 0.5)
ggplot(dados_treino,aes(Sex)) + geom_bar(aes(fill = factor(Sex)), alpha = 0.5)
ggplot(dados_treino,aes(Age)) + geom_histogram(fill = 'blue', bins = 20, alpha = 0.5)
ggplot(dados_treino,aes(SibSp)) + geom_bar(fill = 'red', alpha = 0.5)
ggplot(dados_treino,aes(Fare)) + geom_histogram(fill = 'green', color = 'black', alpha = 0.5)

# Limpando os dados
# Para tratar os dados missing, usaremos o recurso de imputation.
# Essa técnica visa substituir os valores missing por outros valores,
# que podem ser a média da variável ou qualquer outro valor escolhido pelo Cientista de Dados

# Por exemplo, vamos verificar as idades por classe de passageiro (baixa, média, alta):
pl <- ggplot(dados_treino, aes(Pclass,Age)) + geom_boxplot(aes(group = Pclass, fill = factor(Pclass), alpha = 0.4)) 
pl + scale_y_continuous(breaks = seq(min(0), max(80), by = 2))

# Vimos que os passageiros mais ricos, nas classes mais altas, tendem a ser mais velhos. 
# Usaremos esta média para imputar as idades Missing
impute_age <- function(age, class){
  out <- age
  for (i in 1:length(age)){
    
    if (is.na(age[i])){
      
      if (class[i] == 1){
        out[i] <- 37
        
      }else if (class[i] == 2){
        out[i] <- 29
        
      }else{
        out[i] <- 24
      }
    }else{
      out[i]<-age[i]
    }
  }
  return(out)
}

fixed.ages <- impute_age(dados_treino$Age, dados_treino$Pclass)
dados_treino$Age <- fixed.ages

# Visualizando o mapa de valores missing (nao existem mais dados missing)
missmap(dados_treino, 
        main = "Titanic Training Data - Mapa de Dados Missing", 
        col = c("yellow", "black"), 
        legend = T)


# Exercício 1 - Crie o modelo de classificação e faça as previsões
# retirar colunas PassengerId, Name, Ticket e Cabin

str(dados_treino)

remover = c("PassengerId", "Cabin", "Name", "Ticket")
dados <- dados_treino[, !(names(dados_treino) %in% remover)]

colnames(dados)

# KNN ----------
# transformar o dado destino em um fatator
dados_knn <- dados

show_info_dados(dados_knn)
show_correlacao(dados_knn)

# transformar a variável em fator
dados_knn$Survived <- as.factor(dados_knn$Survived)
dados_knn$Survived <- factor(dados_knn$Survived, levels = c('0', '1'), labels = c('n', 's'))

prop.table(table(dados_knn$Survived)) * 100

# transforma a variável SEX em número
sex_as_num <- as.numeric(dados_knn$Sex)
dados_knn$Sex <- sex_as_num

str(dados_knn)

# Transforma Embarked em número
# Preenche os valors vazios com 'S'
emb <- which(dados_knn$Embarked == "")
dados_knn[emb, "Embarked"] <- 'S'

dados_knn$Embarked <- droplevels(dados_knn$Embarked)
dados_knn$Embarked <- as.numeric(dados_knn$Embarked)

#-------- Gerar treino e teste a partir de dados_knn
dados_knn[,"train"] <- ifelse(runif(nrow(dados_knn)) < 0.80, 1, 0)
trainColNum <- grep("train",names(dados_knn))
  
# Gerando os dados de treino e de teste a partir da coluna de treino
train_knn <- dados_knn[dados_knn$train == 1, -trainColNum]
test_knn <- dados_knn[dados_knn$train == 0, -trainColNum]
  
train_lables <- train_knn$Survived
test_lables <- test_knn$Survived

library(class)
library(gmodels)

# K = 3
pred_knn <- knn(train = train_knn[, c(2,3,4,5,6,7,8)],
                test = test_knn[, c(2,3,4,5,6,7,8)],
                cl = train_lables,
                k = 3
                )


CrossTable(x = test_knn[, 1], y =pred_knn, prop.chisq=F )

## 54.1 + 20.0 = 74.1

# K = 27

pred_knn_27 <- knn(train = train_knn[, c(2,3,4,5,6,7,8)],
                   test = test_knn[, c(2,3,4,5,6,7,8)],
                   cl = train_lables,
                   k = 27
)


CrossTable(x = test_knn[, 1], y =pred_knn_27, prop.chisq=F )

## 55.6 + 18.5 = 74.1

# Mudar o k para próximo a raiz de dim(train)
nrow(train_knn)

# Retirar as colunas Survived, Parch e Embarched
train_knn2 = train_knn[, c("Pclass", "Sex", "Age", "Fare")]
teste_knn2 = test_knn[, c("Pclass", "Sex", "Age", "Fare")]

train_knn2 <- as.data.frame(scale(train_knn2))
test_knn2 <- as.data.frame(scale(teste_knn2))

pred_knn2 <- knn(train = train_knn2,
                test = test_knn2,
                cl = train_lables,
                k = 27
)

CrossTable(x = test_knn[, 1], y =pred_knn2, prop.chisq=F )

## 58.5 + 25.9 = 84.4

# K = 28

pred_knn2_28 <- knn(train = train_knn2,
                 test = test_knn2,
                 cl = train_lables,
                 k = 28
)

CrossTable(x = test_knn[, 1], y =pred_knn2_28, prop.chisq=F )

## 58.5 + 24.4 = 82.9

# naive Bayes ----------
library(e1071)

naive_survaive <- naiveBayes(train_knn, train_lables, laplace = 1)
pred_naive <- predict(naive_survaive, test_knn)

CrossTable(pred_naive, 
           test_lables,
           prop.chisq = F,
           prop.t = F,
           dnn = c('predicted', 'actual'))

## 99,02


naive_survaive2 <- naiveBayes(train_knn, train_lables, laplace = 0.25)
pred_naive2 <- predict(naive_survaive2, test_knn)

CrossTable(pred_naive2, 
           test_lables,
           prop.chisq = F,
           prop.t = F,
           dnn = c('predicted2', 'actual'))

## 99,02
train_nave3 <- cbind(train_lables, train_knn2)

naive_survaive3 <- naiveBayes(train_nave3, train_lables, laplace = 1)
pred_naive3 <- predict(naive_survaive3, test_knn2)

CrossTable(pred_naive3, 
           test_lables,
           prop.chisq = F,
           prop.t = F,
           dnn = c('predicted3', 'actual'))

## 80

naive_survaive4 <- naiveBayes(train_nave3, train_lables, laplace = 0.25)
pred_naive4 <- predict(naive_survaive4, test_knn2)

CrossTable(pred_naive4, 
           test_lables,
           prop.chisq = F,
           prop.t = F,
           dnn = c('predicted4', 'actual'))

## 80

# ------------------------- DSA
# Regressão Logística

library(dplyr)
dados <- select(dados_treino, -PassengerId, -Name, -Ticket, -Cabin)

log.model <- glm(formula = Survived ~ ., 
                 family = binomial(link = "logit"),
                 data = dados
                 )

# Verificar as variáveis mais significativas
summary(log.model)

# Fazer as previsões dos testes
library(caTools)
set.seed(101)

# split dos dados
split <- sample.split(dados$Survived, SplitRatio = 0.7)

# Montar Datasets de treino e de teste
dados_treino_final <- subset(dados, split == T)
dados_teste_final <- subset(dados, split == F)

# Gerando o modelo com a versõ final do dataset
final.log.model <- glm(formula = Survived ~ .,
                       family = binomial(link = 'logit'),
                       data = dados_treino_final
                       )

# Resumo
summary(final.log.model)

# Prevendo a acurácia
fitted.probabilities <- predict(final.log.model,
                                newdata = dados_teste_final,
                                type = 'response')

# Calculando os valores
fitted.results <- ifelse(fitted.probabilities > 0.5, 1, 0)

misClasificerror <- mean(fitted.results != dados_teste_final$Survived)
print(paste('Acuracia', 1 - misClasificerror))
