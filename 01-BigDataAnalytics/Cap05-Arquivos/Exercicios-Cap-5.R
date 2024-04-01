# Solução Lista de Exercícios - Capítulo 5

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap05-Arquivos")
getwd()


# Exercicio 1 - Encontre e faça a correção do erro na instrução abaixo:
write.table(mtcars, 
            file = "mtcars2.txt", 
            sep = "|", 
            col.names = N, 
            qmethod = "double")

# *************
#   Resposta  *
# *************
file.remove('mtcars2.txt')
dir(pattern = 'mtcars2.txt')
write.table(mtcars, 
            file = "mtcars2.txt", 
            sep = "|", 
            col.names = NA,   # CORREÇÂO
            qmethod = "double")

dir(pattern = 'mtcars2.txt')

# Exercicio 2 - Encontre e faça a correção do erro na instrução abaixo:
library(readr)
df_iris <- read_csv("iris.csv", col_types = matrix(
  Sepal.Length = col_double(1),
  Sepal.Width = col_double(1),
  Petal.Length = col_double(1),
  Petal.Width = col_double(1),
  Species = col_factor(c("setosa", "versicolor", "virginica"))
))

# *************
#   Resposta  *
# *************
df_iris <- read_csv("iris.csv", 
                    col_types = list(
                      Sepal.Length = col_double(),
                      Sepal.Width = col_double(),
                      Petal.Length = col_double(),
                      Petal.Width = col_double(),
                      Species = col_factor(c("setosa", "versicolor", "virginica"))
                    ))

# Exercício 3 - Abaixo você encontra dois histogramas criados separadamente.
# Mas isso dificulta a comparação das distribuições. Crie um novo plot que faça a união 
# de ambos histogramas em apenas uma área de plotagem.

# Dados aleatórios
dataset1=rnorm(4000 , 100 , 30)     
dataset2=rnorm(4000 , 200 , 30) 

# Histogramas
par(mfrow=c(1,2))
hist(dataset1, breaks=30 , xlim=c(0,300) , col=rgb(1,0,0,0.5) , xlab="Altura" , ylab="Peso" , main="" )
hist(dataset2, breaks=30 , xlim=c(0,300) , col=rgb(0,0,1,0.5) , xlab="Altura" , ylab="Peso" , main="")

# *************
#   Resposta  *
# *************
hist(dataset1, breaks=30 , xlim=c(0,300) , col=rgb(1,0,0,0.5), xlab="Altura", ylab="Peso", main="" )
#text(20,500,"DS1",cex=0.85, col=rgb(1,0,0,0.5))

par(new=T)
hist(dataset2, breaks=30 , xlim=c(0,300) , col=rgb(0,0,1,0.5) , 
     ann = F,  # Suprime as descrições dos eixos 
     axes = F, # Suprime os eixos
     main="DS1 x DS2")
#text(20,450,"DS2",cex=0.85,col=rgb(0,0,1,0.5))
legend(0, 300, 
       pch = 19,
       #fill = T,
       legend=c('DS1', 'DS2'), 
       col = c(rgb(1,0,0,0.5), rgb(0,0,1,0.5))
       )

# * * * * * * * *
# DSA
hist(dataset2, breaks=30 , xlim=c(0,300) , col=rgb(0,0,1,0.5) , 
     add = T,  # Adiciona ao último grafico
     main="DS1 x DS2")
#text(20,450,"DS2",cex=0.85,col=rgb(0,0,1,0.5))
legend("topright",
       pch = 15,
       pt.cex = 2,
       legend=c('DS1', 'DS2'), 
       col = c(rgb(1,0,0,0.5), rgb(0,0,1,0.5))
)


# Exercício 4 - Encontre e corrija o erro no gráfico abaixo
#install.packages("plotly")
library(plotly)
head(iris)

plot_ly(iris, 
        x = ~Petal.Length, 
        y = ~Petal.Width,  
        type="scatter", 
        mode = "markers" , 
        color = Species , 
        marker=list(size=20 , opacity=0.5))

# *************
#   Resposta  *
# *************

plot_ly(iris, 
        x = ~Petal.Length, 
        y = ~Petal.Width,  
        type="scatter", 
        mode = "markers" , 
        color = ~Species , 
        marker=list(size=20 , opacity=0.5))

# Exercício 5 - Em anexo você encontra o arquivo exercicio5.png. Crie o gráfico que resulta nesta imagem.
# *************
#   Resposta  *
# *************
p <- plot_ly(z = volcano, type = "surface")
p 


# Exercício 6 - Carregue o arquivo input.json anexo a este script e imprima o conteúdo no console
# Dica: Use o pacote rjson
# *************
#   Resposta  *
# *************
# install.packages('rjson')
library(rjson)

json <- fromJSON(file = 'input.json')
json
class(json)

# Exercício 7 - Converta o objeto criado ao carregar o arquivo json do exercício anterior 
# em um dataframe e imprima o conteúdo no console.
# *************
#   Resposta  *
# *************
df1 <- as.data.frame(json)
print(df1)

# Exercício 8 - Carregue o arquivo input.xml anexo a este script.
# Dica: Use o pacote XML
# *************
#   Resposta  *
# *************
# install.packages('XML')
library(XML)
xml <- xmlParse('input.xml')
xml
class(xml)

# Exercício 9 - Converta o objeto criado no exercício anterior em um dataframe
# *************
#   Resposta  *
# *************
df2 <- xmlToDataFrame(xml)
df2


# Exercício 10 - Carregue o arquivo input.csv em anexo e então responda às seguintes perguntas:
csv <- read.csv(file = 'input.csv')
csv
class(csv)

# Pergunta 1 - Quantas linhas e quantas colunas tem o objeto resultante em R?
dim(csv)
# *****
# DS
ncol(csv)
nrow(csv)

# Pergunta 2 - Qual o maior salário?
require(dplyr)
m <- csv %>%
  summarise(maior = max(salary))
m$maior

# ****
# DSA
sal <- max(csv$salary)
sal

# Pergunta 3 - Imprima no console o registro da pessoa com o maior salário.
csv %>%
  filter(salary == m$maior)

# ***
# DSA
sal <- subset(csv, salary == max(salary))
sal

# ***
# Mixto
csv %>%
  filter(salary == max(salary))

# Pergunta 4 - Imprima no console todas as pessoas que trabalham no departamento de IT.
csv %>%
  filter(dept == 'IT')

# ****
# DSA
subset(csv, dept == 'IT')

# Pergunta 5 - Imprima no console as pessoas do departamento de IT com salário superior a 600. 
csv %>%
  filter(dept == 'IT' & salary > 600)

# ***
# DSA
subset(csv, dept == 'IT' & salary > 600)
