library(dplyr)
conf <- DBI::dbConnect(RSQLite::SQLite(), path = ":dbname:")

dbListTables(
  conf
)

copy_to(conf, nycflights13::flights, "flights",
  temporary = FALSE, 
  indexes = list(
    c("year", "month", "day"), 
    "carrier", 
    "tailnum",
    "dest"
  )
)


# Teclas de atalho
# Tecla de Atalho   |   Resultado
# ALT =-            |   <- 
# CTRL + SHFT + M   |   %>% 
# 

flights_db <- tbl(conf, "flights")


dbListTables(
  conf
)

flights_db

# Selecionar os campos
flights_db %>% select(year:day, dep_delay, arr_delay)

# Adicionar filtro
flights_db %>% 
  select(year:day, dep_delay, arr_delay) %>%
  filter(dep_delay > 240 & dep_delay <= 300)

# Usando regex no filtro
flights_db %>% 
  select(year:day, dep_delay, arr_delay) 
# Aopenas para data.frame
# %>%
#  filter(grepl(pattern = '\\d{2}', x = dep_delay))


# Agrupamento
flights_db %>%
  group_by(dest, carrier) %>%
  summarise(delay = mean(dep_time)
            ) 
# Uso de in no filtro - adicionar uma coluna com resultado constante
flights_db %>% 
  select(carrier, arr_delay) %>% 
  filter(carrier %in% c('UA', 'DL')) %>% 
  mutate(teste = 1)


# Extrair sql do dplyr
tailnum_delay_db <- flights_db %>%
  group_by(tailnum) %>%
  summarise(
  delay = mean(arr_delay),
            n = n()
  )   %>%
  filter(n > 100)%>%
  arrange(desc(delay))

# mostra apenas os valores nulos
flights_db %>% filter(is.na(arr_delay))

# mostrar os valores não nulos
flights_db %>% filter(!is.na(arr_delay))

# Não funciona em data_frame
tailnum_delay_db %>% show_query()

# Buscar dados do BD e popular uma variável
tailnum_delay <- tailnum_delay_db %>% collect()
tailnum_delay

# Mostrar os n primeiros registros
tailnum_delay %>% slice(1:5)

# Alterar o nome da coluna
# Tentar fazer a relação pelo nome dos campos
n = list(nome = sym("carrier"))
flights_db %>% select(carrier, !!!n)

# Se der  dplyr error n() should only be called in a data context:
# forçar uso do pacote:
churn %>% group_by(gender) %>% dplyr::summarise(n = n())