# Neste documento é replicada a análise feita no livro Machine Learning with R
# Capitulo 5 - Divide and Conquer - Classification Using Decision trees and rules
#   Example - identifying risky bank loans using C5.0 decision trees


# A diferença para o arquivo, é que a leitura veio tudo em fator, ao contrário do arquivo
# disponibilizado onde tudo já é do tipo inteiro

library(C5.0)

# Verificando a % da disponibilidade do empréstimo
prop.table(table(df$credit.rating))

# Verificando se os dados estão ordenados
head(df$credit.amount, 50)


# fazer uma cópia do dataframe
credit <- df

# Como o modelo requer um factor como saída, converter o resultado para fator
credit$credit.rating <- cut(credit$credit.rating, 2, labels = c('nao', 'sim'))
str(credit$credit.rating)


# Separando os dados de treino e de teste
# Mesmo não estando ordenados, selecionar aleatóriamente os registros
summary(credit$credit.amount)

set.seed(333)
credit_rand <- credit[order(runif(1000)),]

# comparando o valor do novo data.table
summary(credit_rand$credit.amount)


# Usando head para comparar os primeiros valores
head(credit$credit.amount, 4)
head(credit_rand$credit.amount, 4)

# dividir classe de treinamento e teste em 90% e 10% respectivamente
credit_train <- credit_rand[1:900, ]
credit_test <- credit_rand[901:1000,]

# o teste deveria ter 30% de inadimplentes para cada 1
prop.table(table(credit_train$credit.rating))

# o teste deveria ter 30% de inadimplentes para cada 1
prop.table(table(credit_test$credit.rating))

# No original
# o teste deveria ter 30% de inadimplentes para cada 1
prop.table(table(credit_rand$credit.rating))


## Treinamento do modelo
# Como a variável que queremos predizer e a primeira variável, devemos retirar do modelo

library(C50)
credit_model <- C5.0(credit_train[,-1], credit_train$credit.rating)
credit_model

# Verificar as decisões
summary(credit_model)


### Avaliação de desempenho
credit_pred <- predict(credit_model, credit_test)

library(gmodels)
CrossTable(credit_test$credit.rating, 
           credit_pred,
           prop.chisq = F,
           prop.c = F,
           prop.r = F,
           dnn = c('atual','previsão'))


## Melhorando o desempenho
credit_boost10 <- C5.0(credit_train[,-1], credit_train$credit.rating,
                       trials = 10)

# Diminui o tamanho da tree size
credit_boost10
credit_model

# Comparação de desempenho
summary(credit_boost10)   # 0.0% de Erros
summary(credit_model)     # 7.9% de Erros

# predição do novo modelo
credit_boost10_pred <- predict(credit_boost10, credit_test)

CrossTable(credit_test$credit.rating, 
           credit_boost10_pred,
           prop.chisq = F,
           prop.c = F,
           prop.r = F,
           dnn = c('atual','previsão'))


# adicionar matriz de peso
error_cost <- matrix(c(0, 1, 4, 0), nrow = 2)

credit_cost <- C5.0(credit_train[,-1], credit_train$credit.rating,
                    costs = error_cost)

summary(credit_cost) # 24% de erro

credit_cost_pred <- predict(credit_cost, credit_test)

CrossTable(credit_test$credit.rating, 
           credit_cost_pred,
           prop.chisq = FALSE, 
           prop.c = FALSE, 
           prop.r = FALSE,
           dnn = c('atual', 'previsão'))
