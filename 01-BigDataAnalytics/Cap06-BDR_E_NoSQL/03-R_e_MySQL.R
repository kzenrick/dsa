setwd("~/Documentos/dsa/BigDataAnalytics/Cap06-BDR_E_NoSQL")
getwd()

library(RMySQL)
library(ggplot2)
library(dbplyr)
library(dplyr)

# Probema com conexão: Plugin caching_sha2_password, usar o comando abaixo
# ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'curso_dsa';

con8 = dbConnect(MySQL(),
                 user='root', 
                 password='curso_dsa', 
                 dbname='titanicDB', 
                 host='127.0.0.1',
                 port=63306)


con5 = dbConnect(MySQL(),
                user='root', 
                password='curso_go', 
                dbname='titanicDB', 
                host='127.0.0.1',
                port=53306)


# Query
qry <- "select pclass, survived, avg(age) as media_idade 
  from titanic 
  where survived = 1 
  group by pclass, survived;"

dbGetQuery(con8, qry)
dbGetQuery(con5, qry)

# Plot
dados <- dbGetQuery(con5, qry)
head(dados)
class(dados)

ggplot(dados, 
       aes(pclass, media_idade)) + 
  geom_bar(stat = "identity", fill = c('red3', 'pink', 'blue'))


# Conectando MYSQL com DPLYR
?src_mysql
con5 <- dplyr::src_mysql(user='root', 
                  password='curso_go', 
                  dbname='titanicDB', 
                  host='127.0.0.1',
                  port=53306)

con8 <- dplyr::src_mysql(user='root', 
                         password='curso_dsa', 
                         dbname='titanicDB', 
                         host='127.0.0.1',
                         port=63306)

# Coletando e agrupando os dados
dados28 <- con8 %>%
  tbl("titanic") %>%
  select(pclass, sex, age, survived, fare) %>%
  collect()

dados28 <- dados28 %>% filter(survived == 0) 

head(dados28)
#
dados25 <- con5 %>%
  tbl("titanic") %>%
  select(pclass, sex, age, survived, fare) %>%
  collect()

dados25 %>% filter(survived == 0) 

head(dados25)


# Manipulando dados
# Coletando e agrupando os dados
dados25 <- con5 %>%
  tbl("titanic") %>%
  select(pclass, sex, survived) %>%
  group_by(pclass, sex) %>%
  summarise(survival_ratio = avg(survived)) %>%
  collect() 


head(dados25, 10)

# Plot
ggplot(dados25,
       aes(pclass, survival_ratio, color = sex, group = sex)) +
  geom_point(size = 3) +
  geom_line()


dados28 <- con8 %>%
  tbl("titanic") %>%
  select(pclass, sex, survived) %>%
  group_by(pclass, sex) %>%
  summarise(survival_ratio = avg(survived)) %>%
  collect() 


head(dados28, 10)

# Plot
ggplot(dados28,
       aes(pclass, survival_ratio, color = sex, group = sex)) +
  geom_point(size = 3) +
  geom_line()

# Summarizando os dados
dados2 <- con2 %>%
  tbl("titanic") %>%
  select(pclass,sex,age,fare)

dados2 <- dados2 %>%
  filter(fare > 150)

dados2 %>%
  group_by(pclass,sex) %>%
  summarise(avg_age = avg(age),
            avg_fare = avg(fare)) 

head(dados2 )


qry <- '

select pclass, sex, avg(age) avg_age , avg(fare) avg_fare
from titanic
where fare > 150
group by pclass, sex
'
