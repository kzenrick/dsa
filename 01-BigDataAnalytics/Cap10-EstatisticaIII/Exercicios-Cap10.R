# Solução Lista de Exercícios - Capítulo 10

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

# Solução Lista de Exercícios - Capítulo 9

setwd("~/Documentos/dsa/BigDataAnalytics")
source("~/Documentos/dsa/BigDataAnalytics/function_estatistica.R")

setwd("~/Documentos/dsa/BigDataAnalytics/Cap10-EstatisticaIII")
getwd()


# Pacotes
# install.packages("dplyr")
# install.packages('nycflights13')
library('ggplot2')
library('dplyr')
library('nycflights13')
View(flights)
?flights

# Definindo o Problema de Negócio
# Crie um teste de hipótese para verificar se os voos da Delta Airlines (DL)
# atrasam mais do que os voos da UA (United Airlines)


##### ATENÇÃO #####
# Você vai precisar do conhecimento adquirido em outros capítulos do curso 
# estudados até aqui para resolver esta lista de exercícios!


# Exercício 1 - Construa o dataset pop_data com os dados de voos das 
# companhias aéreas UA (United Airlines) e DL (Delta Airlines). 
# O dataset deve conter apenas duas colunas, nome da companhia e atraso nos voos de chegada.
# Os dados devem ser extraídos do dataset flights para construir o dataset pop_data
# Vamos considerar este dataset como sendo nossa população de voos
pop_data <- flights %>% 
  select(carrier, arr_delay) %>% 
  filter((!is.na(arr_delay)) & (carrier %in% c('UA', 'DL')))

# Solução
pop_data <- na.omit(flights) %>% # Desconsidera os dados nulos
  filter(carrier == 'UA' | carrier == 'DL', arr_delay > 0) %>% # Desconsidera sem atrasos
  select(carrier, arr_delay) %>% 
  group_by(carrier) %>% 
  #sample(10000) %>%  # Essa linha dá erro de amostra maior do que a população
  ungroup()


View(pop_data)

# Exercício 2  - Crie duas amostras de 1000 observações cada uma a partir do 
# dataset pop_data apenas com dados da companhia DL para amostra 1 e apenas dados 
# da companhia UA na amostra 2

# Dica: inclua uma coluna chamada sample_id preenchida com número 1 para a primeira 
# amostra e 2 para a segunda amostra

amostra1 = sample_n(pop_data %>% 
                       filter(carrier == 'DL') %>% 
                       select(carrier, arr_delay) %>% 
                       mutate(sample_id = 1),
                     1000
                    )

amostra2 = sample_n(pop_data %>% 
                      filter(carrier == 'UA') %>% 
                      select(carrier, arr_delay) %>% 
                      mutate(sample_id = 2),
                    1000
                    )

# Resposta
amostra1 = na.omit(pop_data) %>% 
  select(carrier, arr_delay) %>% 
  filter(carrier == 'DL') %>% 
  mutate(sample_id = 1) %>% 
  sample_n(1000)

amostra2 = na.omit(pop_data) %>% 
  select(carrier, arr_delay) %>% 
  filter(carrier == 'UA') %>% 
  mutate(sample_id = 2) %>% 
  sample_n(1000)



View(amostra1)

View(amostra2)

# Exercício 3 - Crie um dataset contendo os dados das 2 amostras criadas no item anterior. 

amostras = rbind(amostra1, amostra2)
View(amostras)

# Resposta
sample <- rbind(amostra1, amostra2)

# Exercício 4 - Calcule o intervalo de confiança (95%) da amostra1

# Usamos a fórmula: erro_padrao_amostra1 = sd(amostra1$arr_delay) / sqrt(nrow(amostra1))

# Esta fórmula é usada para calcular o desvio padrão de uma distribuição da média amostral
# (de um grande número de amostras de uma população). Em outras palavras, só é aplicável 
# quando você está procurando o desvio padrão de médias calculadas a partir de uma amostra de 
# tamanho n𝑛, tirada de uma população.

# Digamos que você obtenha 10000 amostras de uma população qualquer com um tamanho de amostra de n = 2.
# Então calculamos as médias de cada uma dessas amostras (teremos 10000 médias calculadas).
# A equação acima informa que, com um número de amostras grande o suficiente, o desvio padrão das médias 
# da amostra pode ser aproximado usando esta fórmula: sd(amostra) / sqrt(nrow(amostra))
  
# Deve ser intuitivo que o seu desvio padrão das médias da amostra será muito pequeno, 
# ou em outras palavras, as médias de cada amostra terão muito pouca variação.

# Com determinadas condições de inferência (nossa amostra é aleatória, normal, independente), 
# podemos realmente usar esse cálculo de desvio padrão para estimar o desvio padrão de nossa população. 
# Como isso é apenas uma estimativa, é chamado de erro padrão. A condição para usar isso como 
# uma estimativa é que o tamanho da amostra n é maior que 30 (dado pelo teorema do limite central) 
# e atende a condição de independência n <= 10% do tamanho da população.

# Erro padrão
erro_padrao_amostra1 = sd(amostra1$arr_delay) / sqrt(nrow(amostra1))

# Limites inferior e superior
# 1.96 é o valor de z score para 95% de confiançatamanho <- nrow(amostra1)
tamanho <- nrow(amostra1)
media <- mean(amostra1$arr_delay)

