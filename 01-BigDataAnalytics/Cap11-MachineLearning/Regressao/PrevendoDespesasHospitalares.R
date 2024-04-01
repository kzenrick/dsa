setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap11-MachineLearning/Regressao")
getwd()

# Problema de Negócio: Previsão de Despesas Hospitalares

# Para esta análise, vamos usar um conjunto de dados simulando despesas médicas
# hipotéticas para um conjuntos de pacientes espalhados por 4 regiões do Brasil.
# Esse dataset possui 1.338 observações e 7 variáveis

# Etapa 1: Coletando os dados
despesas <- read.csv('despesas.csv')

# Etapa 2: Explorando e preparando os Dados
# Visualizando as variáveis
str(despesas)

# Mostrar o total por região
library(dplyr)
despesas %>% select(regiao) %>% group_by(regiao) %>% summarise(n = n()) 

# Médias de tendencia central da variável gastos
summary(despesas$gastos)

# Construindo um histograma
hist(despesas$gastos, main = 'Histograma', xlab = 'Gastos')

# Construindo um Boxplot
boxplot(despesas$gastos, main = 'Boxplot', xlab = 'Gastos')

# Tabela de contigência das regiões
table(despesas$regiao)

# Explorando relacionamento entre as variáveis: Matriz de Correlação
cor(despesas[c('idade', 'bmi', 'filhos', 'gastos')])

# Nenhuma das correlações da matriz é considerada forte (distante de zero e próximas de -1 ou 1),
# mas existem algumas associações interessantes. Por exemplo, a idade e o bmi (IMC) parecem ter
# uma correlação positiva fraca, o que significa que com o aumento da idade, a massa corporal
# tende a aumentar. Há também uma correlação positiva moderada entre a idade e os gastos, além
# do número de filhos e os gastos. Estas associações implicam que, à media que idade, massa corporal 
# e  nº de filhos aumenta, o custo esperado do seguro saúde sobe.

# Visualizando relacionamento entre as variáveis: Scatterplot
# Perceba que não existe um claro relacionamento entre as variáveis
pairs(despesas[c('idade', 'bmi', 'filhos', 'gastos')])

#install.packages("psych")
library(psych)

# Este gráfico fornece mais informações sobre o relacionamento entre as variáveis
pairs.panels(despesas[c('idade', 'bmi', 'filhos', 'gastos')])

# Etapa 3: Treine o modelo
?lm
modelo <- lm(gastos ~ idade + filhos + bmi + sexo + fumante + regiao, data = despesas)

# similiar ao item anterior
modelo <- lm(gastos ~ ., data = despesas)

# visualizar os coeficientes
modelo

# Aqui verificamos os gastos previstos pelo modelo que devem ser iguais aos dados de treino
previsao1 <- predict(modelo)
class(previsao1)
View(previsao1)

# Prevendo os gastos com Dados de teste
despesasteste <- read.csv("despesas-teste.csv")
View(despesasteste)
previsao2 <- predict(modelo, despesasteste)
View(previsao2)

# Etapa 4: Avaliando a Performance do Modelo
# Mais detalhes sobre o modelo
summary(modelo)


# Etapa 5: Otimizando a Performance do Modelo

# Adicionando uma variável com o dobro do valor das idades
despesas$idade2 <- despesas$idade ^ 2

# Adicionando um indicador para BMI >= 30
despesas$bmi30 <- ifelse(despesas$bmi >= 30, 1, 0)

View(despesas)

# Criando o modelo final
modelo_v2 <- lm(gastos ~ idade + idade2 + filhos + bmi + sexo +
                  bmi30 * fumante + regiao, data = despesas)

summary(modelo_v2)

# Dados de teste
despesasteste <- read.csv("despesas-teste.csv")
View(despesasteste)
previsao <- predict(modelo, despesasteste)
class(previsao)
View(previsao)
