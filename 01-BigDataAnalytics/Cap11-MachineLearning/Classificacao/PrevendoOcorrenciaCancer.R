setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap11-MachineLearning/Classificacao")
getwd()

# Definição do Problema de Negócio: Previsão de ocorrência de cancer de Mama
# http://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+%28Diagnostic%29

#----
#---- Etapa 1 - Coletando os Dados

# Os dados do câncer da mama incluem 569 observações de biópsias de câncer, 
# cada um com 32 características (variáveis). Uma característica é um número de 
# identificação (ID), outro é o diagnóstico de câncer, e 30 são medidas laboratoriais 
# numéricas. O diagnóstico é codificado como "M" para indicar maligno ou "B" para 
# indicar benigno.
library(stringr)

dados <- read.csv("dataset.csv", stringsAsFactors = F)
str(dados)
View(dados)

#---- 
#---- Etapa 2 - Pré Processamento

# Excluindo a coluna ID
# Independentemente do método de aprendizagem de máquina, deve sempre ser excluídas
# variáveis de ID. Caso contrário, isso pod levar a resultados errados porque o ID
# pode ser usado para unicamente "prever" cada exemplo. Por conseguinte, um modelo
# que inclui um identificador pode sofrer de superajuste (overfitting),
# e será muito difícil usá-lo para generalizar outros dados
dados$id = NULL

# Ajustando o label da variável alvo
dados$diagnosis = sapply(dados$diagnosis, function(x){ifelse(x=='M', 'Maligno', 'Benigno')})


# Muitos classificadores reque que as variáveis seja do tipo Fator
table(dados$diagnosis)
dados$diagnosis <- factor(dados$diagnosis, levels = c("Benigno", "Maligno"), labels = c("Benigno", "Maligno"))
str(dados$diagnosis)

# Verificando a proporção
round(prop.table(table(dados$diagnosis)) * 100, digits = 2)

# Medidas de Tendência Central
# Detectamos um problema de escala entre os dados, que então precisam ser normalizados
# O cálculo de distância feito pelo KNN depende das medidas de escala nos dados de entrada.
summary(dados[c("radius_mean", "area_mean", "smoothness_mean")])

# Criando a função de normalização - deve-se colocar todas as variáveis na mesma escala e com uma distribuição normal
# ou seja, com média igual a zero e desvio padrão igual a 1
normalizar <- function(x){
  return ((x - min(x)) / (max(x) - min(x)))
}

# Testando a função de normalização - os resultados devem ser idênticos
normalizar(c(1,2,3,4,5))
normalizar(c(10,20,30,40,50))

# Normalizando os dados 
dados_norm <- as.data.frame(lapply(dados[2:31], normalizar))
View(dados_norm)


#----
# Etapa 3: Treinando o modelo com KNN

# Carregando o pacote library
# install.packages("class")
library(class)
?knn

# Criando dados de treino e dados de teste
dados_treino_1 <- dados_norm[1:469,]
dados_teste_1 <- dados_norm[470:569,]

# Criando os labels para os dados de treino e de teste
dados_treino_label <- dados[1:469, 1]
dados_teste_label <- dados[470:569, 1]

length(dados_treino_label)
length(dados_teste_label)

# Criando o modelo - 21 vizinhos
modelo_knn_v1 <- knn(train = dados_treino_1,
                     test = dados_teste_1,
                     cl = dados_treino_label,
                     k = 21)

# A função knn() retorna um objeto do tipo fator com as previsões para cada exemplo
summary(modelo_knn_v1)


#----
# Etapa 4: Avaliando e interpretando os modelos

# Carregando o gmodels
library(gmodels)

# Criando uma tabela cruzada dos dados previstos x dados atuais
# Usaremos amostra com 100 observações: length(dados_teste_labels)
CrossTable(x = dados_teste_label, 
           y = modelo_knn_v1, 
           prop.chisq = F)

# Interpretando os Resultados
# A tabela cruzada mostra 4 possíveis valores, que representam os falso/verdadeiro positivo e negativo
# Temos duas colunas listando os labels originais nos dados observados
# Temos duas linhas listando os labels dos dados de teste

# Temos:
# Cenário 1: Célula Benigno (Observado) x Benigno (Previsto) - 61 casos - true positive 
# Cenário 2: Célula Maligno (Observado) x Benigno (Previsto) - 00 casos - false positive (o modelo errou)
# Cenário 3: Célula Benigno (Observado) x Maligno (Previsto) - 02 casos - false negative (o modelo errou)
# Cenário 4: Célula Maligno (Observado) x Maligno (Previsto) - 37 casos - true negative 

# Lendo a Confusion Matrix (Perspectiva de ter ou não a doença):

