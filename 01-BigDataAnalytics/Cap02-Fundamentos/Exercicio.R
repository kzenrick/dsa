setwd("~/Documentos/dsa/BigDataAnalytics/Cap02-Fundamentos")
getwd()

# Exercício 1 - Crie um vetor com 30 números inteiros
vetor = seq(1:30)
vetor

# Exercício 2 - Crie uma matriz com 4 linhas e 4 colunas 
# preenchida com números inteiros
matriz = matrix(c(1:16), nrow = 4, ncol = 4, byrow = T)
matriz

# Exercício 3 - Crie uma lista unindo o vetor e matriz criados anteriormente
lista = list(vetor, matriz)
lista

# Exercício 4 - Usando a função read.table() leia o arquivo do link abaixo 
# para uma dataframe
# http://data.princeton.edu/wws509/datasets/effort.dat
df = data.frame(read.table(file = 'http://data.princeton.edu/wws509/datasets/effort.dat', header = T))
df

# Exercício 5 - Transforme o dataframe anterior, em um dataframe nomeado 
# com os seguintes labels:
# c("config", "esfc", "chang")
names(df) = c("config", "esfc", "chang")
head(df)

# Exercício 6 - Imprima na tela o dataframe iris, verifique quantas dimensões
# existem no dataframe iris e imprima um resumo do dataset
iris
nrow(iris)
ncol(iris)
dim(iris)
summary(iris)
str(iris)

# Exercício 7 - Crie um plot simples usando as duas primeiras colunas do 
# dataframe iris
View(iris[T, c('Sepal.Length', 'Sepal.Width')])
plot(iris[, c(1,2)])
plot(iris$Sepal.Length, iris$Sepal.Width)

# Exercício 8 - Usando a função subset, crie um novo dataframe com o conjunto 
# de dados do dataframe iris em que Sepal.Length > 7
# Dica: consulte o help para aprender como usar a função subset()
df1 = iris[iris$Sepal.Length > 7,]
df1
nrow(df1)
ncol(df1)

?subset
df2 = subset(iris, iris$Sepal.Length > 7)
View(df2)
nrow(df2)
ncol(df2)
dim(df2)

# Exercícios 9 (Desafio) - Crie um dataframe que seja cópia do dataframe iris 
novo_iris <- iris
# e usando a função slice(), divida o dataframe em um subset de 15 linhas
# Dica 1: Você vai ter que instalar e carregar o pacote dplyr
library(dplyr)
# Dica 2: Consulte o help para aprender como usar a função slice()
help(slice)
df3 = slice(novo_iris,1:15)
df3

# Exercícios 10 - Use a função filter no seu novo dataframe criado no item
# anterior e retorne apenas valores em que Sepal.Length > 6
# Dica: Use o RSiteSearch para aprender como usar a função filter
filter(novo_iris, novo_iris$Sepal.Length > 7)


