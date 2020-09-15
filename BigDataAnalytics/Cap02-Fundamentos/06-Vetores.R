setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap02-Fundamentos")
getwd()

# Vetor de string
vetor_caracter = c("Data", "Science", "Academy")
vetor_caracter

vetor_numerico = c(1.9, 45.3, 300.5)
vetor_numerico

vetor_complexo = c(5.3 + 2i, 66 +  0i, 3.8 + 4i)
vetor_complexo

vetor_logico = c(TRUE, FALSE, FALSE, TRUE)
vetor_logico

vetor_inteiro = c(1, 2, 3, 4)
vetor_inteiro

# utilizando seq
vetor1 = seq(1:10)
vetor1
is.vector(vetor1)

# utilizando rep()
vetor2 = rep(1:4)
vetor2
is.vector(vetor2)

# indexação de vetor
a <- seq(1:5)
a
a[1]
a[6]

b <- vetor_caracter
b
b[1]
b[2]
b[3]
b[4]

# Combinando vetores
v1 = c(2, 3, 5)
v2 = c('aa', 'bb', 'cc', 'dd', 'ee')
c(v1, v2)
r = c(v1, v2)
length(r)
mode(r)
class(r)
typeof(r)

# operação com vetores
x = c(1, 3, 5, 7)
y = c(2, 4, 6, 8)

x + y
x - y
x * y
x / y
x %% y

# somando vetores com tamanhos diferentes de elementos
alfa = c(10, 20, 30)
beta = seq(1:9)
alfa + beta

# Vetor Nomeado
v = c("Nelson", "Mandela")
v
mode(v)
typeof(v)
names(v) = c("Nome", "Sobrenome")
v
v["Nome"]

mode(v)
typeof(v)

rm(v)
