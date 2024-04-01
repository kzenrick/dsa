setwd("~/Documentos/dsa/BigDataAnalytics/Cap09-EstatisticaII")
getwd()

cores = c('yellowgreen', 'wheat1', 'violetred3', 'turquoise2', 'tomato4', 
          'thistle', 'steelblue2', 'springgreen', 'slateblue3', 'sienna3')


library(plotrix)

dados = c(18, 20, 20, 21, 22, 24, 25, 25, 26, 27, 29, 29, 
          30, 30, 31, 31, 32, 33, 34, 35, 36, 36, 37, 37, 
          37, 37, 38, 38, 38, 40, 41, 43, 44, 44, 45, 45, 
          45, 46, 47, 48, 49, 50, 51, 53, 54, 54, 56, 58, 62, 65)


mean(dados)
sd(dados)
median(dados)
range(dados)
quantile(dados)

boxplot(dados, 
        main = "Número de Acidentes Diários",
        col = cores)

ablineclip(h=as.integer(median(dados)), lty=3, col="grey1", lwd = 1)
ablineclip(h=as.integer(quantile(dados)[1]), lty=4, col="grey1", lwd = 1)
ablineclip(h=as.integer(quantile(dados)[2]), lty=4, col="grey1", lwd = 1)
ablineclip(h=as.integer(quantile(dados)[3]), lty=4, col="grey1", lwd = 1)
ablineclip(h=as.integer(quantile(dados)[4]), lty=4, col="grey1", lwd = 1)
ablineclip(h=as.integer(quantile(dados)[5]), lty=4, col="grey1", lwd = 1)
ablineclip(h=46, lty=5, col="grey1", lwd = 1)
