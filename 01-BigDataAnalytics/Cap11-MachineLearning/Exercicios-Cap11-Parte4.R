# Lista de Exercícios Parte 4 - Capítulo 11

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap11-MachineLearning")
getwd()



# Definindo o Problema: OCR - Optical Character Recognition
# Seu modelo deve prever o caracter a partir do dataset fornecido. Use um modelo SVM

# Combina KNN e Métodos de regressão
# Os SVMs podem ser adaptados para uso com quase qualquer tipo de tarefa de aprendizagem, incluindo classificação e previsão numérica.

## Explorando e preparando os dados
letters <- read.csv("letterdata.csv")
str(letters)

# Criando dados de treino e dados de teste
letters_treino <- letters[1:16000, ]
letters_teste  <- letters[16001:20000, ]

## Treinando o Modelo
#install.packages("kernlab")
library(kernlab)

# Criando o modelo com o kernel vanilladot
letter_classifier <- ksvm(letter ~ .,
                          data = letters_treino,
                          kernetl = "vanilladot")

# Verificando o resultado
letter_classifier

# Fazer predições
letter_prediction <- predict(letter_classifier, 
                             letters_teste)

head(letter_prediction)

# Verificando aproveitamento - Tabela de confução
table(letter_prediction, letters_teste$letter)

# Verificando Acertos
agreement <- letter_prediction == letters_teste$letter

table(agreement)

# Percentuais
prop.table(table(agreement))

# --------------------- 
# Melhorar o desempenho
letter_classifier_rbf <- ksvm(letter ~ .,
                          data = letters_treino,
                          kernetl = "rbfdot")

letter_classifier_rbf

# Fazer predições
letter_prediction_rbf <- predict(letter_classifier_rbf, 
                                 letters_teste)

head(letter_prediction_rbf)

# Verificando aproveitamento
table(letter_prediction_rbf, letters_teste$letter)

agreement_rbf <- letter_prediction_rbf == letters_teste$letter

table(agreement_rbf)

# Percentuais
prop.table(table(agreement_rbf))
prop.table(table(agreement))

