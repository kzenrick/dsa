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

# Para este script, vamos usar o mlbench (Machine Learning Benchmark Problems)
# https://cran.r-project.org/web/packages/mlbench/mlbench.pdf
# Este pacote contém diversos datasets e usaremos um com os dados 
# de votação do congresso americano 

# Seu trabalho é prever os votos em republicanos e democratas (variável Class)

# Import
#install.packages("mlbench")
library(mlbench)

# Carregando o dataset
?HouseVotes84
data("HouseVotes84")
View(HouseVotes84)

show_info_dados(HouseVotes84)

# Analise exploratória de dados
plot(as.factor(HouseVotes84[,2]))
title(main = "Votes cast for issue", xlab = "vote", ylab = "# reps")
plot(as.factor(HouseVotes84[HouseVotes84$Class == 'republican', 2]))
title(main = "Republican votes cast for issue 1", xlab = "vote", ylab = "# reps")
plot(as.factor(HouseVotes84[HouseVotes84$Class == 'democrat',2]))
title(main = "Democrat votes cast for issue 1", xlab = "vote", ylab = "# reps")

# Funções usadas para imputation
# Função que retorna o numeros de NA's por voto e classe (democrat or republican)
na_by_col_class <- function (col,cls){return(sum(is.na(HouseVotes84[,col]) & HouseVotes84$Class==cls))}

# Calcula a percentage de 'SIM'
p_y_col_class <- function(col,cls){
  sum_y <- sum(HouseVotes84[,col] == 'y' & HouseVotes84$Class == cls, na.rm = TRUE)
  sum_n <- sum(HouseVotes84[,col] == 'n' & HouseVotes84$Class == cls, na.rm = TRUE)
  return(sum_y/(sum_y+sum_n))}

# Testando a função
p_y_col_class(2,'democrat')
p_y_col_class(2,'republican')
na_by_col_class(2,'democrat')
na_by_col_class(2,'republican')

# Impute missing values
for (i in 2:ncol(HouseVotes84)) {
  if(sum(is.na(HouseVotes84[,i])>0)) {
    c1 <- which(is.na(HouseVotes84[,i]) & HouseVotes84$Class == 'democrat',arr.ind = TRUE)
    c2 <- which(is.na(HouseVotes84[,i]) & HouseVotes84$Class == 'republican',arr.ind = TRUE)
    HouseVotes84[c1,i] <- ifelse(runif(na_by_col_class(i,'democrat'))<p_y_col_class(i,'democrat'),'y','n')
    HouseVotes84[c2,i] <- ifelse(runif(na_by_col_class(i,'republican'))<p_y_col_class(i,'republican'),'y','n')
  }
}

# Gerando dados de treino e dados de teste
HouseVotes84[,"train"] <- ifelse(runif(nrow(HouseVotes84)) < 0.80,1,0)
trainColNum <- grep("train",names(HouseVotes84))

plot(as.factor(HouseVotes84[, trainColNum]))
title(main = "Test vs Train", xlab = "vote", ylab = "# reps")

# Gerando os dados de treino e de teste a partir da coluna de treino
trainHouseVotes84 <- HouseVotes84[HouseVotes84$train == 1, -trainColNum]
testHouseVotes84 <- HouseVotes84[HouseVotes84$train == 0, -trainColNum]

# Invocando o método NaiveBayes
#install.packages("e1071")
library(e1071)
library(gmodels)

# Exercício 1 - Crie o modelo NaiveBayes e faça as previsões

# Treine o modelo
?naiveBayes

votes_class <- naiveBayes(trainHouseVotes84, trainHouseVotes84$Class)
votes_predt <- predict(votes_class, testHouseVotes84[,-1])

testHouseVotes84$votes_predt <- votes_predt
testHouseVotes84[testHouseVotes84$votes_predt != testHouseVotes84$Class,]

CrossTable(votes_predt, 
           testHouseVotes84$Class,
           prop.chisq = F,
           prop.t = F,
           dnn = c('predicted', 'actual'))

