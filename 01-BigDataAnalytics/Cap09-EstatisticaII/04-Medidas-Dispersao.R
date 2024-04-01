setwd("~/Documentos/dsa/BigDataAnalytics/Cap09-EstatisticaII")
getwd()

#### DESVIO PADRÂO ####
# Exemplo: Um engenheiro precisa decidir entre três modelos de máquinas de corte de alta precisão,
# para isso ele usa como critério o desvio padrão. A máquina que tiver menor desvio será a escolhida por ele. 
# A partir dos dados de medida de corte das 3 máquinas, determine qual deve ser a escolhida pelo engenheiro. 
# Máquina 1 (mm) = (181.9, 180.8, 181.9, 180.2, 181.4). 
# Máquina 2 (mm) = (180.1, 181.8, 181.5, 181.2, 182.4). 
# Máquina 3 (mm) = (182.1, 183.7, 182.1, 180.2, 181.9).

Maq1 = c(181.9, 180.8, 181.9, 180.2, 181.4)
Maq2 = c(180.1, 181.8, 181.5, 181.2, 182.4)
Maq3 = c(182.1, 183.7, 182.1, 180.2, 181.9)

# Média
mean(Maq1)
mean(Maq2)
mean(Maq3)

# Mediana
median(Maq1)
median(Maq2)
median(Maq3)

# Desvio Padrão
sd(Maq1) 
sd(Maq2)
sd(Maq3)

# Cálculo da variância para o exemplo anterior.

var(Maq1) 
var(Maq2)
var(Maq3)

