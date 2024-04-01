setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap05-Arquivos")
getwd()

# Usando as funções bases (pacote utils)
search()

# Importando arquivo com read.table()
?read.table

# Sem Parametros
df1 <- read.table("pedidos.txt")
df1
dim(df1)

# Especificando separador e cabeçalho
df1 <- read.table("pedidos.txt", header = T, sep = ',')
df1
dim(df1)

# Alterando nome das colunas
df1 <- read.csv("pedidos.txt", header = T, sep = ',',
                col.names = c("var1", "var2", "var3"))
df1

# Setando NA.strings
df1 <- read.csv("pedidos.txt", header = T, sep = ',',
                col.names = c("var1", "var2", "var3"),
                na.strings = c('Zico', 'Maradona')
                )
df1

str(df1)

# Alterando string as factor
df1 <- read.csv("pedidos.txt", header = T, sep = ',',
                col.names = c("var1", "var2", "var3"),
                na.strings = c('Zico', 'Maradona'),
                stringsAsFactors = F
                )
df1
str(df1)

# Importando arquivo com read.csv()
df2 <- read.csv("pedidos.txt")
df2
dim(df2)

df3 <- read.csv2("pedidos.txt")
df3
dim(df3)

df3 <- read.csv2("pedidos.txt", sep = ',')
df3
dim(df3)


# Importando arquivo com read.delim()
df4 <- read.delim("pedidos.txt")
df4

df4 <- read.delim("pedidos.txt", sep = ',')
df4

# Importando / Exportando
# Gerando arquivo
write.table(mtcars, file = 'mtcars.txt')
dir(pattern = '\\.txt')

df_mtcars <- read.table('mtcars.txt')
df_mtcars
dim(df_mtcars)

write.table(mtcars, 'mtcars2.txt', sep = '|', col.names = NA, qmethod = "double")
list.files(pattern = '\\.txt')

read.table('mtcars2.txt')
df_mtcars2 <- read.table('mtcars2.txt')
df_mtcars2

df_mtcars2 <- read.table('mtcars2.txt', sep = '|')
df_mtcars2

df_mtcars2 <- read.table('mtcars2.txt', sep = '|', encoding = 'UTF-8')
df_mtcars2

