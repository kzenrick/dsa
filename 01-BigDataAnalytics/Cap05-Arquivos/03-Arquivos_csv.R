setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap05-Arquivos")
getwd()

# usando o pacote readr
library(readr)

# Abre o prompr para escolher o arquivo
meu_arquivo <- read_csv(file.choose())

# Importando arquivos
df1 <- read_table("temperaturas.txt",
                  col_names = c("DAY", "MONTH", "YEAR", "TEMP"))
head(df1)
str(df1)
View(df1)

read_lines("temperaturas.txt", skip = 0, n_max = -1L)
read_lines("temperaturas.txt")

# Exportando e importando
write_csv(iris, "iris.csv")
dir(pattern = '\\.csv')

df_iris <- read_csv('iris.csv',
                    col_types = list(
                      Sepal.Length = col_double(),
                      Sepal.Width = col_double(),
                      Petal.Length = col_double(),
                      Petal.Width = col_double(),
                      Species = col_factor(c("setosa", "versicolor", "virginica"))
                    ))
dim(df_iris)
str(df_iris)
View(df_iris)

# Manipulando arquivos csv
df_cad <- read_csv("cadastro.csv")
View(df_cad)
class(df_cad)

library(dplyr)
options(warn = -1)

df_cad <- tbl_df(df_cad)
class(df_cad)
head(df_cad)
View(df_cad)

write.csv(df_cad, "df_cad_bkp.csv")
dir(pattern = '\\.csv')

# Importando vários arquivo simultaneamente
list.files()
lista_arquivos <- list.files(paste(getwd(), "/arquivos", sep = ''), full.names = T)
class(lista_arquivos)
lista_arquivos

lista_arquivos2 <- lapply(lista_arquivos, read_csv)
class(lista_arquivos2)
View(lista_arquivos2)

# Parsing
parse_date("01/02/15", "%m/%d/%y")
parse_date("01/02/15", "%d/%m/%y")
parse_date("01/02/34", "%y/%m/%d")
parse_date("01/02/04", "%y/%m/%d")

locale("en")
locale("fr")
locale("pt")
