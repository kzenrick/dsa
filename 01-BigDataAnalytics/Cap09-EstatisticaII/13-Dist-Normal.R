setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap09-EstatisticaII")
getwd()

# x <- rnorm(n, mean, sd)
# Onde n é o tamanho da amostra e mean e sd são parâmetros opcionais relacionados à média e desvio padrão, 
# respectivamente.


# d: calcula a densidade de probabilidade f(x) no ponto
# p: calcula a função de probabilidade acumulada F(x) no ponto
# q: calcula o quantil correspondente a uma dada probabilidade
# r: retira uma amostra da distribuição

# Para utlizar as funções combina-se uma das letras acima com uma abreviatura do nome da distribuição. 
# Por exemplo, para calcular probabilidades usamos: pnorm para normal, pexp para exponencial, 
# pbinom para binomial, ppois para Poisson e assim por diante.


# Distribuição Normal
?rnorm
x <- rnorm(100)
hist(x)

# Densidade
# # Observe que o gráfico gerado assemelha-se a uma Gaussiana e não apresenta assimentria. 
# Quando o gráfico da distribuição possui tal forma, há grandes chances de se tratar de uma distribuição normal.
x <- seq(-6, 6, by=0.01)
y <- dnorm(x)
plot(x, y, type="l")