# Intervalo de confiança - valores passados como parametro 5% / 2 . 
# O primeiro é o limite inferior e o segundo (1 - resultado), é o limite superior
ic_1 = media + qt(c(0.025, 0.975), df = tamanho - 1) * erro_padrao_amostra1
print(ic_1)
print(media)

# Cálculo do IC by R
icr_1 <- t.test(amostra1$arr_delay)
print(icr_1)

# ----------
# Resposta
lower <- media - 1.96 * erro_padrao_amostra1
upper <- media + 1.96 * erro_padrao_amostra1

ic__1 <- c(lower, upper)
print(ic__1)

# Exercício 5 - Calcule o intervalo de confiança (95%) da amostra2
# Erro padrão
erro_padrao_amostra2 = sd(amostra2$arr_delay) / sqrt(nrow(amostra2))

tamanho2 <- nrow(amostra2)
media2 <- mean(amostra2$arr_delay)

ic_2 = media2 + qt(c(0.025, 0.975), df = tamanho2 - 1) * erro_padrao_amostra2
print(ic_2)
print(media2)

# Cálculo do IC by R
icr_2 <- t.test(amostra2$arr_delay)
print(icr_2)

# Resposta
lower <- media2 - 1.96 * erro_padrao_amostra2
upper <- media2 + 1.96 * erro_padrao_amostra2

ic__2 <- c(lower, upper)
print(ic__2)
print(media2)

# Exercício 6 - Crie um plot Visualizando os intervalos de confiança criados nos itens anteriores
# Dica: Use o geom_point() e geom_errorbar() do pacote ggplot2

ggplot(data = amostras,
       aes(arr_delay, colour = sample_id),
       fill = sample_id) +
  stat_function(fun = dnorm, 
                n = tamanho, 
                args = list(mean = mean(amostras$arr_delay), sd = sd(amostras$arr_delay))) + 
  ylab("amostras") +
  scale_y_continuous(breaks = NULL)

ggplot(data = amostra1,
       aes(arr_delay, colour = sample_id),
       fill = sample_id) +
  stat_function(fun = dnorm, 
                n = tamanho, 
                args = list(mean = mean(amostra1$arr_delay), sd = sd(amostra1$arr_delay))) + 
  ylab("amostras_1") +
  scale_y_continuous(breaks = NULL)

ggplot(data = amostra2,
       aes(arr_delay, colour = sample_id),
       fill = sample_id) +
  stat_function(fun = dnorm, 
                n = tamanho, 
                args = list(mean = mean(amostra2$arr_delay), sd = sd(amostra2$arr_delay))) + 
  ylab("amostras_2") +
  scale_y_continuous(breaks = NULL)



# ----------
# Resposta
toPlot <- summarise(group_by(sample, sample_id), mean = mean(arr_delay))
typeof(toPlot)

toPlot <- mutate(toPlot, lower = ifelse(toPlot$sample_id == 1, ic__1[1], ic__2[1]))
toPlot <- mutate(toPlot, upper = ifelse(toPlot$sample_id == 1, ic__1[2], ic__2[2]))

ggplot(toPlot,
       aes(x=sample_id, y=mean, colour = sample_id)) +
  geom_point() +
  geom_errorbar(aes(ymin=lower, ymax=upper), width = .1)
  
  

# Exercício 7 - Podemos dizer que muito provavelmente, as amostras vieram da mesma população? 
# Por que?
# Sim porque a maior parte dos dados reside no mesmo intervalo de confiança das duas amostras


# Exercício 8 - Crie um teste de hipótese para verificar se os voos da Delta Airlines (DL)
# atrasam mais do que os voos da UA (United Airlines)

# H0 e H1 devem ser mutuamente exclusivas.

# H0 = DL possui o mesma média de atrasos do que a UA
# H1 = DL atrasa menos do que UA
# H1 = DL atrasa mais do que UA

# --------------
# Resposta 

# I Passos identicos aos anteriores
dl <- sample_n(filter(pop_data, carrier == 'DL', arr_delay > 0), 1000)
ua <- sample_n(filter(pop_data, carrier == 'UA', arr_delay > 0), 1000)

# ---- DL
# Calcular erro padrão e média
se <- sd(dl$arr_delay) / sqrt(nrow(dl))
m_dl <- mean(dl$arr_delay)

# limites inferior e superior
lower = m_dl - 1.96 * se
upper = m_dl + 1.96 * se
ic_dl <- c(lower, upper)

# ------ UA
se <- sd(ua$arr_delay / sqrt(nrow(ua)))
m_ua <- mean(ua$arr_delay)

# limites inferior e superior
lower = m_ua - 1.96 * se
upper = m_ua + 1.96 * se
ic_ua <- c(lower, upper)

# --------- Comparação IC e Media
cat('DL:', m_dl, ic_dl)
cat('UA:', m_ua, ic_ua)

# II Teste t
t.test(dl$arr_delay, ua$arr_delay, alternative = 'greater')

# Estamos trabalhando com nível de confiança de 95%, ou seja, alfa = 0.05

# Baixo valor de p: forte evidência empírica contra h0
# Alto valor de p: pouco ou nenhuma evidência empírica contra h0

# Falhamos em rejeitar a hipótese nula, pois p-valor é maior q o nível de significância
# Isso qr dizer q há uma probabilidade alta de não haver diferença significativa entre os
# atrasos.
# Para os nossos dados, não há evidência estatística de que a DL atrase mais do que a UA
