setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap07-ManipulacaoDados")
getwd()

# Instalando os pacotes
library(readr)
library(dplyr)

# install.packages('hflights')
library(hflights)
?hflights

# Criando um objeto tbl
?tbl_df
flights <- tbl_df(hflights)
flights

# Resumindo os dados
str(hflights)
glimpse(hflights)

# Visualizar como data frame
data.frame(head(flights))

# Filtrando os arquivos com slice
flights [flights$Month == 1 & flights$ DayofMonth == 1, ]

# Aplicando o filter
filter(flights, Month == 1, DayofMonth == 1)
filter(flights, UniqueCarrier == 'AA' | UniqueCarrier == 'UA')
filter(flights, UniqueCarrier %in% c('AA', 'UA'))
filter(flights, !UniqueCarrier %in% c('AA', 'UA'))

# Select
select(flights, Year:DayofMonth, contains('Taxi'), contains('Delay'))

# Organizando os dados
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(DepDelay)

flights %>%
  select(Distance, AirTime) %>%
  mutate(Speed = Distance /  AirTime * 60) 

head(
  with( # 
    flights, # base de dados
    tapply(
      ArrDelay, # Tempo de atraso, em minutos -> Valor a ser calculado
      Dest,     # Aeroporto de Destinio       -> índice de agrupamento
      mean,     # função que será executada   -> Função a ser chamada
      na.rm = T # Remoção de nulos
      )
  )
)

head(
  aggregate(ArrDelay ~ Dest, flights, mean)
)

flights %>%
  group_by(Month, DayofMonth) %>%
  tally(sort = T)
