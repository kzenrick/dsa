setwd("~/Projetos/Python/git/R/DSA/BigDataAnalytics/Cap02-Fundamentos")
getwd()

# String - aspas simples ou duplas
texto <- 'isto é uma string'
texto

x = as.character(3.14)
x
class(x)

# Concatenar
nome = "Nelson"; sobrenome = "Mandela"
paste(nome, sobrenome)
nome; sobrenome
cat(nome, sobrenome)

# Formatando a saída
sprintf('A %s é nota %d', 'DSA', 10)

# Extraindo parte da string
texto 
substring(texto, 12, 17)
substr(texto, stop = 3, start = 2)
?substring

# contando o número de caracteres
nchar(texto)

# Alterando Captalização
h <- "Histogramas e Elementos de Dados"
tolower(h)
toupper(h)

# usando stringer
library(stringr)
strsplit(h, NULL)
strsplit(h, ' ')
?strsplit

# Trabalhando com strings
string1 <- c('Esta é a primeira parte da minha string e será a primeira parte do meu vetor',
             'aqui minha string continua mas será a segunda parte do meu vetor')
string1
string2 <- c("Precisamos testar outras strings - @$$??!!!&&",
             "Análise de dados em R")
string2

# adicionar 2 strings
str_c(string1, string2)
str_c(c(string1, string2), sep=" ")

# Podemos contar qts vezes aparece o carcater s
str_count(string2, 's')

# Localiza a primeira e a última posição em que o caracter aparece
str_locate_all(string2, 's')

# Substitui a primeira ocorrência de um caracter
str_replace(string2, '\\s', '')

# Substitui todas as ocorrências de um caracter
str_replace_all(string2, '\\s', '')

# Detectando padrões nas strings
string1 <- '17 jan 2001'
string2 <- '1 jan 2001'
padrao <- 'jan 20'
grepl(pattern = padrao, x= string1)
padrao <- 'jan20'
grepl(pattern = padrao, x= string1)
