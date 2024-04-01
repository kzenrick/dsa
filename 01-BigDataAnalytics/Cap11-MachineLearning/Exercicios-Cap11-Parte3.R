# Lista de Exercícios Parte 3 - Capítulo 11

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap11-MachineLearning")
getwd()


# Definindo o Problema: Analisando dados das casas de Boston, nos EUA e fazendo previsoes.

# The Boston Housing Dataset
# http://www.cs.toronto.edu/~delve/data/boston/bostonDetail.html

# Seu modelo deve prever a MEDV (Valor da Mediana de ocupação das casas). Utilize um modelo de rede neural!

# Carregando o pacote MASS
library(MASS)

# 01    - Importando os dados do dataset Boston ------------------
set.seed(101)
dados <- Boston
head(dados)


# 02    - Explorando os dados ---------------------------------
str(dados)
summary(dados)
any(is.na(dados))

# ------------------- Descrição dos atributos
# 
# CRIM    - per capita crime rate by town
# ZN      - proportion of residential land zoned for lots over 25,000 sq.ft.
# INDUS   - proportion of non-retail business acres per town.
# CHAS    - Charles River dummy variable (1 if tract bounds river; 0 otherwise)
# NOX     - nitric oxides concentration (parts per 10 million)
# RM      - average number of rooms per dwelling
# AGE     - proportion of owner-occupied units built prior to 1940
# DIS     - weighted distances to five Boston employment centres
# RAD     - index of accessibility to radial highways
# TAX     - full-value property-tax rate per $10,000
# PTRATIO - pupil-teacher ratio by town
# B       - 1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town
# LSTAT   - % lower status of the population
# MEDV    - Median value of owner-occupied homes in $1000's

# Carregando o pacote para Redes Neurais
# install.packages("neuralnet")


# 02.1  - Mostrar Apenas Variáveis Numéricas -----------------------------
show_dados_numericos(dados)


# 02.2  - Mostrar Apenas Variáveis Categóricas------------------------------
show_dados_categoricos(dados)

# 02.3  - Preparação para implantação ----------------------------

# --- Normalizar
df <- as.data.frame(lapply(dados, normalize))

# Verificar os dados do novo data-frame
show_dados_numericos(df)

# Comparando os dados de MEDV
estatisticas(dados$medv, 'medv')
estatisticas(df$medv, 'medv_2')

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Qualquer transformação aplicada aos dados antes de treinar o modelo terá que ser aplicada ao contrário mais tarde, 
# a fim de converter de volta para as unidades de medida originais. Para facilitar o reescalonamento, é aconselhável 
# salvar os dados originais, ou pelo menos as estatísticas de resumo dos dados originais.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# 02.4  - Dividimos os dados em conjuntos de treinamento e testes ----
# Informo 70% para treinamento
intrain <- createDataPartition(df$medv, # Vetor de saída
                               p = 0.7, # Percentagem dos dados que serão treinados
                               list = F # Se Retorno deve ser uma lista
)

# Reproduzir o mesmo resultado
set.seed(2017)
training <- df[intrain,]
testing <- df[-intrain,]

# Confirma se a divisão está correta
dim(training); dim(testing)



# 03    - Treinando o modelo -------------
library (caret)

# 03.1  - Utilizando apenas um nó oculto  ----------
library(neuralnet)

# Criando o modelo com um nó
boston_model <- neuralnet(medv ~ .,
                          data = training)

# visualizar a topologia
plot(boston_model)



# 04    - Avaliando o desempenho  ----------------
# Gerar previsões no conjunto de dados - retira o último campo que é o que queremos prever
model_results <- compute(boston_model, testing[1:13])

# A função retorna 2 campos, uma lista com os neurônios de cada camada e outro que armazena os valores previstos
# Pegamos o último
predict_medv <- model_results$net.result

# correlação entre os valores
cor(predict_medv, testing$medv)


# 05    -  Melhora de desempenho  ------------------
boston_model2 <- neuralnet(medv ~ .,
                           data = training,
                           hidden = c(12, 5, 7, 3)
                           )

# visualizar a topologia
# plot(boston_model2)

# avaliando o desempenho - retira o último campo
model_results2 <- compute(boston_model2, testing[1:13])

