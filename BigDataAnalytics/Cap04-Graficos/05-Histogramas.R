setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap04-Graficos")
getwd()

# Definição dos dados
?cars
View(cars)
dados = cars$speed
min(dados);mean(dados);median(dados);max(dados)

# Construindo um histograma
?hist
hist(dados)

# Conforme consta no help, o paramêtro breaks pode ser um dos itens abaixo:
# * Um vetor para os pontos de quebra entre as células do histograma
# * Uma função para calcular o vetor de breakpoints
# * Um único número que representa o número de células para o histograma
# * Uma cadeia de caracteres que nomeia um algoritmo para calcular o número de células
# * Uma função para calcular o número de células
cores = c("red", "green", "blue", "yellow", "orange", "brown", "cyan", "black", 
          "brown", "gray", "whitesmoke")
hist(dados, 
     breaks = 10, 
     main = "Histograma das velocidades", 
     col = cores)

hist(dados, 
     labels = T, 
     breaks = c(0,5, 10, 20, 30),
     main = "Histograma das velocidades",
     col = cores[1:5])

hist(dados, 
     labels = T,
     breaks = 10, 
     main = "Histograma das velocidades", 
     col = cores)

hist(dados,
     labels = T,
     ylim = c(0,10),
     breaks = 10,
     main = "Histograma das velocidades",
     col = cores)

library(plotrix)
ablineclip(v=4, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=6, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=8, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=10, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=12, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=14, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=16, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=18, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=20, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=22, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=24, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=26, lty=3, col="paleturquoise4", lwd = 1)

# Adicionando linhas ao histograma
grafico <- hist(dados, breaks=10, main = "Histograma das velocidades", col = cores)
xaxis = seq(min(dados), max(dados), length = 10)
yaxis = dnorm(xaxis, mean = mean(dados), sd = sd(dados))
yaxis = yaxis * diff(grafico$mids) * length(dados)

lines(xaxis, yaxis, col = "purple4")
