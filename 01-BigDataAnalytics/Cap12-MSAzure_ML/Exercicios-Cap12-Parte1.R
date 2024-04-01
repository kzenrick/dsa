# Solução Lista de Exercícios - Capítulo 12

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap12-MSAzure_ML")
getwd()

# Solução baseado em:
# https://subscription.packtpub.com/book/big_data_and_business_inteliigence/9781782162148/6/ch06lvl1sec35/example-estimating-the-quality-of-wines-with-regression-trees-and-model-trees?query=rpart


# Existem diversos pacotes para arvores de recisao em R. Usaremos aqui o rpart.
#install.packages('rpart')
library(rpart)

# Exploração dos dados ----
# Vamos utilizar um dataset que é disponibilizado junto com o pacote rpart
str(kyphosis)
head(kyphosis)

help("kyphosis")

show_info_dados(kyphosis)

# Exercício 1 - Depois de explorar o dataset, crie um modelo de árvore de decisão ----

# Sem utlizar separações
fit1 <- rpart(Kyphosis ~ Age + Number + Start, 
             data = kyphosis)

fit1

summary(fit1)

fit_dsa <- rpart(Kyphosis ~ ., 
                 method = 'class',
                 data = kyphosis)

summary(fit_dsa)

# utilizando a separação pela própria função
fit2 <- rpart(Kyphosis ~ Age + Number + Start, 
              data = kyphosis,
              parms = list(prior = c(0.7, 0.3), 
                           split = "information")
              )

fit2

summary(fit2)

# utlizando dados de treino/teste
library(caret)
split <- createDataPartition(y = kyphosis$Number,
                             p = 0.7,
                             list = F)

# Criando dataset de treino e de teste
df_treino <- kyphosis[split,]
df_teste <- kyphosis[-split,]

fit3 <- rpart(Kyphosis ~ Age + Number + Start, 
              data = df_treino
              )


fit3

summary(fit3)

# predições ----
p.fit3 <- predict(fit3, 
                  df_teste, 
                  type = "class") # "vector" para predizer valores numéricos
                                  # "class" para predizer classes
                                  # "prbl" para predizer classes de probabilidades

p.fit3

plot(df_teste$Kyphosis, p.fit3)

# Verificar relação entre as variáveis

varImp(fit1)
varImp(fit2)
varImp(fit3)

# Para examinar o resultado de uma árvore de decisao, existem diversas funcões, mas você pode usar printcp()
printcp(fit1)
printcp(fit_dsa)

# Mesmo resulta fit1 e fit_dsa

printcp(fit2)
printcp(fit3)

# Visualizando a ávore (execute uma função para o plot e outra para o texto no plot) ----
# Utilize o zoom para visualizar melhor o gráfico
plot(fit1)
text(fit1, use.n = TRUE)

plot(fit2)
text(fit2, use.n = TRUE)

plot(fit3)
text(fit3, use.n = TRUE)

# Este outro pacote faz a visualizaco ficar mais legivel
#install.packages('rpart.plot')
library(rpart.plot)
prp(fit1, digit = 3)

prp(fit1, 
    fallen.leaves = T)

prp(fit1, 
    fallen.leaves = T,
    type = 3)

prp(fit1, 
    fallen.leaves = T,
    type = 3,
    extra = 101)

rpart.plot(fit1)

# Avaliação do desempenho  ----------
p.fit3 <- predict(fit3, df_teste, 
                  type = "class")

summary(p.fit3)

summary(df_teste$Kyphosis)

