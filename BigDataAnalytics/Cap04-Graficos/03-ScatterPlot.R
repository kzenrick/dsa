setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap04-Graficos")
getwd()

# Define os dados
set.seed(67)
x = rnorm(10, 5, 7)
y = rpois(10, 7)
z = rnorm(10, 6, 7)
t = rpois(10, 9)

# Cria o plot
plot(x, y,
     col = 123,
     pch = 10,
     main = "Multi Scatterplot",
     col.main = "red",
     cex.main = 1.5,
     xlab = "Variável Independente",
     ylab = "Variável Dependente"
)

# Adiciona outros dados
points(z, t, col="blue", pch=4)

# Adiciona outros dados
points(y, t, col = 777, pch=9)

# Cria a legenda
legend(-6, 5.9,
       legend = c("Nivel 1", "Nivel 2", "Nivel 3"),
       col = c(123, "blue", 777),
       pch = c(10, 4, 9),
       cex = 0.45,
       bty = "n"
       )

ablineclip(v=1, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=-1, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=3, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=-3, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=5, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=-5, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=7, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=9, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=11, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=13, lty=3, col="paleturquoise4", lwd = 1)
ablineclip(v=15, lty=3, col="paleturquoise4", lwd = 1)

ablineclip(h=min(y,t), lty=3, col="paleturquoise4", lwd = 1)
ablineclip(h=median(c(median(y),median(t))), lty=3, col="paleturquoise4", lwd = 1)
ablineclip(h=mean(c(mean(y),mean(t))), lty=3, col="darkgray", lwd = 2)
ablineclip(h=max(y, t), lty=3, col="paleturquoise4", lwd = 1)