table(votes_predt, true = testHouseVotes84$Clas)

# -- ajuste no predict

votes_predt_b <- predict(votes_class, testHouseVotes84[, -1])

CrossTable(votes_predt_b, 
           testHouseVotes84$Class,
           prop.chisq = F,
           prop.t = F,
           dnn = c('predicted', 'actual'))

table(pred=votes_predt_b, true = testHouseVotes84$Class)

# ---------------- DSA
nb_modelo <- naiveBayes(Class ~ ., data = trainHouseVotes84)
nb_predict <- predict(nb_modelo, testHouseVotes84[, -1])

CrossTable(nb_predict, 
           testHouseVotes84$Class,
           prop.chisq = F,
           prop.t = F,
           dnn = c('predicted dsa', 'actual'))

# Confusion Matrix
table(pred=nb_predict, true = testHouseVotes84$Class)

# Média
mean(nb_predict == testHouseVotes84$Class)

# -----------------



# -- MAIS TESTES MEU
votes_class2 <- naiveBayes(trainHouseVotes84, trainHouseVotes84$Class, laplace = 1)
votes_predt2 <- predict(votes_class2, testHouseVotes84[,-1])

testHouseVotes84$votes_predt2 <- votes_predt2
dim(testHouseVotes84[testHouseVotes84$votes_predt2 != testHouseVotes84$Class,])

CrossTable(votes_predt2, 
           testHouseVotes84$Class,
           prop.chisq = F,
           prop.t = F,
           dnn = c('predicted2', 'actual'))

# -- 
# -- 
votes_class3 <- naiveBayes(trainHouseVotes84, trainHouseVotes84$Class, laplace = 0.25)
votes_predt3 <- predict(votes_class2, testHouseVotes84[,-1])

testHouseVotes84$votes_predt3 <- votes_predt3
dim(testHouseVotes84[testHouseVotes84$votes_predt3 != testHouseVotes84$Class,])

CrossTable(votes_predt3, 
           testHouseVotes84$Class,
           prop.chisq = F,
           prop.t = F,
           dnn = c('predicted3', 'actual'))

## - - - - - - - - - - - - Múltiplos Testes DSA
nb_multiple_runs <- function(train_fraction, n){
  # iniciar o vetor de retorno
  fraction_correct <- rep(NA, n)
  
  for(i in 1:n){
    HouseVotes84[, "train"] <- ifelse(runif(nrow(HouseVotes84)) < train_fraction, 1, 0)
    trainColNum <- grep("train", names(HouseVotes84))
    
    # Seleciona modelos treino e teste
    trainHouseVotes84 <- HouseVotes84[HouseVotes84$train == 1, -trainColNum]
    testHouseVotes84 <- HouseVotes84[HouseVotes84$train == 0, -trainColNum]
    
    # Montar o modelo naiveBayes
    nb_model <- naiveBayes(Class ~ ., data = trainHouseVotes84)
    nb_test_predict <- predict(nb_model, testHouseVotes84[, -1])
    
    fraction_correct[i] <- mean(nb_test_predict == testHouseVotes84$Class)
  }
  return(fraction_correct)
}

# Testes para 20 modelos com 80%
fraction_correct_predict <- nb_multiple_runs(0.8, 20)

# Resumo dos resultados
summary(fraction_correct_predict)

# desvio padrão
sd(fraction_correct_predict)

# --------------------------
# Testes para 20 modelos com 75%
fraction_correct_predict2 <- nb_multiple_runs(0.75, 20)

# Resumo dos resultados
summary(fraction_correct_predict2)

# desvio padrão
sd(fraction_correct_predict2)

# --------------------------
# Testes para 20 modelos com 50%
fraction_correct_predict3 <- nb_multiple_runs(0.50, 20)

# Resumo dos resultados
summary(fraction_correct_predict3)

# desvio padrão
sd(fraction_correct_predict3)