setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap09-EstatisticaII")
getwd()

cores = c('yellowgreen', 'wheat1', 'violetred3', 'turquoise2', 'tomato4', 
          'thistle', 'steelblue2', 'springgreen', 'slateblue3', 'sienna3')


# Exemplo: Analisar a covariância e correlação entre as variáveis milhas/galão e peso do veículo no dataset mtcars.

my_data <- mtcars
# View(my_data)


# Avaliação separadamente
# Variável mpg
estatisticas(my_data$mpg)
estatisticas(my_data$wt)


# install.packages("ggpubr")
library("ggpubr")
ggscatter(my_data, 
          x = "mpg", 
          y = "wt", 
          add = "reg.line",
          conf.int = TRUE, 
          #cor.coef = TRUE, 
          cor.method = "pearson",
          xlab = "Autonomia",
          ylab = "Peso do Veículo")


# Definindo x e y
x = my_data$mpg
y = my_data$wt

# Covariância
?cov
cov(x, y)

# Correlação
?cor
cor(x, y)
