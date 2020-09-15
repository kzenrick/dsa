setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics")
source("/home/vitorino/Projetos/Python/git/R/DSA/BigDataAnalytics/function_estatistica.R")

setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap09-EstatisticaII")
getwd()



# Exemplo: Considere um processo que têm uma taxa de 0,5 defeitos por unidade. 
# Qual a probabilidade de uma unidade apresentar dois defeitos? E nenhum defeito?
?dpois
dpois(2, 0.5)
dpois(0, 0.5)