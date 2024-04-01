setwd("~/Documentos/dsa/BigDataAnalytics/Cap04-Graficos")
getwd()

cores = c("red", "green", "blue", "yellow", "orange", "brown", "cyan", "black", 
          "brown", "gray", "whitesmoke")

library(plotrix)
# ablineclip(v=4, lty=3, col="paleturquoise4", lwd = 1)

?barplot

# Preparando os dados - Nº de casamento de uma igreja
dados <- matrix(c(652, 1537, 598, 242, 36, 46, 38, 21, 218, 327, 106, 67)
                , nrow = 3
                , byrow = T)
dados

# Nomeando linhas e colunas na matriz
colnames(dados) <- c("0", "1-150", "151-300", ">300")
rownames(dados) <- c("Jovem", "Adulto", "Idoso")
dados

# Construindo o Barplot
barplot(dados, beside = T, col = cores[1:3], ylim = c(0, 1600))
ablineclip(h=1599, lty=4, col="chocolate", lwd = 1)
ablineclip(h=1000, lty=4, col="grey43", lwd = 1)
ablineclip(h=599, lty=4, col="tan", lwd = 1)
ablineclip(h=100, lty=4, col="papayawhip", lwd = 1)

barplot(dados, col = cores[1:3], ylim = c(0, max(colSums(dados))*1.3))
ablineclip(h=1910, lty=4, col="chocolate", lwd = 1)
ablineclip(h=906, lty=4, col="plum1", lwd = 1)
ablineclip(h=742, lty=4, col="salmon2", lwd = 1)
ablineclip(h=330, lty=4, col="rosybrown1", lwd = 1)

# Cria a legenda
legend(4, 1500,
       legend = c("Jovem", "Adulto", "Idoso"),
       col = cores[1:3],
       pch =1
)

# Agora temos uma coluna para cada faixa etária, mas na mesma faixa de quantidade
barplot(dados, beside=T, col=c("steelblue1", "tan3", "seagreen3"))
legend("topright", legend = c("Jovem", "Adulto", "Idoso"),
       pch=1, col=c("steelblue1", "tan3", "seagreen3"))

# Com a transposta da matriz, invertemos as posições entre faixa etária e faixa de quantidade
barplot(t(dados), beside=T, col=c("steelblue1", "tan3", "seagreen3", "peachpuff1"))
legend("topright", legend = c("0", "1-150", "151-300", ">300"),
       pch=8, col=c("steelblue1", "tan3", "seagreen3", "peachpuff1"))
