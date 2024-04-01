setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap09-EstatisticaII")
getwd()

##### Quartis #####
# Exemplo: O horário de funcionamento de um banco já está se esgotando, para adiantar o atendimento dos clientes o 
# gerente decide para de chamar individualmente e passa a chamar em grupos de 1/4 da quantidade total de clientes na fila. 
# A partir dos números das fichas dos clientes, determine os grupos das 4 chamadas.
num_fichas = c(54, 55, 56, 57, 58, 59, 60, 61, 62, 63)
?quantile
quantile(num_fichas)

typeof(num_fichas)
?vector


##### Percentis #####

# Exemplo: Consoderando os dados do exemplos anterior, calcule o percentil 10, 80 e 98.
num_fichas = c(54, 55, 56, 57, 58, 59, 60, 61, 62, 63)
quantile(num_fichas, c(.10))
quantile(num_fichas, c(.80))
quantile(num_fichas, c(.98))

quantile(num_fichas, c(1/6, 2/6, 3/6, 4/6, 5/6, 6/6))
