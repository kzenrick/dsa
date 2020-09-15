setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap07-ManipulacaoDados")
getwd()

# Instalando o pacote 
library(haven)

# SAS
vendas <- read_sas('vendas.sas')
class(vendas)
print(vendas)
str(vendas)

# stata
df_stata <- read_dta('mov.dta')
class(df_stata)
str(df_stata)
head(df_stata)

# Pacote foreign
# install.packages('foreign')
library(foreign)

# Stata
florida <- read.dta('florida.dta')
tail(florida)
class(florida)

# SPSS
dados <- read.spss('international.sav')
class(dados)
head(dados)
df <- data.frame(dados)
df
head(df)

# Criando boxplot
boxplot(df$gdp)


# Se você estiver familiarizado com estatística, 
# você vai ter ouvido falar de Correlação. 
# É uma medida para avaliar a dependência linear entre duas variáveis. 
# Ela pode variar entre -1 e 1; 
# Se próximo de 1, significa que há uma forte associação positiva entre as variáveis. 
# Se próximo de -1, existe uma forte associação negativa: 
# Quando a correlação entre duas variáveis é 0, essas variáveis são possivelmente 
# independentes: 
# Ou seja, não há nenhuma associação entre X e Y.

# Coeficiente de Correlação. Indica uma associação negativa entre GDP e 
# alfabetização feminina
cor(df$gdp, df$f_illit)


# **** Importante ****
# Correlação não implica causalidade
# A correlação, isto é, a ligação entre dois eventos, não implica 
# necessariamente uma relação de causalidade, ou seja, que um dos 
# eventos tenha causado a ocorrência do outro. A correlação pode 
# no entanto indicar possíveis causas ou áreas para um estudo mais 
# aprofundado, ou por outras palavras, a correlação pode ser uma 
# pista.

