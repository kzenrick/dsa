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


# Usaremos o dataset iris neste exemplo
# O dataset iris possui observações de 3 especies de flores (Iris setosa, Iris virginica e Iris versocolor)
# Para cada flor, 4 medidas sao usadas: 
# comprimento (length) e largura (width) do caule (sepal) e comprimento e largura da petala (petal)
library(datasets)
head(iris)

show_info_dados(iris)

# Análise exploratoria de dados com ggplot2
library(ggplot2)

# Veja que os dados claramente possui grupos com caracteristcas similares
ggplot(iris, 
       aes(Petal.Length, Petal.Width, color = Species)
       ) + 
  geom_point(size = 3)


ggplot(iris, 
       aes(Sepal.Length, Sepal.Width, color = Species)
) + 
  geom_point(size = 3)

# Agora usarmeos o K-Means para tentar agrupar os dados em clusters
set.seed(101)
help(kmeans)

# Exercício 1 - Usando a função kmeans(), crie um modelo de clustering (aprendizagem não supervisionada). Use a documentação, para fazer sua pesquisa.
# Neste caso, ja sabemos quantos grupos (clusters) existem em nossos dados (3)
# Perceba que o dataset iris possui 5 colunas, mas estamos usando as 4 primeiras
#iris <- iris[c(1, 2, 3, 4)]

# install.packages("cluster")
 library(cluster)
# help(clusplot)


tentativas <- c(10, 25, 50, 100, 150, 200, 450, 500, 750, 1000, 2200, 3750, 5000)
iris_final <- iris

for (t in tentativas) {
  texto = paste("\nUsado para", t, "clusters", "\n")
  
  cat(texto)
  
  irisCluster <- kmeans(iris[c(1, 2, 3, 4)],
                        centers = 3,
                        iter.max = t)

  # Obtendo informação sobre os clusters
  # irisCluster$cluster
  print(table(irisCluster$cluster, iris$Species))
  irisCluster$centers

  # Foram criados 3 clusters: cluster 1, 2 e 3
  
  # Perceba que apesar o algoritmo ter feito a divisão dos dados em clusters, houve problema em dividir alguns dos dados, 
  # que apesar de terem caracteristicas diferentes, ficaram no mesmo cluster
  
  
  # Visualizando os clusters
  # Plot
  texto = paste("usado para", t, "clusters")
  clusplot(iris,
           irisCluster$cluster,
           main = texto,
           color = TRUE,
           shade = TRUE,
           labels = 0,
           lines = 0
  )
  
  # Salvando para comparação futura
  texto = sprintf('cluster_%02d', t)
  iris_final[[texto]] =  irisCluster$cluster
}


View(iris_final)


# Comparando com a DSA - informa nstar ao invés de n
irisCluster <- kmeans(iris[c(1, 2, 3, 4)],
                      centers = 3,
                      nstart = 20)

table(irisCluster$cluster, iris$Species)
irisCluster$centers

texto = DSA
clusplot(iris,
         irisCluster$cluster,
         main = texto,
         color = TRUE,
         shade = TRUE,
         labels = 0,
         lines = 0
)