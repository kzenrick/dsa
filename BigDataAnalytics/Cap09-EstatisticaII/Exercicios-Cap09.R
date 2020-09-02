# Solução Lista de Exercícios - Capítulo 9

setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics")
source("/home/vitorino/Projetos/Python/git/R/DSA/BigDataAnalytics/function_estatistica.R")

setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap09-EstatisticaII")
getwd()

# Exercício 1 - Gere 1000 números de uma distribuição normal com média 3 e sd = .25 e grave no objeto chamado x.
x <- rnorm(1000, mean = 3, sd = 0.25)

#-- Resposta 
# Igual

# Exercício 2 - Crie o histograma dos dados gerados no item anterior e adicione uma camada com a curva da normal.
# Histograma
library(ggplot2)
datasim <- data.frame(x)

ggplot(datasim, 
       aes(x = x), 
       binwidth = 2) + 
  geom_histogram(aes(y = ..density..), 
                 fill = 'red', 
                 alpha = 0.5) + 
  geom_density(colour = 'blue') + 
  xlab(expression(bold('Dados'))) + 
  ylab(expression(bold('Densidade')))


# -- Resposta
hist(x, 
     prob = T,
     ylim = c(0, 1.8),  # Informa a densidade
     breaks = 20,
     main = 'Histograma de x')
curve(dnorm(x, 3, 0.25),
      add=T,
      col='red',
      lwd=1)

# --
library(moments)
skewness(x)
kurtosis(x)



# Exercício 3 - Suponha que 80% dos adultos com alergias relatem alívio sintomático com uma medicação específica. 
# Se o medicamento é dado a 10 novos pacientes com alergias, qual é a probabilidade de que ele seja 
# eficaz em exatamente sete?
# -> Sucesso
# -> Amostra
# -> probabilidade
dbinom(7, 10, 0.8)

# -- resposta igual
# mostra gráfico
graph <- function(n, p){
  x <- dbinom(0:n, size = n, prob = p)
  barplot(x,
          ylim = c(0, 0.4),
          names.arg = 0:n,
          main = sprintf(paste('Binominal Distribuition(n,p) ', n, p, sep=','))
          )
}

graph(10, 0.8)
  


# Exercício 4 - Suponha que os resultados dos testes de um vestibular se ajustem a uma distribuição normal. 
# Além disso, a pontuação média do teste é de 72 e o desvio padrão é de 15,2. 
# Qual é a porcentagem de alunos que pontuaram 84 ou mais no exame?
x <- rnorm(100, mean = 72, sd = 15.2)
hist(x)
# 1ª Normal tem 68% -> entre 56.8 e 87.2
# 2ª Normal tem 95% -> Cresceu 37% -> 18
# 3ª Normal tem 99% -> Cresceu 04 -> 20%

library(dplyr)
d <- data.frame(x)
d %>% filter(x >= 84) %>% summarise(n = n())

quantile(x)

# -- Respota
pnorm(84, mean = 72, sd = 15.2, lower.tail = F)

# Exercício 5 - Suponha que o tempo médio de check-out de um caixa de supermercado seja de três minutos. 
# Encontre a probabilidade de um check-out do cliente ser concluído pelo caixa em menos de dois minutos.
# t_medio = 3 min
dpois(c(0:2), 3)

# -- Resposta
# A Taxa de processamento de checkout é igual a uma dividida pelo tempo médio da conclusão da finali-
# zação. Por isso, a taxa de processamento é de 1/3 de checkouts por minuto
# Em seguida, aplicamos a função pexp da distribuição  exponencial com taxa = 1/3
pexp(2, rate = 1/3)


# Exercício 6 - Selecione dez números aleatórios entre um e três.
# Aplicamos a função de geração runif da distribuição uniforme para gerar dez números aleatórios entre um e três.
x <- runif(30, 1, 3)
print(x)

# -- Resposta Igual

# Exercício 7 - Se houver 12 carros atravessando uma ponte por minuto, em média, 
# encontre a probabilidade de ter 15 ou mais carros cruzando a ponte em um determinado minuto.
dpois(15, 12)

-- # Resposta
# 14 ou menos carros passando pela ponte
ppois(14, lambda = 12)

# 15 exatamente
ppois(15, lambda = 12, lower.tail = F)

# Exercício 8 - Suponha que haja 12 questões de múltipla escolha em um questionário de inglês. 
# Cada questão tem cinco respostas possíveis e apenas uma delas está correta. 
# Encontre a probabilidade de ter quatro ou menos respostas corretas se um aluno tentar 
# responder a cada pergunta aleatoriamente.

# Probabilidade de acertar 1 questão no chute 1/5 = 0.2
# Total de questões 12
sum(dbinom(c(0:4), 12, 0.2))

# -- Resposta
pbinom(4, 12, 0.2)


