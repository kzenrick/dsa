setwd("~/Documentos/dsa/BigDataAnalytics/Cap02-Fundamentos")
getwd()

# vetor: possui 1 dimensão e 1 tipo de dados
vetor1 <- c(1:20)
vetor1
length(vetor1)
mode(vetor1)
class(vetor1)
typeof(vetor1)

# matriz: 2 dimensões e 1 tipo de dados
matriz1 <- matrix(1:20, nrow = 2)
matriz1
length(matriz1)
mode(matriz1)
class(matriz1)
typeof(matriz1)

# array: 2 ou mais dimensões e 1 tipo de dado
array1 <- array(1:5, dim = c(3,3,3))
array1
length(array1)
mode(array1)
class(array1)
typeof(array1)

# Data Frame: dados de diferentes tipos
# Resumido: matriz de diversos tipos
View(iris)
length(iris)
mode(iris)
class(iris)
typeof(iris)

# Listas: coleções de diferentes objetos
# diferentes tipos de dados
lista1 <- list(a=matriz1, v=vetor1)
lista1
length(lista1)
mode(lista1)
class(lista1)
typeof(lista1)

# Funções também são vista como objetos pelo R
func1 <- function(x){
  var1 <- x * x
  return (var1)
}

func1(5)
class(func1)

# removendo objetos
objects()
rm(array1, lista1, func1)
