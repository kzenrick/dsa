setwd("~/Documentos/dsa/BigDataAnalytics/Cap09-EstatisticaII")
getwd()

cores = c('yellowgreen', 'wheat1', 'violetred3', 'turquoise2', 'tomato4', 
          'thistle', 'steelblue2', 'springgreen', 'slateblue3', 'sienna3')


library(plotrix)

dados = c(18, 20, 20, 21, 22, 24, 25, 25, 26, 27, 29, 29, 
          30, 30, 31, 31, 32, 33, 34, 35, 36, 36, 37, 37, 
          37, 37, 38, 38, 38, 40, 41, 43, 44, 44, 45, 45, 
          45, 46, 47, 48, 49, 50, 51, 53, 54, 54, 56, 58, 62, 65)

hist(dados, main = "Número de Acidentes Diários", xlab = "Acidentes", ylab = "Frequência", col = cores)

ablineclip(v=as.integer(median(dados)), lty=3, col="grey1", lwd = 1)

mean(dados)
sd(dados)
median(dados)

library(moments)
?kurtosis
CK = kurtosis(dados)
print(CK)

# O coeficiente de curtose é igual a 2.37652. Logo, como o valor de CK é maior que 0, a curva é Leptocúrtica.

n.sample <- rnorm(n = 10000, mean = 55, sd = 4.5)

# Skewness e Kurtosis
library(moments)
skewness(n.sample)
kurtosis(n.sample)

# Histograma
library(ggplot2)
datasim <- data.frame(n.sample)

ggplot(datasim, 
       aes(x = n.sample), 
       binwidth = 2) + 
  geom_histogram(aes(y = ..density..), 
                 fill = 'red', 
                 alpha = 0.5) + 
  geom_density(colour = 'blue') + 
  xlab(expression(bold('Dados'))) + 
  ylab(expression(bold('Densidade')))
