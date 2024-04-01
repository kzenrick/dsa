setwd("~/Documentos/dsa/BigDataAnalytics/Cap09-EstatisticaII")
getwd()

# Exemplo: Os seguintes dados representam o número de acidentes diários em um complexo industrial 
# (colocados em ordem crescente), durante o período de 50 dias. Represente o histograma desses dados.

dados = c(18, 20, 20, 21, 22, 24, 25, 25, 26, 27, 29, 29, 
          30, 30, 31, 31, 32, 33, 34, 35, 36, 36, 37, 37, 
          37, 37, 38, 38, 38, 40, 41, 43, 44, 44, 45, 45, 
          45, 46, 47, 48, 49, 50, 51, 53, 54, 54, 56, 58, 62, 65)

cores = c('yellowgreen', 'wheat1', 'violetred3', 'turquoise2', 'tomato4', 
          'thistle', 'steelblue2', 'springgreen', 'slateblue3', 'sienna3')

hist(dados, main = "Número de Acidentes Diários", xlab = "Acidentes", ylab = "Frequência", col = cores)
hist(dados, main = "Número de Acidentes Diários", xlab = "Acidentes", ylab = "Frequência", breaks = 6, col = cores)
hist(dados, main = "Número de Acidentes Diários", xlab = "Acidentes", ylab = "Frequência", breaks = 5, col = cores)
?hist

library(plotrix)
ablineclip(v=as.integer(mean(dados)), lty=3, col="darkgreen", lwd = 1)
ablineclip(h=3, lty=3, col="slategray2", lwd = 1)
ablineclip(h=5, lty=3, col="slategray2", lwd = 1)
ablineclip(h=7, lty=3, col="slategray2", lwd = 1)
ablineclip(h=10, lty=3, col="slategray2", lwd = 1)
ablineclip(h=13, lty=3, col="slategray2", lwd = 1)
ablineclip(h=15, lty=3, col="slategray2", lwd = 1)