# retornar o valores previstos
predict_medv2 <- model_results2$net.result

# correlação entre os valores
cor(predict_medv2, testing$medv)


# 06    - Aplicar retirada dos outliers e aplicar o teste com 7 nós ocultos ----------------
df_ol <- df

for (n in names(df_ol)) {
  if (is.integer(df_ol[[n]]) || is.numeric(df_ol[[n]])) {  
    df_ol <- remover_ol(df_ol, df_ol[[n]])
  }
}

dim(df); dim(df_ol)

# Criar novos registros de treino e teste
intrain_ol <- createDataPartition(df_ol$medv, # Vetor de saída
                               p = 0.7, # Percentagem dos dados que serão treinados
                               list = F # Se Retorno deve ser uma lista
)

# Reproduzir o mesmo resultado
set.seed(2017)
training_ol <- df_ol[intrain_ol,]
testing_ol <- df_ol[-intrain_ol,]

# Confirma se a divisão está correta
dim(training_ol); dim(testing_ol)

# Criar o modelo
boston_model_ol <- neuralnet(medv ~ .,
                             data = training_ol,
                             hidden = 4
                             )

# visualizar a topologia
#plot(boston_model_ol)

# avaliando o desempenho - retira o último campo
model_results_ol <- compute(boston_model_ol, testing_ol[1:13])

# retornar o valores previstos
predict_medv_ol <- model_results_ol$net.result

# correlação entre os valores
cor(predict_medv_ol, testing_ol$medv)



# 07    - Solução DSA --------------------------------------
# 07.1  - Como primeiro passo, vamos abordar o pré-processamento de dados.  ----
#         É uma boa prática normalizar seus dados antes de treinar uma rede neural.
#         Dependendo do seu conjunto de dados, evitando a normalização pode levar a
#         resultados inúteis ou a um processo de treinamento muito difícil.
#         (na maioria das vezes o algoritmo não irá convergir antes do número de iterações
#         máximo permitido). Você pode escolher diferentes métodos para dimensionar os
#         dados (normalização-z, escala min-max, etc...).
#         Normalmente escala nos intervalos [0,1] ou [1,1] tende a dar melhores resultados.

# Normalização
dados_normalizados <- normalizeDSA(dados)

head(dados_normalizados)

# 07.2  - Criando dados de treino e de teste -------------
library(caTools)
split = sample.split(dados_normalizados$medv, SplitRatio = 0.7)

treino <- subset(dados_normalizados, split == T)
teste <- subset(dados_normalizados, split == F)

# 07.3  - Criando a fórmula - para não colocar o . ---------
# obtendo o nome das colunas
colunas_nomes <- names(treino)
colunas_nomes

# agregando par formar a fórmula
formula <- as.formula(
  paste(
    "medv ~", paste(
      colunas_nomes[!colunas_nomes %in% "medv"],
      collapse = " + "
      )
    )
  )

formula

# 07.4  - Treinar o modelo ----------
rede_neural <- neuralnet(formula,
                         data = treino,
                         hidden = c(5,3),
                         linear.output = T
                         )

plot(rede_neural)

# 07.5  - Fazendo previsões com os dados de testes  --------------
rede_neural_prev <- compute(rede_neural, teste[1:13])
rede_neural_prev

# O retorno da previsão é uma lista
str(rede_neural_prev)

# retorar os valores previstos
rede_neural_predict <- rede_neural_prev$net.result

# Correlação entre os valores
cor(rede_neural_predict, teste$medv)

# 07.6  - Convertendo os dados de teste para o formato original -----------
previsoes <- rede_neural_prev$net.result * 
  (max(dados$medv) - min(dados$medv)) +
  min(dados$medv)

teste_convert <- (teste$medv) *
  (max(dados$medv) - min(dados$medv)) +
  min(dados$medv)

teste_convert

# 07.7  - Calculando o Mean Squared Error ------------
MSE.nn <- sum((teste_convert - previsoes) ^ 2 ) / nrow(teste)
MSE.nn

# Obtendo os erros de previsão
error.df <- data.frame(teste_convert, previsoes)
head(error.df)

# plot dos erros
library(ggplot2)
ggplot(error.df,
       aes(x = teste_convert, y = previsoes)) +
  geom_point() + stat_smooth()
