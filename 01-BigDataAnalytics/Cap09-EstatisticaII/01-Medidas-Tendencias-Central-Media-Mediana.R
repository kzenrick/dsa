setwd("~/Documentos/dsa/BigDataAnalytics/Cap09-EstatisticaII")
getwd()

# Cálculo da média
notas = c(6.4, 7.3, 9.8, 7.3, 7.9, 8.2, 9.1, 5.6, 8.5, 6.8) 
notas
?mean
mean(notas)  
print(mean(notas))

length(notas)
sum(notas)

# Cálculo da mediana
tempos = c(400, 350, 510, 550, 690, 720, 750, 2000)
mean(tempos)
?median
median(tempos) 

length(tempos)
sum(tempos)

sort(tempos)
(550 + 690) / 2
