setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap03-Estruturas")
getwd()

# Help
?sample
args(sample)
args(mean)
args(sd)

# Funcoes Built-in
abs(-43)
sum(c(1:5))
sum(seq(1,5))
mean(c(1:5))
round(1.1:5.8)
rev(c(1:5))
seq(1:5)
sort(rev(1:5))
append(c(1:5), 6)

vec1 <- c(1.5, 2.5, 8.4, 3.7, 6.3)
vec2 <- rev(vec1)
vec2

# Funções dentro de funções
plot(rnorm(10))
mean(c(abs(vec1), abs(vec2)))

# criando funções
myfunc <- function(x) {x + x}
myfunc(10)
class(myfunc)

myfunc2 <- function(a, b){
  valor = a ^ b
  print(valor)
}
myfunc2(3,2)

jogando_dados <- function(){
  num <- sample(1:6, size = 1)
  num
}

jogando_dados()

# Escopo
print(num) # só existe dentro da função 
num <- c(1:6)
num # Global

jogando_dados()

# Funçoes seem número definido de argumentos
vec1 <- (10:13)
vec1

vec2 <- c("a", "b", "c", "d")
vec2

vec3 <- c(6.5, 9.2, 11.9, 5.1)
vec3

myfunc3 <- function(...){
  df = data.frame(cbind(...))
  print(df)
}

myfunc3(vec1)
myfunc3(vec2, vec3)
myfunc3(vec1, vec2, vec3)

# Funções Built-in - Não reinventar a rodar
# Comparação de eficiência entre função vetorizada e função "vetorizada no 8"

x <- 1:10000000

# Função que calcula a raíz quadrada de cada elemento de um vetor de inteiros
meu_sqrt <- function(numeros){
  resp <- numeric(length(numeros))
  for (i in seq_along(numeros)){
    resp[i] <- sqrt(numeros[i])
  }
  return (resp)
}

system.time(x2a <- meu_sqrt(x))
system.time(x2b <- sqrt(x))

# Sua máquina pode apresentar resultados diferentes por conta
# da precisão de cálculo do processador
identical(x2a, x2b)
