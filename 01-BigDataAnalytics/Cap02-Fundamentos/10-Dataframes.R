setwd("~/Documentos/dsa/BigDataAnalytics/Cap02-Fundamentos")
getwd()

# Criando o dataframe
df <- data.frame()
class(df)
df

# criando vetores vazios
nomes1 <- character(10)
nomes <- character()
idades <- numeric()
itens <- numeric()
codigos <- integer()

df <- data.frame(c(nomes, idades, itens, codigos))
df

# criando vetores
pais = c("Portugal", "Inglaterra", "Irlanda", "Egito", "Brasil")
nome = c("Bruno", "Tiago", "Amanda", "Bianca", "Marta")
altura = c(1.88, 1.76, 1.54, 1.69, 1.68)
codigo = c(5001, 2183, 4702, 7965, 8890)

# Criando dataframe  de diversos vetores
pesquisa = data.frame(pais, nome, altura, codigo)
pesquisa
length(pesquisa)

# adicionando um novo vetor ao dataframe
olhos = c('verde', 'azul', 'azul', 'castanho', 'castanho')
pesq = cbind(pesquisa, olhos)
pesq

# informação sobre o DF
str(pesq)
dim(pesq)
length(pesq)

# obtendo vetor do dataframe
pesq$pais
pesq$nome

# extraindo um único valor
pesq$pais[3]
pesq$pais[1:3]
pesq$pais[1,3]
pesq$pais[1;3]

pesq[1:3]
pesq[2]
pesq[[2]]
pesq[3, 2]

# Número de linhas e colunas
nrow(pesq)
ncol(pesq)

# Primeiros elementos de data frame
head(pesq)
head(mtcars)

nrow(mtcars)
ncol(mtcars)
View(pesq)

# Ultimos elementos
tail(pesq)
tail(mtcars)

# DF built-in
?mtcars
mtcars
mtcars[1]
View(mtcars)

# Filtros para um subset
pesq[altura < 1.60,]
pesq[altura < 1.61, c('codigo', 'olhos')]
pesq

# DF nomeados
names(pesq) <- c("Pais", "Nome", "Altura", "Codigo", "Olhos")
names(pesq)
pesq

colnames(pesq)
colnames(pesq) <- c('var1', 'var2', 'var3', 'var4', 'var5')
pesq

rownames(pesq)
rownames(pesq) <- c('obs1', 'obs2', 'obs3', 'obs4', 'obs5')
pesq

# carregando um arquivo csv
?read.csv

pacientes <- data.frame(read.csv(file='pacientes.csv',header = T,sep = ','))
View(pacientes)
head(pacientes)
summary(pacientes)

# Visualizando as variáveis
pacientes$Diabete
pacientes$Status

# Histograma
hist(pacientes$Idade)

# Combinando DataFrames
dataset_final = merge(pesq, pacientes)
dataset_final
