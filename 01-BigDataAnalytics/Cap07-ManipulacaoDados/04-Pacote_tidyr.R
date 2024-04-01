setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap07-ManipulacaoDados")
getwd()

library(tidyr)
library(ggplot2)

# Dados notas de disciplinas
dados <- data.frame(
  Nome = c('Geografia','Literatura', 'Biologia'),
  Regiao_A = c(97, 80, 84),
  Regiao_B = c(86, 90, 91)
)
dados
str(dados)

dados %>%
  gather( # Transforma a coluna em dados
    Regiao, 
    NotaFinal,
    Regiao_A:Regiao_B)

# Criando Dados
set.seed(10)
df2 <- data.frame(
  id = 1:4,
  acao = sample(rep(c('controle', 'tratamento') ,each = 2)),
  work.T1 = runif(4),
  home.T1 = runif(4),
  work.T2 = runif(4),
  home.T2 = runif(4)
  
)

df2

# reshape 1
df2_organizado1 <- df2 %>%
  gather(key, time, -id, -acao)

head(df2_organizado1, 8)

# reshape 2
df2_organizado2 <- df2_organizado1 %>%
  separate(key, into = c('localidade', 'tempo'), sep = '\\.')

head(df2_organizado2, 8)

# Mais um exemplo
set.seed(1)
df3 <- data.frame(
  participante = c('p1', 'p2', 'p3', 'p4', 'p5', 'p6'),
  info = c('glm', 'glm', 'glf', 'g2m', 'g2m', 'g2m'),
  day1score = rnorm(n=6, mean=80, sd=15),
  day2score = rnorm(n=6, mean=88, sd=8)
)
print(df3)

# Reshape dos dados
df3 %>%
  gather(day, score, c(day1score, day2score))

df3 %>%
  gather(day, score, c(day1score, day2score)) %>%
  spread(day, score)

df3 %>%
  gather(day, score, c(day1score, day2score)) %>%
  separate(col = info, into = c('group', 'gender'), sep = 2) 

df3 %>%
  gather(day, score, c(day1score, day2score)) %>%
  separate(col = info, into = c('group', 'gender'), sep = 2) %>%
  unite(infoAgain, group, gender)  

df3 %>%
  gather(day, score, c(day1score, day2score)) %>%
  separate(col = info, into = c('group', 'gender'), sep = 2) %>%
  ggplot(aes(x = day, y = score)) +
  geom_point() +
  facet_wrap(~ group) +
  geom_smooth(method = 'lm', aes(group = 1), se = F)