# True Negative  = nosso modelo previu que a pessoa NÃO tinha a doença e os dados mostraram que realmente a pessoa NÃO tinha a doença
# False Positive = nosso modelo previu que a pessoa tinha a doença e os dados mostraram que NÃO, a pessoa tinha a doença
# False Negative = nosso modelo previu que a pessoa NÃO tinha a doença e os dados mostraram que SIM, a pessoa tinha a doença
# True Positive = nosso modelo previu que a pessoa tinha a doença e os dados mostraram que SIM, a pessoa tinha a doença

# Falso Positivo - Erro Tipo I
# Falso Negativo - Erro Tipo II

# Taxa de acerto do Modelo: 98% (acertou 98 em 100)

#-----------
## Etapa 5: Otimizando a Performance do Modelo

# Usando a função scale() para padronizar o z-score 
?scale()

# utilizando a base original dos dados
dados_z <- as.data.frame(scale(dados[-1]))

# Confirmando transformação realizada com sucesso
summary(dados_z$area_mean)
summary(dados_z$radius_mean)
summary(dados_z$smoothness_mean)

# Criando novos datasets de treino e de teste
dados_treino_2 <- dados_z[1:469,]
dados_teste_2 <- dados_z[470:569,]

dados_treino_label <- dados[1:469,1]
dados_teste_label <- dados[470:569,1]

# Reclassificando
modelo_knn_v2 <- knn(train = dados_treino_2,
                     test = dados_teste_2,
                     cl = dados_treino_label,
                     k = 21)

# Criando a tabela cruzada dos dados previstos x dados atuais
CrossTable(x = dados_teste_label,
           y = modelo_knn_v2,
           prop.chisq = F)

# ----------
# Experimente diferentes valores para k
 for (i in seq(17,27, 2)){
   writeLines(str_c('--------------------------------\n', 
         '-------------- ', i, ' --------------\n' ,
         '\n---------------',
         ' I ',
         '---------------\n'))
   modelo_knn <- knn(train = dados_treino_1,
                     test = dados_teste_1,
                     cl = dados_treino_label,
                     k = i)
   
   CrossTable(x = dados_teste_label,
              y = modelo_knn,
              prop.chisq = F)
   
   
   writeLines(str_c('\n---------------',
                    ' II ',
                    '--------------\n'))
   
   modelo_knn <- knn(train = dados_treino_2,
                     test = dados_teste_2,
                     cl = dados_treino_label,
                     k = i)
   
   CrossTable(x = dados_teste_label,
              y = modelo_knn,
              prop.chisq = F)
 }


# --------
# Etapa 6: Construindo modelo com Algoritmo Support Vector Machine (SVM)

# Definindo a semente para resultados reproduzíveis
set.seed(40)

# Prepara o dataset
dados <- read.csv("dataset.csv", stringsAsFactors = F)
dados$id = NULL

# Cria uma coluna como índice - Usado para separar os dados em treino e teste
dados[,'index'] <- ifelse(runif(nrow(dados)) < 0.8, 1, 0)
View(dados)

# Dados de treino e teste
trainset <- dados[dados$index==1,]
testset <- dados[dados$index==0,]

# Obter o índice
trainColNum <- grep('index', names(trainset))

# remover o índice dos datasets
trainset <- trainset[, -trainColNum]
testset <- testset[, -trainColNum]

# Obter índice de coluna da variável target no conjunto de dados
typeColumn <- grep('diag', names(dados))

# Cria o Modelo
# Nós ajustamos o kernel para radial, há que este conjunto de dados não tem
# um plano linear que pode ser desenhado
library(e1071)
modelo_svm_v1 <- svm(diagnosis ~.,
                     data = trainset,
                     type = 'C-classification',
                     kernel = 'radial')

# Previsões
# - Previsões dos dados de treinos
pred_train <- predict(modelo_svm_v1, trainset)

# Percentual de previsões corretas com dataset de treino
mean(pred_train == trainset$diagnosis)

# Previsões nos dataset de teste
pred_test <- predict(modelo_svm_v1, testset)

# Percentual de previsões corretas com dataset de teste
mean(pred_test == testset$diagnosis)

# Confusion Matrix
table(pred_test, testset$diagnosis)

# ---------
# Etapa 7 : Construindo modelo com Random Forest

# Criando o modelo
library(rpart)
modelo_rf_v1 = rpart(diagnosis ~ .,
                     data = trainset,
                     control = rpart.control(cp = .0005))

# Previsões nos dados de teste
tree_pred <- predict(modelo_rf_v1,
                     trainset,
                     type = 'class')

# Percentual de previsões corretas com dataset de teste
mean(tree_pred == trainset$diagnosis)

# Confunsion Matrix
table(tree_pred, trainset$diagnosis)

# Previsões nos dados de teste
tree_pred <- predict(modelo_rf_v1,
                     testset,
                     type = 'class')

# Percentual de previsões corretas com dataset de teste
mean(tree_pred == testset$diagnosis)

# Confunsion Matrix
table(tree_pred, testset$diagnosis)
