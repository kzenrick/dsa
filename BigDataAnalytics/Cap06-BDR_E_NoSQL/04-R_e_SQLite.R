setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap06-BDR_E_NoSQL")
getwd()

library(RSQLite)

# remover o banco SQLite, caso exista - Não é obrigatório
if (file.exists('exemplo.db')){
  print('apagando')
  system('rm exemplo.db')
} else {
  print('não apagou')
}

# Criando driver
drv <- dbDriver('SQLite')
con <- dbConnect(drv, dbname = 'exemplo.db')
dbListTables(con)

# Criando uma tabela e carregando com dados do dataset mtcars
dbWriteTable(con, 'mtcars', mtcars, row.names = T)

# Listando uma tabela
dbListTables(con)
dbExistsTable(con, 'mtcars')
dbExistsTable(con, 'mtcars2')
dbListFields(con, 'mtcars')

# Lendo o conteúdo da tabela
dbReadTable(con, 'mtcars')

# Criando apenas a definição da tabela
dbWriteTable(con, 'mtcars2', mtcars[0,], row.names = T)
dbListTables(con)
dbReadTable(con, 'mtcars2')

# Executando consultas no BD
query = 'select row_names from mtcars'
rs = dbSendQuery(con, query)
dados = fetch(rs)
dados
class(dados)

# Executando consultas no BD - Listando
rs = dbSendQuery(con, query)
while (!dbHasCompleted(rs)){
  dados = fetch(rs, n = 1)
  print(dados$row_names)
}

# Executando consultas no BD
query = "select disp, hp from mtcars where disp > 160"
rs = dbSendQuery(con, query)
dados = fetch(rs, n = -1)
dados

# Executando consultas com group no BD[
query = 'select row_names, avg(hp) from mtcars group by row_names'
rs = dbSendQuery(con, query)
dados = fetch(rs)

# Criando tabela a partir de um arquivo
dbWriteTable(con, 'iris', 'iris.csv', sep = ',', header = T)
dbListTables(con)
dbReadTable(con, 'iris')

# Encerra a conexão
dbDisconnect(con)


# Carregando dados no banco de dados
# Criando driver
drv <- dbDriver('SQLite')
con <- dbConnect(drv, dbname = 'exemplo.db')

dbWriteTable(con, 
             'indices', 
             'indice.csv', 
             sep = '|', 
             header = T)
dbReadTable(con, 'indices')

dbRemoveTable(con, 'indices')

dbWriteTable(con, 
             'indices', 
             'indice.csv', 
             sep = '|', 
             header = T)
dbListTables(con)

dbReadTable(con, 'indices')

df <- dbReadTable(con, 'indices')
df
str(df)
sapply(df, class)

hist(df$setembro)
df_mean <- unlist(lapply(df[,c(4,5,6,7,8)], mean))
df_mean

dbDisconnect(con)