setwd("~/Documentos/dsa/BigDataAnalytics/Cap09-EstatisticaII")
getwd()

cores = c('yellowgreen', 'wheat1', 'violetred3', 'turquoise2', 'tomato4', 
          'thistle', 'steelblue2', 'springgreen', 'slateblue3', 'sienna3')

library(plotrix)

##### Coeficiente de Assimetria #####

# Exemplo: Os seguintes dados representam o número de acidentes diários em um complexo industrial 
# (colocados em ordem crescente), durante o período de 50 dias. Represente o histograma desses dados.

dados = c(18, 20, 20, 21, 22, 24, 25, 25, 26, 27, 29, 29, 
          30, 30, 31, 31, 32, 33, 34, 35, 36, 36, 37, 37, 
          37, 37, 38, 38, 38, 40, 41, 43, 44, 44, 45, 45, 
          45, 46, 47, 48, 49, 50, 51, 53, 54, 54, 56, 58, 62, 65)


hist(dados, 
     main = "Número de Acidentes Diários", 
     xlab = "Acidentes", 
     ylab = "Frequência",
     col = cores)

ablineclip(v=as.integer(median(dados)), lty=3, col="grey1", lwd = 1)

mean(dados)
sd(dados)
median(dados)

library(moments)
?skewness
SK = skewness(dados)
print(SK)

# O coeficiente de assimetria é 0.2549279. 
# Como o coeficiente de assimetria é maior que 0, diz-se que a curva apresenta assimetria positiva 
# e a cauda do lado direito da função densidade de probabilidade é maior que no lado esquerdo. 
# Ao observar também o Histograma, percebe-se que há maior densidade de dados do lado direito. 

# Outro exemplo
set.seed(1234)
x = rnorm(1000)
hist(x, col = cores, xlab = as.character(median(x))  )
ablineclip(v=as.integer(median(x)), lty=3, col="grey1", lwd = 1)
skewness(x)


