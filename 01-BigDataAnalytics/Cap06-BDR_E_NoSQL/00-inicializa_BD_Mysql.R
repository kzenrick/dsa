setwd("~/Documentos/dsa/BigDataAnalytics/Cap06-BDR_E_NoSQL")
getwd()

# -------------
# Conectar no bash do docker Mysql: docker exec -it mysql_curso_go bash
# Conectar no mysql: mysql -u root -p
# Senha: curso_go
#
# Liberar inserção dos dados:
# SET GLOBAL local_infile=1;

d <- read.csv('script/titanic.csv',
              header = F,
              col.names = c('pclass',
                             'survived',
                             'name',
                             'sex',
                             'age',
                             'sibsp',
                             'parch',
                             'ticket',
                             'fare',
                             'cabin',
                             'embarked',
                             'boat',
                             'body',
                             'home_dest'
                            )
              )

# install.packages("RMySQL")
library(RMySQL)

mydb = dbConnect(MySQL(),
                 user='root', 
                 password='curso_dsa', 
                 dbname='titanicDB', 
                 host='127.0.0.1',
                 port=63306)

dbWriteTable(mydb,
            'titanic',
            d,
            append = T,
            row.names = F)
