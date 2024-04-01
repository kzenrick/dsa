setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap02-Fundamentos")
getwd()

# Lista de strings
lista_caracter1 = list('A','B','C')
lista_caracter1

lista_caracter2 = list(c('A','A'), 'B', 'C')
lista_caracter2
lista_caracter2[1][1]

lista_caracter3 = list(matrix(c("A","A","A","A") , nr =2), 'B', 'C')
lista_caracter3

lista_caracter1[1]
lista_caracter3[1]
lista_caracter3[1][1][2]

# lista de números inteiros
lista_inteiros = list(2,3,4)
lista_inteiros

# lista de floats
lista_numerico = list(1.9, 45.3, 300.5)
lista_numerico

# lista números complexos
lista_complexos = list(5+5i, 2.4 + 8i)
lista_complexos

# listas compostas
lista_composta1 = list("A", 3, T)
lista_composta1

lista1 <- list(1:10, c("Zico", "Ronaldo", "Garrincha"), rnorm(10))
lista1
?rnorm

# Slicing da lista
lista1[1]
lista1[2]
lista1[[2]][[1]]
lista1[[2]][[1]] = 'Monica'
lista1

# para nomear os elementos - Lista Nomeada
names(lista1) <- c('inteiros','caracteres','numericos')
lista1

vec_num <- 1.4
vec_char <- c('a','b','c', 'd')

lista2 <- list(Numeros=vec_num, Letras=vec_char)
lista2

# Nomear os elementos diretamente
lista2 <- list('elem1' = 3.5, elem2 = c(7,2,3,5))
lista2

# trabalhando com elementos diretamente
lista1
lista1$inteiros
length(lista1$inteiros)
lista1$caracteres

# verificar o comprimento da listta
length(lista1)

# extrair um elemento específico
lista1$inteiros[3]

# Modo dos elementos
mode(lista1$inteiros)
mode(lista1$caracteres)

# Combinando 2 listas
lista3 <- c(lista1, lista2)
lista3

# Transformando vetor em lista
v = c(1:3)
v
l = list(v)
l
l1 = as.list(v)
l1

# unindo 2 elementos em 1 lista
mat = matrix(1:4, nrow = 2)
mat
vec = (1:9)
vec
lst <- list(mat, vec)
lst
