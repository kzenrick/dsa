# Solução Lista de Exercícios - Capítulo 6

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("~/Documentos/dsa/BigDataAnalytics/Cap06-BDR_E_NoSQL")
getwd()


# Exercicio 1 - Instale e carregue os pacotes necessários para trabalhar com SQLite e R
library(RSQLite)
library(dplyr)

# Resposta +
library(dbplyr)

# Exercicio 2 - Crie a conexão para o arquivo mamiferos.sqlite em anexo a este script
drv <- dbDriver('SQLite')
con <- dbConnect(drv, dbname = 'mamiferos.sqlite')
dbListTables(con)

# Exercicio 3 - Qual a versão do SQLite usada no banco de dados?
# Dica: Consulte o help da função src_dbi()
?src_dbi
con %>% tbl(sql('select sqlite_version()'))

# RESPOSTA
src_dbi(con)

# Exercicio 4 - Execute a query abaixo no banco de dados e grave em um objeto em R:
# SELECT year, species_id, plot_id FROM surveys
qry <- 'SELECT year, species_id, plot_id FROM surveys'
df <- con %>% tbl(sql(qry))

df_2 <- con %>%dbSendQuery(qry)
# Deve-se fazer o fetc com o dbSendQuery


# Exercicio 5 - Qual o tipo de objeto criado no item anterior?
class(df)
typeof(df)

# LIST

class(df_2)
typeof(df_2)


# Exercicio 6 - Já carregamos a tabela abaixo para você. Selecione as colunas species_id, sex e weight com a seguinte condição:
# Condição: weight < 5
pesquisas <- tbl(con, "surveys")
pesquisas  %>% 
  select(species_id, sex, weight) %>% 
  filter(weight < '5')


# Exercicio 7 - Grave o resultado do item anterior em um objeto R. O objeto final deve ser um dataframe
df <- pesquisas  %>% 
  select(species_id, sex, weight) %>% 
  filter(weight < '5')
class(df)
typeof(df)

df <- as.data.frame(df)
class(df)
typeof(df)

# Exercicio 8 - Liste as tabelas do banco de dados carregado
dbListTables(con)

# Exercicio 9 - A partir do dataframe criado no item 7, crie uma tabela no banco de dados
dbWriteTable(con,
              'species_2',
             df)
dbListTables(con)


# Exercicio 10 - Imprima os dados da tabela criada no item anterior
dbReadTable(con, 'species_2')


