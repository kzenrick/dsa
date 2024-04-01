setwd("~/Documentos/dsa/BigDataAnalytics/Cap04-Graficos")
getwd()

?boxplot
?sleep

# Permite utilizar as colunas sem especificar o nome do dataset
attach(sleep)

# Construção do boxplot
sleepbloxpot = boxplot(data = sleep, 
                       extra ~ group, # relação entre as variáveis do Dataset
                       main = "Duração do Sono",
                       col.main = "red", 
                       ylab = "Horas", 
                       xlab = "Droga"
                       )

# Cálculos da média
medias = by(extra, group, mean)
mediana = by(extra, group, median)

# Adiciona a média ao gráfico
points(medias, col = "darkgray")
points(mediana, col = "cyan", pch = 2)

# Boxplots horizontais
horizontalboxplot = boxplot(data = sleep, extra ~group,
                            ylab = "", xlab = "", horizontal = T)

horizontalboxplot = boxplot(data = sleep, extra ~group,
                            ylab = "", xlab = "", horizontal = T,
                            col = c("blue", "red4"))

