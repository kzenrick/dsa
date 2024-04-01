setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics")
source("/home/vitorino/Projetos/Python/git/R/DSA/BigDataAnalytics/function_estatistica.R")

setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap11-MachineLearning")
getwd()

# Carrega o pacote readr
library(readr)

# Carregando o dataset
carros <- read_csv('carros-usados.csv')

# Resumo dos dados
View(carros)
str(carros)

# Medidas de tendência Central
summary(carros$ano)
summary(carros[c('preco', 'kilometragem')])


# ---------- Análise Exploratória de Dados para variáveis numéricas
# Usando as funções
mean(carros$preco)
median(carros$preco)
quantile(carros$preco)
quantile(carros$preco, probs = c(0.01, 0.99))
quantile(carros$preco, seq(from = 0, to = 1, by = 0.20))
IQR(carros$preco) # Diferença entre Q3 e Q1

range(carros$preco)
diff(range(carros$preco))

# Plot

# BoxPlot
# Leitura de baixo para cima - Q1, Q2 (Mediana) e Q3
boxplot(carros$preco, main = 'Boxplot para os Preços de Carros Usados', ylab = 'Preço (R$)')
boxplot(carros$kilometragem, main = 'Boxplot para KM de Carros Usados', ylab = 'Preço (R$)')

# Histograma
# Indicam a frequencia de valores dentro de cada bin (classe de valores)
cores = c(geraCor(), geraCor(), geraCor(), geraCor())
hist(carros$preco, main = 'Histograma para os Preços Carros Usados', xlab = 'Preço (R$)', col = cores)
hist(carros$kilometragem, main = 'Histograma para o KM Carros Usados', xlab = 'Kilometragem', col = cores)
hist(carros$kilometragem, main = 'Histograma para o KM Carros Usados', breaks = 5, xlab = 'Kilometragem', col = cores)

# Scatterplot
# Usando o preço como variável dependente (y)
plot(x = carros$kilometragem, 
     y = carros$preco,
     main = 'Scatterplot - Preço x KM',
     xlab = 'Kilometragem',
     ylab = 'Preço (R$)')

# Medidas de Dispersão
# Ao interpretar a variância, números maiores indicam que
# os dados estão espalhados mais amplamente em torno da média.
# O desvio padrão indica, em média, a quantidade de cada valor diferente da média
var(carros$preco)
sd(carros$preco)
var(carros$kilometragem)
sd(carros$kilometragem)


#---------- Análise exploratória de Dados para Variáveis Categóricas
# Criando tabelas de contigência - representam uma única variavel categórica
# Lista as categorias das variaveis nominais
?table
str(carros)
table(carros$cor)
table(carros$modelo)

# Calculando a proporção de cada categoria
model_table <- table(carros$modelo)
prop.table(model_table)

prop.table(table(carros$transmissao))

# Arredondando os valores
model_table <- prop.table(model_table) * 100
round(model_table, digits = 1)

# Criando uma nova variável indicando cores conservadoras - compradas com mais frequencia
head(carros)
carros$conserv <- carros$cor %in% c('Preto', 'Cinza', 'Prata', 'Branco')
head(carros)

# Checando a variável
table(carros$conserv)

# Verificando relacionamento entre duas variáveis categóricas
# Criando uma crossTable
# Tabelas de contigência fornecem uma maneira de exibir as frequencias e 
# frequencias relativas de observações, que são classificadas de acordo com 
# duas variáveis categóricas. Os elementos de uma categoria são exibidas através 
# das coluna; os elementos de outra categorias são exibidas sobre as linhas

#install.packages('gmodels')
library(gmodels)
?CrossTable
CrossTable(x = carros$modelo, y = carros$conserv)

## Teste do Qui-quadrado
# Qui Quadrado, simbolizado por x² é um teste de hipóteses que se destina a 
# encontrar um valor da dispersão para duas variáveis nominais, avaliando a 
# associação existente entre variáveis qualitativas.

# É um teste não paramétrico, ou seja, não depende dos parâmetros populacionais, 
# como média e variância.

# O princípio básico deste método é comparar proprções, isto é, as possíveis divergências
# entre as frequencias observadas e esperadas para um certo evento.
# Evidentemente, pode-se dizer que dois grupos se comportam de forma semelhante se as 
# diferenças entre as frequencias observadas e as esperadas em cada categoria 
# forem muito pequenas, próximas a zero.

# Ou seja, se a probabilidade é muito baixa, ele fornece fortes evidências de que 
# as duas variáveis estão associadas.

CrossTable(x = carros$modelo, y =carros$conserv, chisq = T)
chisq.test(x = carros$modelo, y =carros$conserv)

# Trabalhamos com 2 hipóteses:
# Hipótese nula: as frequencias observadas não são diferentes das frequencias esperadas.
# Não existe diferença entre as frequencias (contagens) dos grupos.
# Portanto, não há associação entre os grupos.

# Hipótese alternativa: As frequencias observadas são diferentes das frequencias esperadas
# portanto existe diferente entre as frequencias.
# Portanto, há associação entre os grupos

# Neste caso o valor do qui quadrado = 0.15
# E grau de liberdade igual a 2 (df = 2)
# Portanto, não há associação entre os grupos
# O valor alto do p-value confirma esta conculsão.